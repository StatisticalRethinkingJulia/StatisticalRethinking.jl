using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

d = CSV.read(rel_path("..", "data", "chimpanzees.csv"), delim=';');
df = convert(DataFrame, d);

first(df, 5)

m_10_01_model = "
data{
    int N;
    int pulled_left[N];
}
parameters{
    real a;
}
model{
    real p;
    a ~ normal( 0 , 10 );
    pulled_left ~ binomial( 1 , inv_logit(a) );
}
";

stanmodel = Stanmodel(name="m_10_01_model",
monitors = ["a"],
model=m_10_01_model, output_format=:mcmcchain);

m_10_01_data = Dict("N" => size(df, 1),
"pulled_left" => df[:pulled_left]);

rc, chn, cnames = stan(stanmodel, m_10_01_data, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

rethinking = "
  mean   sd  5.5% 94.5% n_eff Rhat
a 0.32 0.09 0.18  0.46   166    1
";

describe(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

