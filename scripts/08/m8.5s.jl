# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

# Define the Stan language model

m_8_5_model = "
data{
  int N;
  vector[N] y;
}
parameters{
  real sigma;
  real alpha;
  real a1;
  real a2;
}
model{
  real mu;
  a1 ~ normal(0, 10);
  a2 ~ normal(0, 10);
  mu = a1 + a2;
  y ~ normal( mu , sigma );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m_8_5_model", monitors = ["a1", "a2", "mu", "sigma"],
model=m_8_5_model, output_format=:mcmcchain);

# Input data for cmdstan

m_8_5_data = Dict("N" => 100, "y" => rand(Normal(0, 1), 100));

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m_8_5_data, ProjDir, diagnostics=false,
  summary=true, CmdStanDir=CMDSTAN_HOME);
  
rethinking = "
       mean   sd   5.5% 94.5% n_eff Rhat
a1    -0.08 7.15 -11.34 11.25  1680    1
a2    -0.05 7.15 -11.37 11.19  1682    1
sigma  0.90 0.07   0.81  1.02  2186    1
";

# Describe the draws

describe(chn)

# End of `08/m8.1s.jl`
