# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CSV, StanSample, DataFrames, Statistics
using KernelDensity, MonteCarloMeasurements
using StatsPlots

ProjDir = @__DIR__

# ### snippet 5.13
xr = 20:1:30
df = DataFrame(
  M = xr,
  D = 25 .+ 4 .* xr .+ rand(Normal(0, 8), length(xr))
)
scale!(df, [:M, :D])

# Define the Stan language model

link_test = "
data {
  int N;
  vector[N] D;
  vector[N] M;
}
parameters {
  real a;
  real bM;
  real<lower=0> sigma;
}
model {
  vector[N] mu = a + bM * M;
  a ~ normal( 0 , 0.2 );
  bM ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  D ~ normal( mu , sigma );
}
";

# Define the SampleModel
#tmpdir = ProjDir*"/tmp"
sm = SampleModel("link-test", link_test,
  #tmpdir=tmpdir
);

# Input data

test_data = Dict(
  "N" => size(df, 1), 
  "D" => df[:, :D_s],
  "M" => df[:, :M_s] 
);

# Sample using cmdstan

rc = stan_sample(sm, data=test_data);

import StatisticalRethinking: link

if success(rc)

  # Describe the draws
  dfs = read_samples(sm; output_format=:dataframe)
  println("\nSample Particles summary:"); p = Particles(dfs); p |> display
  println("\nQuap Particles estimate:"); q = quap(dfs); display(q)

  xbar = mean(df[:, :M])
  xstd = std(df[:, :M])
  ybar = mean(df[:, :D])
  ystd = std(df[:, :D])

  xi = minimum(df[:, :M_s]):0.1:maximum(df[:, :M_s])
  yi = mean(dfs[:, :a]) .+ mean(dfs[:, :bM]) .* xi
  mu = link(dfs, [:a, :bM], xi)
  mu_r = [rescale(mu[i], ybar, ystd) for i in 1:length(xi)]
  mu_means_r = [mean(mu_r[i]) for i in 1:length(xi)]

  bnds_range = [[minimum(mu_r[i]), maximum(mu_r[i])] for i in 1:length(xi)]
  bnds_quantile = [quantile(mu_r[i], [0.055, 0.945]) for i in 1:length(xi)]
  bnds_hpd = [hpdi(mu_r[i], alpha=0.11) for i in 1:length(xi)]

  p1 = plot()
  plot!(p1, xi, yi, lab="Regression line", color=:red)
  scatter!(p1, df[:, :M_s], df[:, :D_s],
    color=:darkblue, leg=false)

  p2 = plot()
  plot!(p2, xr, 25 .+ 4 .* xr)
  scatter!(p2, df[:, :M], df[:, :D],
    color=:darkred, leg=false)

  p3 = plot()
  x_r = rescale(xi, xbar, xstd)
  plot!(p3, x_r , mu_means_r)
  scatter!(p3, df[:, :M], df[:, :D],
    color=:darkgreen, leg=false)

  p4 = plot()
  x_r = rescale(xi, xbar, xstd)
  plot!(p4, x_r , mu_means_r)
  for i in 1:length(xi)
    plot!(p4, [x_r[i], x_r[i]], bnds_range[i], leg=false)
  end
  scatter!(p4, df[:, :M], df[:, :D],
    color=:darkgreen, leg=false)

  p5 = plot()
  x_r = rescale(xi, xbar, xstd)
  plot!(p5, x_r , mu_means_r)
  for i in 1:length(xi)
    plot!(p5, [x_r[i], x_r[i]], bnds_hpd[i], leg=false)
  end
  scatter!(p5, df[:, :M], df[:, :D],
    color=:darkgreen, leg=false)

  plot(p1, p2, p3, p4, p5, layout=(5, 1))
  savefig("$ProjDir/link-test.png")
  
end

# End of `05/clip-06-19.jl`
