using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

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

stanmodel = Stanmodel(name="m_8_2_model", monitors = ["mu", "sigma"],
model=m_8_2_model, output_format=:mcmcchain);

m_8_2_data = Dict("N" => 2, "y" => [-1, 1]);

rc, chn, cnames = stan(stanmodel, m_8_2_data, ProjDir, diagnostics=false,
  summary=true, CmdStanDir=CMDSTAN_HOME);

describe(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

