# ## Linear Regression

# ### Added snippet used as a reference for all models

# This model is based on the TuringTutorial example [LinearRegression](https://github.com/TuringLang/TuringTutorials/blob/csp/linear/LinearRegression.ipynb) by Cameron Pfiffer. 

# Turing is powerful when applied to complex hierarchical models, but it can also be put to task at common statistical procedures, like linear regression. This tutorial covers how to implement a linear regression model in Turing.

# We begin by importing all the necessary libraries.

# Import StratisticalRethinking.

using StatisticalRethinking, CmdStan, StanMCMCChain, GLM
gr(size=(500,500))

ProjDir = rel_path("..", "chapters", "00")
cd(ProjDir)

# We will use the mtcars dataset from the RDatasets package. mtcars contains a variety of statistics on different car models, including their miles per gallon, number of cylinders, and horsepower, among others.

# We want to know if we can construct a Bayesian linear regression model to predict the miles per gallon of a car, given the other statistics it has. Lets take a look at the data we have.

# Import the dataset.

data = RDatasets.dataset("datasets", "mtcars");

# Show the first six rows of the dataset.

first(data, 6)

# The next step is to get our data ready for testing. We'll split the mtcars dataset into two subsets, one for training our model and one for evaluating our model. Then, we separate the labels we want to learn (MPG, in this case) and standardize the datasets by subtracting each column's means and dividing by the standard deviation of that column.

# The resulting data is not very familiar looking, but this standardization process helps the sampler converge far easier. We also create a function called unstandardize, which returns the standardized values to their original form. We will use this function later on when we make predictions.

# Split our dataset 70%/30% into training/test sets.

train, test = MLDataUtils.splitobs(data, at = 0.7);

# Save dataframe versions of our dataset.

train_cut = DataFrame(train)
test_cut = DataFrame(test)

# Create our labels. These are the values we are trying to predict.

train_label = train[:, :MPG]
test_label = test[:, :MPG]

# Get the list of columns to keep.

remove_names = filter(x->!in(x, [:MPG, :Model]), names(data))

# Filter the test and train sets.

train = Matrix(train[:,remove_names]);
test = Matrix(test[:,remove_names]);

# A handy helper function to rescale our dataset.

function standardize(x)
    return (x .- mean(x, dims=1)) ./ std(x, dims=1), x
end

# Another helper function to unstandardize our datasets.

function unstandardize(x, orig)
    return x .* std(orig, dims=1) .+ mean(orig, dims=1)
end

# Standardize our dataset.

(train, train_orig) = standardize(train)
(test, test_orig) = standardize(test)
(train_label, train_l_orig) = standardize(train_label)
(test_label, test_l_orig) = standardize(test_label);

# Design matrix

dmat = [ones(size(train, 1)) train]

# Bayesian linear regression.

lrmodel = "
data {
  int N; //the number of observations
  int K; //the number of columns in the model matrix
  real y[N]; //the response
  matrix[N,K] X; //the model matrix
}
parameters {
  vector[K] beta; //the regression parameters
  real sigma; //the standard deviation
}
transformed parameters {
  vector[N] linpred;
  linpred <- X*beta;
}
model {  
  beta[1] ~ cauchy(0,10); //prior for the intercept following Gelman 2008

  for(i in 2:K)
   beta[i] ~ cauchy(0,2.5);//prior for the slopes following Gelman 2008
  
  y ~ normal(linpred,sigma);
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="linear_regression",
  monitors = ["beta.1", "beta.2", "beta.3", "beta.4", "beta.5", "beta.6", "beta.7", 
    "beta.8", "beta.9", "beta.10", "beta.11", "sigma"],
  model=lrmodel);

# Input data for cmdstan

lrdata = [
  Dict("N" => size(train, 1), "K" => size(dmat, 2), "y" => train_label, "X" => dmat)
];

# Sample using cmdstan
 
rc, sim, cnames = stan(stanmodel, lrdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);
  
# Convert to a MCMCChain Chain object

cnames = ["intercept", "beta[1]", "beta[2]", "beta[3]", "beta[4]", "beta[5]", "beta[6]", 
      "beta[7]", "beta[8]", "beta[9]", "beta[10]", "sigma"]
chain = convert_a3d(sim, cnames, Val(:mcmcchain))

# Plot the chains.

plot(chain)

# Describe the chains.

describe(chain)

# Perform multivariate OLS.

ols = lm(@formula(MPG ~ Cyl + Disp + HP + DRat + WT + QSec + VS + AM + Gear + Carb), train_cut)

# Store our predictions in the original dataframe.
train_cut.OLSPrediction = predict(ols);
test_cut.OLSPrediction = predict(ols, test_cut);

# Make a prediction given an input vector.

function prediction(chain, x)
    α = chain[:, 1, :].value
    β = [chain[:, i, :].value for i in 2:11]
    return  mean(α) .+ x * mean.(β)
end

# Calculate the predictions for the training and testing sets.

train_cut.BayesPredictions = unstandardize(prediction(chain, train), train_l_orig);
test_cut.BayesPredictions = unstandardize(prediction(chain, test), test_l_orig);

# Show the first side rows of the modified dataframe.

first(test_cut, 6)

bayes_loss1 = sum((train_cut.BayesPredictions - train_cut.MPG).^2)
ols_loss1 = sum((train_cut.OLSPrediction - train_cut.MPG).^2)

bayes_loss2 = sum((test_cut.BayesPredictions - test_cut.MPG).^2)
ols_loss2 = sum((test_cut.OLSPrediction - test_cut.MPG).^2)

println("Training set:")
println("  Bayes loss: $bayes_loss1")
println("  OLS loss: $ols_loss1")

println("Test set:")
println("  Bayes loss: $bayes_loss2")
println("  OLS loss: $ols_loss2")
