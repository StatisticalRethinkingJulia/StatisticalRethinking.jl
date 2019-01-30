# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)

# Read the milk data

wd = CSV.read(rel_path("..", "data", "milk.csv"), delim=';')
df = convert(DataFrame, wd);
dcc = filter(row -> !(row[:neocortex_perc] == "NA"), df)
dcc[:kcal_per_g] = convert(Vector{Float64}, dcc[:kcal_per_g])
dcc[:log_mass] = log.(dcc[:mass])

# Show first 5 rows

first(dcc[[3, 7, 9]], 5)

# Define the Stan language model

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

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m5_5_model",
monitors = ["a", "bm", "sigma"],
 model=m5_6_model, output_format=:mcmcchain);

# Input data for cmdstan

m5_6_data = Dict("N" => size(dcc, 1), 
  "kcal_per_g" => dcc[:kcal_per_g],
  "log_mass" => dcc[:log_mass]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m5_6_data, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

# Rethinking results

rethinking_results = "
        mean    sd   5.5%  94.5% n_eff  Rhat
        mean   sd  5.5% 94.5% n_eff Rhat
 a      0.70 0.06  0.61  0.79   926 1.00
 bm    -0.03 0.02 -0.07  0.01   986 1.00
 sigma  0.18 0.04  0.13  0.25   628 1.01
";

# Describe the draws

describe(chn)

# End of `05/5.5s.jl`
