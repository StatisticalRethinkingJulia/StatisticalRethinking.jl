# Load Julia packages (libraries) needed.

using StatisticalRethinking, CmdStan

ProjDir = rel_path("..", "scripts", "05")

# ### snippet 5.1

wd = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';');
df = convert(DataFrame, wd);
df[!, :A] = scale(df[!, :MedianAgeMarriage]);
df[!, :D] = scale(df[!, :Divorce]);
first(df, 5)

# ### snippet 5.1

std(df[!, :MedianAgeMarriage])

ad = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] D; // Outcome
 vector[N] A; // Predictor
}

parameters {
 real a; // Intercept
 real bA; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

model {
  vector[N] mu;
  a ~ normal(0, 0.2);
  bA ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bA * A;
  D ~ normal(mu , sigma);
}
";

# Define the Stanmodel and set the output format to :mcmcchains.

m5_1s = Stanmodel(name="MedianAgeDivorce", model=ad);

# Input data for cmdstan

data = Dict("N" => length(df[!, :D]), "D" => df[!, :Divorce],
    "A" => df[!, :A]);

# Sample using cmdstan

rc, chn, cnames = stan(m5_1s, data, ProjDir, diagnostics=false,
  summary=true, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

MCMCChains.describe(chn)

# Plot the density of posterior draws

plot(chn)
savefig("$ProjDir/fig-01-05.1.pdf")

# Result rethinking

rethinking = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.69 0.22  9.34 10.03  2023    1
bA    -1.04 0.21 -1.37 -0.71  1882    1
sigma  1.51 0.16  1.29  1.79  1695    1
"

# Plot regression line using means and observations

xi = -3.0:0.01:3.0
rws, vars, chns = size(chn)
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))
yi = mean(alpha_vals) .+ mean(beta_vals)*xi

scatter(df[!, :A], df[!, :D], color=:darkblue,
  xlab="Standardized median age of marriage",
  ylab="Standardize divorce rate")
plot!(xi, yi, lab="Regression line")

# shade(), abline() and link()

mu = link(xi, chn, [1, 2], mean(xi));
yl = [minimum(mu[i]) for i in 1:length(xi)];
yh =  [maximum(mu[i]) for i in 1:length(xi)];
ym =  [mean(mu[i]) for i in 1:length(xi)];
pi = hcat(xi, yl, ym, yh);
pi[1:5,:]

plot!((xi, yl), color=:lightgrey, leg=false)
plot!((xi, yh), color=:lightgrey, leg=false)
for i in 1:length(xi)
  plot!([xi[i], xi[i]], [yl[i], yh[i]], color=:lightgrey, leg=false)
end
scatter!(df[!, :A], df[!, :D], color=:darkblue)
plot!(xi, yi, lab="Regression line")
savefig("$ProjDir/fig-01-05.2.pdf")

# End of `05/m5.1s.jl`

