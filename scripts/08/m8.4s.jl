# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

# Define the Stan language model

m_8_4_model = "
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
  mu = a1 + a2;
  y ~ normal( mu , sigma );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m_8_4_model", monitors = ["alpha", "mu", "sigma"],
model=m_8_4_model, output_format=:mcmcchain);

# Input data for cmdstan

m_8_4_data = Dict("N" => 100, "y" => rand(Normal(0, 1), 100));

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m_8_4_data, ProjDir, diagnostics=false,
  summary=true, CmdStanDir=CMDSTAN_HOME);
  
rethinking = "
        mean   sd  5.5% 94.5% n_eff Rhat
alpha 0.06 1.90 -2.22  2.49  1321    1
sigma 2.15 2.32  0.70  5.21   461    1
";

# Describe the draws

describe(chn)

# End of `08/m8.1s.jl`
