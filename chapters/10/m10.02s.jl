using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "10")
cd(ProjDir)

d = CSV.read(rel_path("..", "data", "chimpanzees.csv"), delim=';');
df = convert(DataFrame, d);

first(df, 5)

m_10_02_model = "
data{
    int N;
    int pulled_left[N];
    int prosoc_left[N];
}
parameters{
    real a;
    real bp;
}
model{
    vector[N] p;
    bp ~ normal( 0 , 10 );
    a ~ normal( 0 , 10 );
    for ( i in 1:N ) {
        p[i] = a + bp * prosoc_left[i];
        p[i] = inv_logit(p[i]);
    }
    pulled_left ~ binomial( 1 , p );
}
";

stanmodel = Stanmodel(name="m_10_02_model",
monitors = ["a", "bp"],
model=m_10_02_model, output_format=:mcmcchain);

m_10_02_data = Dict("N" => size(df, 1),
"pulled_left" => df[:pulled_left], "prosoc_left" => df[:prosoc_left]);

rc, chn, cnames = stan(stanmodel, m_10_02_data, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

rethinking = "
   mean   sd  5.5% 94.5% n_eff Rhat
a  0.04 0.12 -0.16  0.21   180 1.00
bp 0.57 0.19  0.30  0.87   183 1.01
";

describe(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

