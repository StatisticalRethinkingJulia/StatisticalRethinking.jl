using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

d = CSV.read(rel_path("..", "data", "rugged.csv"), delim=';');
df = convert(DataFrame, d);

dcc = filter(row -> !(ismissing(row[:rgdppc_2000])), df)
dcc[:log_gdp] = log.(dcc[:rgdppc_2000])
dcc[:cont_africa] = Array{Float64}(convert(Array{Int}, dcc[:cont_africa]))
dcc[:rugged] = convert(Array{Float64}, dcc[:rugged])
first(dcc[[:rugged, :cont_africa, :log_gdp]], 5)

m_8_1_model = "
data{
    int N;
    vector[N] log_gdp;
    vector[N] cont_africa;
    vector[N] rugged;
    vector[N] rugged_cont_africa;
}
parameters{
    real a;
    real bR;
    real bA;
    real bAR;
    real sigma;
}
model{
    vector[N] mu = a + bR * rugged + bA * cont_africa + bAR * rugged_cont_africa;
    sigma ~ uniform( 0 , 10 );
    bAR ~ normal( 0 , 10 );
    bA ~ normal( 0 , 10 );
    bR ~ normal( 0 , 10 );
    a ~ normal( 0 , 100 );
    log_gdp ~ normal( mu , sigma );
}
";

stanmodel = Stanmodel(name="m_8_1_model",
monitors = ["a", "bR", "bA", "bAR", "sigma"],
model=m_8_1_model, output_format=:mcmcchain);

m_8_1_data = Dict("N" => size(dcc, 1),
"log_gdp" => dcc[:log_gdp],  "rugged" => dcc[:rugged],
"cont_africa" => dcc[:cont_africa],
"rugged_cont_africa" => dcc[:rugged] .* dcc[:cont_africa] );

rc, chn, cnames = stan(stanmodel, m_8_1_data, ProjDir, diagnostics=false,
  summary=true, CmdStanDir=CMDSTAN_HOME);

rethinking = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.22 0.14  9.00  9.46   282    1
bR    -0.21 0.08 -0.33 -0.08   275    1
bA    -1.94 0.24 -2.33 -1.59   268    1
bAR    0.40 0.14  0.18  0.62   271    1
sigma  0.96 0.05  0.87  1.04   339    1
"

describe(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

