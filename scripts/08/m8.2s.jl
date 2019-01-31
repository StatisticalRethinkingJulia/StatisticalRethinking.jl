# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

# Define the Stan language model

m_8_2_model = "
data{
    int N;
    vector[N] y;
}
parameters{
    real mu;
    real sigma;
}
model{
    y ~ normal( mu , sigma );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m_8_2_model", monitors = ["mu", "sigma"],
model=m_8_2_model, output_format=:mcmcchain);

# Input data for cmdstan

m_8_2_data = Dict("N" => 2, "y" => [-1, 1]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m_8_2_data, ProjDir, diagnostics=false,
  summary=true, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

# End of `08/m8.1s.jl`
