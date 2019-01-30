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
dcc[:neocortex_perc] = parse.(Float64, dcc[:neocortex_perc])

# Show first 5 rows

first(dcc, 5)

# Define the Stan language model

m5_5_model = "
data{
    int N;
    vector[N] kcal_per_g;
    vector[N] neocortex_perc;
}
parameters{
    real a;
    real bn;
    real sigma;
}
model{
    vector[N] mu = a + bn * neocortex_perc;
    sigma ~ uniform( 0 , 1 );
    bn ~ normal( 0 , 1 );
    a ~ normal( 0 , 100 );
    kcal_per_g ~ normal( mu , sigma );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m5_5_model",
monitors = ["a", "bn", "sigma"],
 model=m5_5_model, output_format=:mcmcchain);

# Input data for cmdstan

m5_5_data = Dict("N" => size(dcc, 1), 
  "kcal_per_g" => dcc[:kcal_per_g],
  "neocortex_perc" => dcc[:neocortex_perc]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m5_5_data, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

# Rethinking results

rethinking_results = "
        mean    sd   5.5%  94.5% n_eff  Rhat
a     -0.814 0.000 -0.815 -0.814     7 1.124
bn    -0.499 0.006 -0.508 -0.490     2 2.803
sigma  1.000 0.000  1.000  1.000    42 0.999
sigma  1.53 0.16  1.28  1.80  1121    1
"
# End of `05/5.5s.jl`
