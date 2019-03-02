using StatisticalRethinking
using CmdStan, StanMCMCChains
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df)
df2[:height] = convert(Vector{Float64}, df2[:height]);
df2[:weight] = convert(Vector{Float64}, df2[:weight]);
df2[:weight_s] = (df2[:weight] .- mean(df2[:weight])) / std(df2[:weight]);
df2[:weight_s2] = df2[:weight_s] .^ 2;

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

stanmodel = Stanmodel(name="weights", monitors = ["a", "b1", "b2", "sigma"],
model=weightsmodel,  output_format=:mcmcchains);

heightsdata = Dict("N" => size(df2, 1), "height" => df2[:height],
"weight_s" => df2[:weight_s], "weight_s2" => df2[:weight_s2]);

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
CmdStanDir=CMDSTAN_HOME);

describe(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

