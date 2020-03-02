# Load Julia packages (libraries) needed.

using StatisticalRethinking
using CSV, DataFrames
using StanSample, MonteCarloMeasurements

ProjDir = @__DIR__

df = CSV.read(joinpath(ProjDir, "sports.csv"), delim=',');
scale!(df, [:TM, :WUE, :FL])
println()

m2 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] WUE; // Outcome
 vector[N] TM; // Predictor
 vector[N] FL; // Predictor
}

parameters {
 real a; // Intercept
 real bFL; // Slope (regression coefficients)
 real bTM; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 0.2);         //Priors
  bFL ~ normal(0, 0.5);
  bTM ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bFL * FL + bTM * TM;
  WUE ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m2s = SampleModel("m2", m2);

# Input data for cmdstan

m2_data = Dict("N" => size(df, 1), "FL" => df[:, :FL_s],
    "TM" => df[:, :TM_s], "WUE" => df[:, :WUE_s]);

# Sample using StanSample

rc = stan_sample(m2s, data=m2_data);

if success(rc)

  # Describe the draws

  dfa2 = read_samples(m2s; output_format=:dataframe)

  p2 = Particles(dfa2)

end
