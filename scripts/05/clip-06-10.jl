# Load Julia packages (libraries) needed for clip

using StatisticalRethinking
using CSV, StanSample, DataFrames, Statistics
using KernelDensity, MonteCarloMeasurements
using StatsPlots

ProjDir = @__DIR__

# ### snippet 5.1

df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])

rethinking_data = "
    Location Divorce  Marriage.s MedianAgeMarriage.s
1    Alabama    12.7  0.02264406          -0.6062895
2     Alaska    12.5  1.54980162          -0.6866993
3    Arizona    10.8  0.04897436          -0.2042408
4   Arkansas    13.5  1.65512283          -1.4103870
5 California     8.0 -0.26698927           0.5998567
"

# Define the Stan language model

m5_2 = "
data {
  int N;
  vector[N] divorce_s;
  vector[N] marriage_s;
}
parameters {
  real a;
  real bM;
  real<lower=0> sigma;
}
model {
  vector[N] mu = a + bM * marriage_s;
  a ~ normal( 0 , 0.2 );
  bM ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  divorce_s ~ normal( mu , sigma );
}
";

# Define the SampleModel
tmpdir = ProjDir*"/tmp"
sm = SampleModel("m5_2", m5_2, tmpdir=tmpdir);

# Input data

m5_3_data = Dict(
  "N" => size(df, 1), 
  "divorce_s" => df[:, :Divorce_s],
  "marriage_s" => df[:, :Marriage_s] 
);

# Sample using cmdstan

rc = stan_sample(sm, data=m5_3_data);

if success(rc)

  # Describe the draws
  dfs = read_samples(sm; output_format=:dataframe)
  println("\nSample Particles summary:"); p = Particles(dfs); p |> display
  println("\nQuap Particles estimate:"); q = quap(dfs); display(q)

  # Rethinking results

  rethinking_results = "
          mean   sd  5.5% 94.5%
    a     0.00 0.11 -0.17  0.17
    bM    0.35 0.13  0.15  0.55
    sigma 0.91 0.09  0.77  1.05
  ";

  xbar = mean(df[:, :Marriage])
  xstd = std(df[:, :Marriage])
  ybar = mean(df[:, :Divorce])
  ystd = std(df[:, :Divorce])

  xi = minimum(df[:, :Marriage_s]):0.01:maximum(df[:, :Marriage_s])
  yi = mean(dfs[:, :a]) .+ mean(dfs[:, :bM]) .* xi
  mu = link(dfs, [:a, :bM], xi)
  mu_r = [rescale(mu[i], ybar, ystd) for i in 1:length(xi)]
  mu_means_r = [mean(mu_r[i]) for i in 1:length(xi)]

  bnds_range = [[minimum(mu_r[i]), maximum(mu_r[i])] for i in 1:length(xi)]
  bnds_quantile = [quantile(mu_r[i], [0.055, 0.945]) for i in 1:length(xi)]
  bnds_hpd = [hpdi(mu_r[i], alpha=0.11) for i in 1:length(xi)]
  
  plot()
  x_r = rescale(xi, xbar, xstd)
  plot!(x_r , mu_means_r)
  for i in 1:length(xi)
    plot!([x_r[i], x_r[i]], bnds_range[i],
      color=:lightgrey, leg=false)
  end
  scatter!(df[:, :Marriage], df[:, :Divorce],
    color=:darkgreen, leg=false)

  for i in 1:length(xi)
    plot!([x_r[i], x_r[i]], bnds_hpd[i],
      color=:grey, leg=false)
  end
  scatter!(df[:, :Marriage], df[:, :Divorce],
    color=:darkgreen, leg=false)

  savefig("$ProjDir/Fig-06-10.png")

end

# End of `05/clip-06-10.jl`
