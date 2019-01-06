# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)

# ### snippet 5.1

wd = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
df = convert(DataFrame, wd);
mean_ma = mean(df[:MedianAgeMarriage])
df[:MedianAgeMarriage] = convert(Vector{Float64},
  df[:MedianAgeMarriage]) .- mean_ma;
first(df, 5)

# Define the Stan language model

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

model {
  # priors
  a ~ normal(10, 10);
  bA ~ normal(0, 1);
  sigma ~ uniform(0, 10);
  
  # model
  divorce ~ normal(a + bA*median_age , sigma);
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="MedianAgeDivorce", monitors = ["a", "bA", "sigma"],
  model=ad_model, output_format=:mcmcchain);

# Input data for cmdstan

maddata = Dict("N" => length(df[:Divorce]), "divorce" => df[:Divorce],
    "median_age" => df[:MedianAgeMarriage]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, maddata, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

# Plot the density of posterior draws

plot(chn)

# Plot regression line using means and observations

xi = -3.0:0.1:3.0
rws, vars, chns = size(chn[:, 1, :])
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))
yi = mean(alpha_vals) .+ mean(beta_vals)*xi

scatter(df[:MedianAgeMarriage], df[:Divorce], lab="Observations",
  xlab="Median age of marriage", ylab="divorce")
plot!(xi, yi, lab="Regression line")

# Plot estimates using the N = [10, 50, 150, 352] observations

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

  p[i] = plot()
  for j in 1:N
    yi = alpha_vals[j] .+ beta_vals[j]*xi
    plot!(p[i], xi, yi, title="N = $N", color=:lightgrey)
  end
  p[i] = scatter!(p[i], df[1:N, :MedianAgeMarriage], df[1:N, :Divorce],
    leg=false, color=:darkblue, xlab="Median age of marriage")
end
plot(p..., layout=(2, 2))

# End of `05/clip_01s.jl`
