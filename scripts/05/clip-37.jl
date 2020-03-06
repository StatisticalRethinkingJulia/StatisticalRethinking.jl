# Load Julia packages (libraries) needed.

using StatisticalRethinking
using CSV, DataFrames
using StanSample, MonteCarloMeasurements
using StatsPlots

ProjDir = @__DIR__

# ### snippet 5.29

println()
df = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
df = filter(row -> !(row[:neocortex_perc] == "NA"), df);
df[!, :neocortex_perc] = parse.(Float64, df[:, :neocortex_perc])
df[!, :lmass] = log.(df[:, :mass])
#first(df, 5) |> display

# ### snippet 5.1

scale!(df, [:kcal_per_g, :neocortex_perc, :lmass])
println()

m_5_6 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] K; // Outcome
 vector[N] M; // Predictor
}

parameters {
 real a; // Intercept
 real bM; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 0.2);           //Priors
  bM ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bM * M;
  K ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m5_6s = SampleModel("m5.6", m_5_6);

# Input data for cmdstan

m5_6_data = Dict("N" => size(df, 1), "M" => df[!, :lmass_s],
    "K" => df[!, :kcal_per_g_s]);

# Sample using StanSample

rc = stan_sample(m5_6s, data=m5_6_data);

if success(rc)

  # Describe the draws

  dfa6 = read_samples(m5_6s; output_format=:dataframe)
  p = Particles(dfa6)
  quap(dfa6) |> display

  xbar = mean(df[:, :lmass])
  xstd = std(df[:, :lmass])
  ybar = mean(df[:, :kcal_per_g])
  ystd = std(df[:, :kcal_per_g])

  xi = minimum(df[:, :lmass_s]):0.01:maximum(df[:, :lmass_s])
  yi = mean(dfa6[:, :a]) .+ mean(dfa6[:, :bM]) .* xi
  mu = link(dfa6, [:a, :bM], xi)
  mu_r = [rescale(mu[i], ybar, ystd) for i in 1:length(xi)]
  mu_means_r = [mean(mu_r[i]) for i in 1:length(xi)]

  bnds_range = [[minimum(mu_r[i]), maximum(mu_r[i])] for i in 1:length(xi)]
  bnds_quantile = [quantile(mu_r[i], [0.055, 0.945]) for i in 1:length(xi)]
  bnds_hpd = [hpdi(mu_r[i], alpha=0.11) for i in 1:length(xi)];
  
  title = "Kcal_per_g vs. log mass" * "\nshowing sample and hpd range"
  plot(xlab="log mass", ylab="Kcal_per_g",
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
  scatter!(df[:, :lmass], df[:, :kcal_per_g], leg=false, color=:darkblue)

  savefig("$(ProjDir)/Fig-37.png")
end
