# Load Julia packages (libraries) needed.

using StatisticalRethinking
using CSV, DataFrames
using StanSample, MonteCarloMeasurements

ProjDir = @__DIR__

df = CSV.read(joinpath(ProjDir, "sports.csv"), delim=',');
scale!(df, [:TM, :WUE, :PGP])
println()

m3 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] WUE; // Outcome
 vector[N] TM; // Predictor
 vector[N] PGP; // Predictor
}

parameters {
 real a; // Intercept
 real bPGP; // Slope (regression coefficients)
 real bTM; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 0.2);         //Priors
  bPGP ~ normal(0, 0.5);
  bTM ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bPGP * PGP + bTM * TM;
  WUE ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m3s = SampleModel("m3", m3);

# Input data for cmdstan

m3_data = Dict("N" => size(df, 1), "PGP" => df[:, :PGP_s],
    "TM" => df[:, :TM_s], "WUE" => df[:, :WUE_s]);

# Sample using StanSample

rc = stan_sample(m3s, data=m3_data);

if success(rc)

  # Describe the draws

  dfa3 = read_samples(m3s; output_format=:dataframe)

  p3 = Particles(dfa3)

end
