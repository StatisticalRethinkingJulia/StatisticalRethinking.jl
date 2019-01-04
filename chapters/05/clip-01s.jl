using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "chapters", "05")
cd(ProjDir)

wd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..",
  "data", "WaffleDivorce.csv"), delim=';')
df = convert(DataFrame, wd);
mean_ma = mean(df[:MedianAgeMarriage])
df[:MedianAgeMarriage] = convert(Vector{Float64},
  df[:MedianAgeMarriage]) .- mean_ma;

ad_model = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] divorce; // Predictor
 vector[N] median_age; // Outcome
}

parameters {
 real a; // Intercept
 real bA; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

transformed parameters {
  vector[N] mu; // Intermediate mu
  for (i in 1:N)
    mu[i] = a + bA*median_age[i];
}

model {

  a ~ normal(10, 10);
  bA ~ normal(0, 1);
  sigma ~ uniform(0, 10);

  divorce ~ normal(mu , sigma);
}

generated quantities {
}
";

stanmodel = Stanmodel(name="MedianAgeDivorce", monitors = ["a", "bA", "sigma"],
  model=ad_model, output_format=:mcmcchain);

maddata = Dict("N" => length(df[:Divorce]), "divorce" => df[:Divorce],
    "median_age" => df[:MedianAgeMarriage]);

rc, chn, cnames = stan(stanmodel, maddata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

describe(chn)

plot(chn)

xi = -3.0:0.1:3.0
rws, vars, chns = size(chn[:, 1, :])
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))
yi = mean(alpha_vals) .+ mean(beta_vals)*xi

scatter(df[:MedianAgeMarriage], df[:Divorce], lab="Observations",
  xlab="Median age of marriage", ylab="divorce")
plot!(xi, yi, lab="Regression line")

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
nvals = [10, 20, 35, 50]

for i in 1:length(nvals)
  N = nvals[i]
  maddataN = Dict("N" => N, "divorce" => df[1:N, :Divorce],
      "median_age" => df[1:N, :MedianAgeMarriage]);
  rc, chnN, cnames = stan(stanmodel, maddataN, ProjDir, diagnostics=false,
    summary=false, CmdStanDir=CMDSTAN_HOME)

  xi = -3.0:0.1:3.0
  rws, vars, chns = size(chnN[:, 1, :])
  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))
  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))

  p[i] = scatter(df[1:N, :MedianAgeMarriage], df[1:N, :Divorce],
    leg=false, xlab="Median age of marriage")
  for j in 1:N
    yi = alpha_vals[j] .+ beta_vals[j]*xi
    plot!(p[i], xi, yi, title="N = $N")
  end
end
plot(p..., layout=(2, 2))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

