```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

## Linear Regression

### Added snippet used as a reference for all models

This model is based on the TuringTutorial example [LinearRegression](https://github.com/TuringLang/TuringTutorials/blob/csp/linear/LinearRegression.ipynb) by Cameron Pfiffer.

Turing is powerful when applied to complex hierarchical models, but it can also be put to task at common statistical procedures, like linear regression. This tutorial covers how to implement a linear regression model in Turing.

We begin by importing all the necessary libraries.

```@example clip-38.7s
using StatisticalRethinking, CmdStan, StanMCMCChain, GLM
gr(size=(500,500))

ProjDir = rel_path("..", "chapters", "00")
cd(ProjDir)
```

Import the dataset.

```@example clip-38.7s
howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
```

Use only adults

```@example clip-38.7s
data = filter(row -> row[:age] >= 18, df)
```

Show the first six rows of the dataset.

```@example clip-38.7s
first(data, 6)
```

The next step is to get our data ready for testing. We'll split the mtcars dataset into two subsets, one for training our model and one for evaluating our model. Then, we separate the labels we want to learn (MPG, in this case) and standardize the datasets by subtracting each column's means and dividing by the standard deviation of that column.

The resulting data is not very familiar looking, but this standardization process helps the sampler converge far easier. We also create a function called unstandardize, which returns the standardized values to their original form. We will use this function later on when we make predictions.

Split our dataset 70%/30% into training/test sets.

```@example clip-38.7s
train, test = MLDataUtils.splitobs(shuffleobs(data), at = 0.7);
```

Save dataframe versions of our dataset.

```@example clip-38.7s
train_cut = DataFrame(train)
test_cut = DataFrame(test)
```

Create our labels. These are the values we are trying to predict.

```@example clip-38.7s
train_label = train[:, :height]
test_label = test[:, :height]
```

Get the list of columns to keep.

```@example clip-38.7s
remove_names = filter(x->!in(x, [:height, :age, :male]), names(data))
```

Filter the test and train sets.

```@example clip-38.7s
train = Matrix(train[:, remove_names]);
test = Matrix(test[:, remove_names]);
```

A handy helper function to rescale our dataset.

```@example clip-38.7s
function standardize(x)
    return (x .- mean(x, dims=1)) ./ std(x, dims=1), x
end
```

Another helper function to unstandardize our datasets.

```@example clip-38.7s
function unstandardize(x, orig)
    return x .* std(orig, dims=1) .+ mean(orig, dims=1)
end
```

Standardize our dataset.

```@example clip-38.7s
(train, train_orig) = standardize(train)
(test, test_orig) = standardize(test)
(train_label, train_l_orig) = standardize(train_label)
(test_label, test_l_orig) = standardize(test_label);
```

Design matrix

```@example clip-38.7s
dmat = [ones(size(train, 1)) train]
```

Bayesian linear regression.

```@example clip-38.7s
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
```

Define the Stanmodel and set the output format to :mcmcchain.

```@example clip-38.7s; continued = true
stanmodel = Stanmodel(name="linear_regression",
  monitors = ["beta.1", "beta.2", "sigma"],
  model=lrmodel);
```

Input data for cmdstan

```@example clip-38.7s
lrdata = [
  Dict("N" => size(train, 1), "K" => size(dmat, 2), "y" => train_label, "X" => dmat)
];
```

Sample using cmdstan

```@example clip-38.7s; continued = true
rc, sim, cnames = stan(stanmodel, lrdata, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);
```

Convert to a MCMCChain Chain object

```@example clip-38.7s
cnames = ["intercept", "beta[1]", "sigma"]
chain = convert_a3d(sim, cnames, Val(:mcmcchain))
```

Describe the chains.

```@example clip-38.7s
describe(chain)
```

Perform multivariate OLS.

```@example clip-38.7s
ols = lm(@formula(height ~ weight), train_cut)
```

Store our predictions in the original dataframe.

```@example clip-38.7s
train_cut.OLSPrediction = predict(ols);
test_cut.OLSPrediction = predict(ols, test_cut);
```

Make a prediction given an input vector.

```@example clip-38.7s
function prediction(chain, x)
    α = chain[:, 1, :].value
    β = [chain[:, i, :].value for i in 2:2]
    return  mean(α) .+ x * mean.(β)
end
```

Calculate the predictions for the training and testing sets.

```@example clip-38.7s
train_cut.BayesPredictions = unstandardize(prediction(chain, train), train_l_orig);
test_cut.BayesPredictions = unstandardize(prediction(chain, test), test_l_orig);
#train_cut.BayesPredictions = prediction(chain, train);
#test_cut.BayesPredictions = prediction(chain, test);
```

Show the first side rows of the modified dataframe.

```@example clip-38.7s
remove_names = filter(x->!in(x, [:age, :male]), names(test_cut))
test_cut = test_cut[remove_names]
first(test_cut, 6) |> display

bayes_loss1 = sum((train_cut.BayesPredictions - train_cut.height).^2)
ols_loss1 = sum((train_cut.OLSPrediction - train_cut.height).^2)

bayes_loss2 = sum((test_cut.BayesPredictions - test_cut.height).^2)
ols_loss2 = sum((test_cut.OLSPrediction - test_cut.height).^2)

println("\nTraining set:")
println("  Bayes loss: $bayes_loss1")
println("  OLS loss: $ols_loss1")

println("Test set:")
println("  Bayes loss: $bayes_loss2")
println("  OLS loss: $ols_loss2")
```

Plot the chains.

```@example clip-38.7s
plot(chain)
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

