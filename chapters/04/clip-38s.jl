using StatisticalRethinking, CmdStan, GLM
gr(size=(500,500))

ProjDir = rel_path("..", "scripts", "00")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

data = filter(row -> row[:age] >= 18, df)

first(data, 6)

n = size(data, 1)
test_ind = sample(1:n, Int(floor(0.3*n)), replace=false);
train_ind = [(i) for i=1:n if !(i in test_ind)];
test = data[test_ind, :];
train = data[train_ind, :];

train_cut = DataFrame(train)
test_cut = DataFrame(test)

train_label = train[:, :height]
test_label = test[:, :height]

remove_names = filter(x->!in(x, [:height, :age, :male]), names(data))

train = Matrix(train[:, remove_names]);
test = Matrix(test[:, remove_names]);

function standardize(x)
    return (x .- mean(x, dims=1)) ./ std(x, dims=1), x
end

function unstandardize(x, orig)
    return x .* std(orig, dims=1) .+ mean(orig, dims=1)
end

(train, train_orig) = standardize(train)
(test, test_orig) = standardize(test)
(train_label, train_l_orig) = standardize(train_label)
(test_label, test_l_orig) = standardize(test_label);

dmat = [ones(size(train, 1)) train]

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
  beta[1] ~ cauchy(0,10); // prior for the intercept following Gelman 2008

  for(i in 2:K)
   beta[i] ~ cauchy(0,2.5); // prior for the slopes following Gelman 2008

  y ~ normal(linpred,sigma);
}
";

stanmodel = Stanmodel(name="linear_regression",
  model=lrmodel, output_format=:mcmcchains);

lrdata = Dict("N" => size(train, 1), "K" => size(dmat, 2), "y" => train_label, "X" => dmat);

rc, chain, cnames = stan(stanmodel, lrdata, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

chns = set_section(chain, Dict(
    :parameters => ["beta.1", "beta.2", "sigma"],
    :linpred => ["linpred.$i" for i in 1:247],
    :internals => ["lp__", "accept_stat__", "stepsize__", "treedepth__",
      "n_leapfrog__", "divergent__", "energy__"]
  )
)

describe(chns)

ols = lm(@formula(height ~ weight), train_cut)

train_cut.OLSPrediction = predict(ols);
test_cut.OLSPrediction = predict(ols, test_cut);

function prediction(chn, x)
    α = Array(chn[Symbol("beta.1")]);
    β = Array(chn[Symbol("beta.2")]);
    return  mean(α) .+ x .* mean(β)
end

train_cut.BayesPredictions = unstandardize(prediction(chns, train), train_l_orig)[:,1];
test_cut.BayesPredictions = unstandardize(prediction(chns, test), test_l_orig)[:,1];

remove_names = filter(x->!in(x, [:age, :male]), names(test_cut));
test_cut = test_cut[remove_names];
first(test_cut, 6)

bayes_loss1 = sum((train_cut.BayesPredictions - train_cut.height).^2);
ols_loss1 = sum((train_cut.OLSPrediction - train_cut.height).^2);

bayes_loss2 = sum((test_cut.BayesPredictions - test_cut.height).^2);
ols_loss2 = sum((test_cut.OLSPrediction - test_cut.height).^2);

println("\nTraining set:")
println("  Bayes loss: $bayes_loss1")
println("  OLS loss: $ols_loss1")

println("Test set:")
println("  Bayes loss: $bayes_loss2")
println("  OLS loss: $ols_loss2")

#plot(chain)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

