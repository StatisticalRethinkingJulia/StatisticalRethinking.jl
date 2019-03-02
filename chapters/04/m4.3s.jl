using StatisticalRethinking
using CmdStan, StanMCMCChains, JLD
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

weightsmodel = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] height; // Predictor
 vector[N] weight; // Outcome
}

parameters {
 real alpha; // Intercept
 real beta; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

model {
 height ~ normal(alpha + weight * beta , sigma);
}

generated quantities {
}
";

stanmodel = Stanmodel(name="weights", monitors = ["alpha", "beta", "sigma"],model=weightsmodel,
  output_format=:mcmcchains);

heightsdata = Dict("N" => length(df2[:height]), "height" => df2[:height],
  "weight" => df2[:weight]);

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME)

describe(chn)

serialize("m4.3s.jls", chn)

chn2 = deserialize("m4.3s.jls")

describe(chn2)

describe(chn2)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

