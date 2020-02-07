# Load Julia packages (libraries) needed.

using StatisticalRethinking
using StanSample, CSV, DataFrames, Statistics
using StatsPlots

ProjDir = @__DIR__

# ### snippet 5.1

println()
df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';');
#df = CSV.read(joinpath(ProjDir, "..", "..", "data", "WaffleDivorce.csv"), delim=';');
first(df, 5) |> display
scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])

# ### snippet 5.1

std(df[!, :MedianAgeMarriage])
first(df, 5) |> display
println()

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
  vector[N] mu;            // mu is a vector
  a ~ normal(10, 10);      //Priors
  bA ~ normal(0, 0.5);
  sigma ~ uniform(0, 10);
  mu = a + bA * A;
  D ~ normal(mu , sigma);   // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

sm = SampleModel("MedianAgeDivorce", ad);

# Input data for cmdstan

ad_data = Dict("N" => size(df, 1), "D" => df[!, :Divorce],
    "A" => df[!, :MedianAgeMarriage_s]);

# Sample using StanSample

rc = stan_sample(sm, data=ad_data);

if success(rc)

  # Result rethinking

  rethinking = "
         mean   sd  5.5% 94.5% n_eff Rhat
  a      9.69 0.22  9.34 10.03  2023    1
  bA    -1.04 0.21 -1.37 -0.71  1882    1
  sigma  1.51 0.16  1.29  1.79  1695    1
  "

  # Plot regression line using means and observations

  xi = -3.0:0.01:3.0
  dfs = read_samples(sm; output_format=:dataframe)
  yi = mean(dfs[:, :a]) .+ mean(dfs[:, :bA])*xi

  scatter(df[!, :MedianAgeMarriage_s], df[!, :Divorce], color=:darkblue,
    xlab="Standardized median age of marriage",
    ylab="Standardize divorce rate")
  plot!(xi, yi, lab="Regression line")

  # shade(), abline() and link()

  mu = link(dfs, [:a, :bA], xi, mean(xi));
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
  scatter!(df[:, :MedianAgeMarriage_s], df[:, :Divorce], color=:darkblue)
  plot!(xi, yi, lab="Regression line")
  savefig("$ProjDir/Fig-01-05.png")

end

# End of `05/m5.1s.jl`

