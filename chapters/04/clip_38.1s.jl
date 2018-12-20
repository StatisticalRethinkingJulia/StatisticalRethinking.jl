# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,800))

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "chapters", "04")
cd(ProjDir)

# ### snippet 4.7

howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df)

# Define the Stan language model

weightsmodel = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] height; // Predictor
 vector[N] weight; // Outcome
}

parameters {
 real alpha; // Intercept
 real beta; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

transformed parameters {
  vector[N] mu; // Intermediate mu
  for (i in 1:N) 
    mu[i] = alpha + beta*weight[i];
}

model {
 height ~ normal(mu , sigma);
}

generated quantities {
} 
"

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="weights", monitors = ["alpha", "beta", "sigma"],model=weightsmodel,
  output_format=:mcmcchain)

# Input data for cmdstan

weightsdata = [
  Dict("N" => length(df2[:height]), "height" => df2[:height], "weight" => df2[:weight])
]

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, weightsdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME)

# Describe the draws

describe(chn)

# Compare with a previous result

clip_38s_example_output = "

Samples were drawn using hmc with nuts.
For each parameter, N_Eff is a crude measure of effective sample size,
and R_hat is the potential scale reduction factor on split chains (at
convergence, R_hat=1).

Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
          Mean         SD       Naive SE       MCSE     ESS
alpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000
 beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000
sigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000

Quantiles:
          2.5%       25.0%       50.0%       75.0%       97.5%
alpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750
 beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574
sigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417
sigma   3.9447100   4.1530675   4.254755   4.36483000   4.5871028

"

# Plot the density of posterior draws

plot(chn)

# Plot regression line using means and observations

xi = 30.0:0.1:65.0
rws, vars, chns = size(chn[:, 1, :])
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))
yi = mean(alpha_vals) .+ mean(beta_vals)*xi

scatter(df2[:weight], df2[:height], lab="Observations")
plot!(xi, yi, lab="Regression line")

# End of clip_38.1s.jl
