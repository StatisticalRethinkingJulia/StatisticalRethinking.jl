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

  # Describe the draws

  dfs = read_samples(sm1; output_format=:dataframe)
  println("\nSample Particles summary:"); p = Particles(dfs); p |> display
  println("\nQuap Particles estimate:"); q = quap(dfs); display(q)

  # Result rethinking

  rethinking = "
           mean   sd  5.5% 94.5%
    a      0.00 0.10 -0.16  0.16
    bA    -0.57 0.11 -0.74 -0.39
    sigma  0.79 0.08  0.66  0.91
  "

  # Plot regression line using means and observations

  xbar = mean(df[:, :MedianAgeMarriage])
  xstd = std(df[:, :MedianAgeMarriage])
  ybar = mean(df[:, :Divorce])
  ystd = std(df[:, :Divorce])

  xi = minimum(df[:, :MedianAgeMarriage_s]):0.01:maximum(df[:, :MedianAgeMarriage_s])
  yi = mean(dfs[:, :a]) .+ mean(dfs[:, :bA]) .* xi
  mu = link(dfs, [:a, :bA], xi)
  mu_r = [rescale(mu[i], ybar, ystd) for i in 1:length(xi)]
  mu_means_r = [mean(mu_r[i]) for i in 1:length(xi)]

  bnds_range = [[minimum(mu_r[i]), maximum(mu_r[i])] for i in 1:length(xi)]
  bnds_quantile = [quantile(mu_r[i], [0.055, 0.945]) for i in 1:length(xi)]
  bnds_hpd = [hpdi(mu_r[i], alpha=0.11) for i in 1:length(xi)]
  
  title = "Divorce rate vs. median age at marriage" * "\nshowing sample and hpd range"
  plot(xlab="Median age at marriage", ylab="Divorce rate",
    title=title)
  x_r = rescale(xi, xbar, xstd)

  for i in 1:length(xi)
    plot!([x_r[i], x_r[i]], bnds_range[i],
      color=:lightgrey, leg=false)
  end

  for i in 1:length(xi)
    plot!([x_r[i], x_r[i]], bnds_hpd[i],
      color=:grey, leg=false)
  end

  plot!(x_r , mu_means_r, color=:black)
  scatter!(df[:, :MedianAgeMarriage], df[:, :Divorce], color=:darkblue)

  savefig("$ProjDir/Fig-01-02.png")

end

# End of `05/clip-01-02.jl`
