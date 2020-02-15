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

scale!(df, [:WaffleHouses, :Divorce])
println()

wd = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] D; // Outcome (Divorce rate)
 vector[N] W; // Predictor ()
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
  mu = a + bA * W;
  D ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

sm1 = SampleModel("Fig5.1", wd);

# Input data for cmdstan

wd_data = Dict("N" => size(df, 1), "D" => df[:, :Divorce_s],
    "W" => df[:, :WaffleHouses_s]);

# Sample using StanSample

rc = stan_sample(sm1, data=wd_data);

if success(rc)

  # Plot regression line using means and observations

  dfs = read_samples(sm1; output_format=:dataframe)
  println("\nSample Particles summary:"); p = Particles(dfs); p |> display
  println("\nQuap Particles estimate:"); q = quap(dfs); display(q)

  xbar = mean(df[:, :WaffleHouses])
  xstd = std(df[:, :WaffleHouses])
  ybar = mean(df[:, :Divorce])
  ystd = std(df[:, :Divorce])

  xi = minimum(df[:, :WaffleHouses_s]):0.01:maximum(df[:, :WaffleHouses_s])
  yi = mean(dfs[:, :a]) .+ mean(dfs[:, :bA]) .* xi
  mu = link(dfs, [:a, :bA], xi)
  mu_r = [rescale(mu[i], ybar, ystd) for i in 1:length(xi)]
  mu_means_r = [mean(mu_r[i]) for i in 1:length(xi)]

  bnds_range = [[minimum(mu_r[i]), maximum(mu_r[i])] for i in 1:length(xi)]
  bnds_quantile = [quantile(mu_r[i], [0.055, 0.945]) for i in 1:length(xi)]
  bnds_hpd = [hpdi(mu_r[i], alpha=0.11) for i in 1:length(xi)]

  plot()
  scatter(df[:, :WaffleHouses], df[!, :Divorce], color=:darkblue,
    xlab="WaffleHouses",
    ylab="Divorce rate", xlim=(0.0, 60.0))
  plot!(xi, yi, lab="Regression line", color=:red)

  # shade(), abline() and link()

  plot()
  x_r = rescale(xi, xbar, xstd)
  plot!(x_r , mu_means_r)
  for i in 1:length(xi)
    plot!([x_r[i], x_r[i]], bnds_range[i],
      color=:lightgrey, leg=false)
  end

  for i in 1:length(xi)
    plot!([x_r[i], x_r[i]], bnds_hpd[i],
      color=:grey, leg=false)
  end
  scatter!(df[:, :WaffleHouses], df[:, :Divorce],
    color=:darkgreen, leg=false)

  savefig("$ProjDir/Fig-00.png")

end

# End of `05/m5.1s.jl`

