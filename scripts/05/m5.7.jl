# Load Julia packages (libraries) needed.

using StatisticalRethinking

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

m_5_7 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] K; // Outcome
 vector[N] NC; // Predictor
 vector[N] M; // Predictor
}

parameters {
 real a; // Intercept
 real bM; // Slope (regression coefficients)
 real bN; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 0.2);           //Priors
  bN ~ normal(0, 0.5);
  bM ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bM * M + bN * NC;
  K ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m5_7s = SampleModel("m5.7", m_5_7);

# Input data for cmdstan

m5_7_data = Dict("N" => size(df, 1), "M" => df[!, :lmass_s],
    "K" => df[!, :kcal_per_g_s], "NC" => df[!, :neocortex_perc_s]);

# Sample using StanSample

rc = stan_sample(m5_7s, data=m5_7_data);

if success(rc)

  # Describe the draws

  dfa7 = read_samples(m5_7s; output_format=:dataframe)
  println("Normal estimate:")
  p = Particles(dfa7) |> display
  println("Quap estimates:")
  quap(dfa7) |> display

end
