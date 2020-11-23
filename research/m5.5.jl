# Load Julia packages (libraries) needed.

using Pkg, DrWatson

@quickactivate "StstisticalRethinkingStan"
using StanSample
using StatisticalRethinking

df = DataFrame(CSV.File(sr_datadir("milk.csv")))
df = filter(row -> !(row[:neocortex_perc] == "NA"), df);
df[!, :neocortex_perc] = parse.(Float64, df[:, :neocortex_perc])
df[!, :lmass] = log.(df[:, :mass])
scale!(df, [:kcal_per_g, :neocortex_perc, :lmass])

# ### snippet 5.35

stan5_5 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] K; // Outcome
 vector[N] NC; // Predictor
}

parameters {
 real a; // Intercept
 real bN; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 0.2);           //Priors
  bN ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bN * NC;
  K ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m5_5s = SampleModel("m5.5", stan5_5);

# Input data for cmdstan

m5_5_data = Dict("N" => size(df, 1), "NC" => df[!, :neocortex_perc_s],
    "K" => df[!, :kcal_per_g_s]);

# Sample using StanSample

rc5_5s = stan_sample(m5_5s, data=m5_5_data);

if success(rc5_5s)

  # Describe the draws

  post5_5s_df = read_samples(m5_5s; output_format=:dataframe)
  part5_5s = read_samples(m5_5s; output_format=:particles)
  quap(m5_5s).particles |> display

end