# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# ### snippet 4.7

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df)
df2[:height] = convert(Vector{Float64}, df2[:height]);
df2[:weight] = convert(Vector{Float64}, df2[:weight]);
df2[:weight_s] = (df2[:weight] .- mean(df2[:weight])) / std(df2[:weight]);
df2[:weight_s2] = df2[:weight_s] .^ 2;

# Define the Stan language model

weightsmodel = "
data{
    int N;
    real height[N];
    real weight_s2[N];
    real weight_s[N];
}
parameters{
    real a;
    real b1;
    real b2;
    real sigma;
}
model{
    vector[N] mu;
    sigma ~ uniform( 0 , 50 );
    b2 ~ normal( 0 , 10 );
    b1 ~ normal( 0 , 10 );
    a ~ normal( 178 , 100 );
    for ( i in 1:N ) {
        mu[i] = a + b1 * weight_s[i] + b2 * weight_s2[i];
    }
    height ~ normal( mu , sigma );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="weights", monitors = ["a", "b1", "b2", "sigma"],
model=weightsmodel,  output_format=:mcmcchain);

# Input data for cmdstan

heightsdata = Dict("N" => size(df2, 1), "height" => df2[:height],
"weight_s" => df2[:weight_s], "weight_s2" => df2[:weight_s2]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

# End of `m4.5s.jl`
