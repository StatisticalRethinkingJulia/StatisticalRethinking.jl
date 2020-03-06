# Load Julia packages (libraries) needed.

using StatisticalRethinking
using CSV, DataFrames
using StanSample, MonteCarloMeasurements

ProjDir = @__DIR__

df = CSV.read(joinpath(ProjDir, "sports.csv"), delim=',');
scale!(df, [:C, :FL, :TM, :WUE, :PGP])
println()

m4 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] WUE; // Outcome
 vector[N] TM; // Predictor
 vector[N] PGP; // Predictor
 vector[N] FL; // Predictor
}

parameters {
 real a; // Intercept
 real bPGP; // Slope (regression coefficients)
 real bTM; // Slope (regression coefficients)
 real bFL; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;                 // mu is a vector
  a ~ normal(0, 0.2);           //Priors
  bPGP ~ normal(0, 0.5);
  bTM ~ normal(0, 0.5);
  bFL ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bPGP * PGP + bTM * TM + bFL * FL;
  WUE ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m4s = SampleModel("m4", m4);

# Input data for cmdstan

m4_data = Dict("N" => size(df, 1), "PGP" => df[:, :PGP_s],
    "TM" => df[:, :TM_s], "WUE" => df[:, :WUE_s], "FL" => df[:, :FL_s]);

# Sample using StanSample

rc = stan_sample(m4s, data=m4_data);

if success(rc)

  # Describe the draws

  dfa4 = read_samples(m4s; output_format=:dataframe)

  p4 = Particles(dfa4)

end
