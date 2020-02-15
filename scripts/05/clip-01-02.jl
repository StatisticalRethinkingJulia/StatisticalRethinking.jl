# Load Julia packages (libraries) needed.

using StatisticalRethinking
using StanSample, CSV, DataFrames
using StatsPlots, Statistics
using KernelDensity, MonteCarloMeasurements

ProjDir = @__DIR__

# ### snippet 5.1

println()
df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';');
first(df, 5) |> display

# ### snippet 5.1

scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])
println()

# ### snippet 5.2

std(df[:, :MedianAgeMarriage]) |> display

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
  D ~ normal(mu , sigma);     // Likelihood
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

  # Result rethinking

  rethinking = "
           mean   sd  5.5% 94.5%
    a      0.00 0.10 -0.16  0.16
    bA    -0.57 0.11 -0.74 -0.39
    sigma  0.79 0.08  0.66  0.91
  "

  # Plot regression line using means and observations

  dfs = read_samples(sm1; output_format=:dataframe)

  Particles(dfs) |> display
  println()
  q = quap(dfs)
  q |> display

  xi = 23.0:0.01:30.0
  yi = mean(df[:, :Divorce]) + mean(dfs[:, :a]) .+
    mean(dfs[:, :bA])*(xi .- mean(df[:, :MedianAgeMarriage]))

  scatter(df[:, :MedianAgeMarriage], df[!, :Divorce], color=:darkblue,
    xlab="Median age of marriage",
    ylab="Divorce rate")
  plot!(xi, yi, lab="Regression line", color=:red)

  # shade(), abline() and link()

  mu = link(dfs, [:a, :bA], xi, mean(dfs[:, :a]) + mean(df[:, :MedianAgeMarriage]));
  yl = [minimum(mu[i]) for i in 1:length(xi)] .+ mean(df[:, :Divorce])
  yh =  [maximum(mu[i]) for i in 1:length(xi)] .+ mean(df[:, :Divorce])
  ym =  [mean(mu[i]) for i in 1:length(xi)] .+ mean(df[:, :Divorce])
  pi = hcat(xi, yl, ym, yh);
  pi[1:5,:]

  plot!((xi, yl), color=:lightgrey, leg=false)
  plot!((xi, yh), color=:lightgrey, leg=false)
  for i in 1:length(xi)
    plot!([xi[i], xi[i]], [yl[i], yh[i]], color=:lightgrey, leg=false)
  end
  scatter!(df[:, :MedianAgeMarriage], df[:, :Divorce], color=:darkblue)
  plot!(xi, yi, lab="Regression line", color=:red)
  savefig("$ProjDir/Fig-01-02.png")

end

# End of `05/clip-01-02.jl`
