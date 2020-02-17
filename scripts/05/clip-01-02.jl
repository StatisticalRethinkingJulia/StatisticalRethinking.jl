# Load Julia packages (libraries) needed.

using StatisticalRethinking
using StanSample, CSV, DataFrames
using StatsPlots, Statistics
using KernelDensity, MonteCarloMeasurements

ProjDir = @__DIR__

include("m5.1.jl")

# ### snippet 5.2

std(df[:, :MedianAgeMarriage]) |> display

if success(rc)

  # Describe the draws

  dfs = read_samples(m_5_1; output_format=:dataframe)
  println("\nSample Particles summary:"); p_m_5_1 = Particles(dfs); p_m_5_1 |> display
  println("\nQuap Particles estimate:"); q_m_5_1 = quap(dfs); display(q_m_5_1)

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
