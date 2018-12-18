# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,800))

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = @__DIR__
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

# Compare with previous result

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
          Mean         SD        Naive SE        MCSE      ESS
alpha -52.3556049 4.495309540 0.07107708466 0.12891271424 1000
 beta   0.6296834 0.029028623 0.00045898283 0.00083369936 1000
sigma   4.2600844 0.161340154 0.00255101182 0.00423406687 1000

Quantiles:
          2.5%       25.0%       50.0%       75.0%       97.5%   
alpha -60.9977275 -55.4675500 -52.409250 -49.20380000 -43.5227400
 beta   0.5723139   0.6094593   0.629823   0.64976425   0.6854141
sigma   3.9447100   4.1530675   4.254755   4.36483000   4.5871028

"

# Plot the density of posterior draws

plot(chn)

# Close cd(ProjDir) do block
