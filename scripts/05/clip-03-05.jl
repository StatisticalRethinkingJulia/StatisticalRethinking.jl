# Load Julia packages (libraries) needed.

using StatisticalRethinking
using StanSample, CSV, DataFrames
using StatsPlots, Statistics
using KernelDensity, MonteCarloMeasurements

ProjDir = @__DIR__

# ### snippet 5.1

println()
df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';');

# ### snippet 5.1

scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])

left = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] D; // Outcome
 vector[N] A; // Predictor
}

parameters {
 real a; // Intercept
 real bA; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 0.2);         //Priors
  bA ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bA * A;
  //D ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

sm1 = SampleModel("MedianAgeMarriage", left);

# Input data for cmdstan

ad_data = Dict("N" => size(df, 1), "D" => df[!, :Divorce_s],
    "A" => df[!, :MedianAgeMarriage_s]);

# Sample using StanSample

rc = stan_sample(sm1, data=ad_data);

if success(rc)

  # Plot regression line using means and observations

  dfs = read_samples(sm1; output_format=:dataframe)
  xi = -3.0:0.1:3.0
  plot(xlab="Medium age marriage (scaled)", ylab="Divorce rate (scaled)",
    title="Showing 50 regression lines")
  for i in 1:50
    yi = mean(dfs[i, :a]) .+ dfs[i, :bA] .* xi
    plot!(xi, yi, color=:lightgrey, leg=false)
  end

  scatter!(df[:, :MedianAgeMarriage_s], df[!, :Divorce_s],
    color=:darkblue)

  savefig("$ProjDir/Fig-03-05.png")

end

# End of `05/clip-03-05.jl`
