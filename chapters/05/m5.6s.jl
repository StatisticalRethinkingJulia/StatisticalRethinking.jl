using StatisticalRethinking
using CmdStan, StanMCMCChain

ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)

wd = CSV.read(rel_path("..", "data", "milk.csv"), delim=';')
df = convert(DataFrame, wd);
dcc = filter(row -> !(row[:neocortex_perc] == "NA"), df)
dcc[:kcal_per_g] = convert(Vector{Float64}, dcc[:kcal_per_g])
dcc[:log_mass] = log.(dcc[:mass])

first(dcc[[3, 7, 9]], 5)

m5_6_model = "
data{
    real kcal_per_g[17];
    real log_mass[17];
}
parameters{
    real a;
    real bm;
    real sigma;
}
model{
    vector[17] mu;
    sigma ~ uniform( 0 , 1 );
    bm ~ normal( 0 , 1 );
    a ~ normal( 0 , 100 );
    for ( i in 1:17 ) {
        mu[i] = a + bm * log_mass[i];
    }
    kcal_per_g ~ normal( mu , sigma );
}
";

stanmodel = Stanmodel(name="m5_5_model",
monitors = ["a", "bm", "sigma"],
 model=m5_6_model, output_format=:mcmcchain);

m5_6_data = Dict("N" => size(dcc, 1),
  "kcal_per_g" => dcc[:kcal_per_g],
  "log_mass" => dcc[:log_mass]);

rc, chn, cnames = stan(stanmodel, m5_6_data, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

rethinking_results = "
        mean    sd   5.5%  94.5% n_eff  Rhat
        mean   sd  5.5% 94.5% n_eff Rhat
 a      0.70 0.06  0.61  0.79   926 1.00
 bm    -0.03 0.02 -0.07  0.01   986 1.00
 sigma  0.18 0.04  0.13  0.25   628 1.01
";

describe(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

