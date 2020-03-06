# Load Julia packages (libraries) needed.

using StatisticalRethinking
using CSV, DataFrames
using StanSample, MonteCarloMeasurements

ProjDir = @__DIR__

df = CSV.read(joinpath(ProjDir, "sports.csv"), delim=',');
scale!(df, [:C, :FL, :TM, :WUE, :PGP])
println()

m5 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] WUE; // Outcome
 vector[N] TM; // Predictor
 vector[N] PGP; // Predictor
 vector[N] FL; // Predictor
 vector[N] C; // Predictor
}

parameters {
 real a;     // Intercept
 real bPGP;  // Slope (regression coefficients)
 real bTM;   // Slope (regression coefficients)
 real bFL;   // Slope (regression coefficients)
 real bC;    // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;                 // mu is a vector
  a ~ normal(0, 0.2);           //Priors
  bPGP ~ normal(0, 0.5);
  bTM ~ normal(0, 0.5);
  bFL ~ normal(0, 0.5);
  bC ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bC * C + bPGP * PGP + bTM * TM + bFL * FL;
  WUE ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m5s = SampleModel("m5", m5);

# Input data for cmdstan

m5_data = Dict("N" => size(df, 1), "PGP" => df[:, :PGP_s],
    "TM" => df[:, :TM_s], "WUE" => df[:, :WUE_s],
    "FL" => df[:, :FL_s], "C" => df[:, :C]);

# Sample using StanSample

rc = stan_sample(m5s, data=m5_data);

if success(rc)

  # Describe the draws

  dfa5 = read_samples(m5s; output_format=:dataframe)

  p5 = Particles(dfa5)

end
