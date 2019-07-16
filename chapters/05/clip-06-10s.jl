using StanModels

ProjDir = rel_path_s("..", "scripts", "05")
cd(ProjDir)

wd = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
df = convert(DataFrame, wd);

mean_ma = mean(df[:Marriage])
df[:Marriage_s] = convert(Vector{Float64},
  (df[:Marriage]) .- mean_ma)/std(df[:Marriage]);

mean_mam = mean(df[:MedianAgeMarriage])
df[:MedianAgeMarriage_s] = convert(Vector{Float64},
  (df[:MedianAgeMarriage]) .- mean_mam)/std(df[:MedianAgeMarriage]);

df[1:6, [1, 7, 14, 15]]

rethinking_data = "
    Location Divorce  Marriage.s MedianAgeMarriage.s
1    Alabama    12.7  0.02264406          -0.6062895
2     Alaska    12.5  1.54980162          -0.6866993
3    Arizona    10.8  0.04897436          -0.2042408
4   Arkansas    13.5  1.65512283          -1.4103870
5 California     8.0 -0.26698927           0.5998567
"

m5_3 = "
data {
  int N;
  vector[N] divorce;
  vector[N] marriage_z;
  vector[N] median_age_z;
}
parameters {
  real a;
  real bA;
  real bM;
  real<lower=0> sigma;
}
model {
  vector[N] mu = a + median_age_z * bA + marriage_z * bM;
  sigma ~ uniform( 0 , 10 );
  bA ~ normal( 0 , 1 );
  bM ~ normal( 0 , 1 );
  a ~ normal( 10 , 10 );
  divorce ~ normal( mu , sigma );
}
";

stanmodel = Stanmodel(name="m5_3",
monitors = ["a", "bA", "bM", "sigma", "Divorce"],
 model=m5_3, output_format=:mcmcchains);

m5_3_data = Dict("N" => size(df, 1), "divorce" => df[:Divorce],
    "marriage_z" => df[:Marriage_s], "median_age_z" => df[:MedianAgeMarriage_s]);

rc, chn, cnames = stan(stanmodel, m5_3_data, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

describe(chn)

rethinking_results = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.69 0.22  9.34 10.03  1313    1
bR    -0.12 0.30 -0.60  0.35   932    1
bA    -1.13 0.29 -1.56 -0.67   994    1
sigma  1.53 0.16  1.28  1.80  1121    1
"

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

