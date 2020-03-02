# Load Julia packages (libraries) needed.

using StatisticalRethinking
using CSV, DataFrames
using StanSample, MonteCarloMeasurements

ProjDir = @__DIR__

df = CSV.read(joinpath(ProjDir, "sports.csv"), delim=',');
scale!(df, [:TM, :WUE, :C])
println()

m1 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] WUE; // Outcome
 vector[N] TM; // Predictor
 vector[N] C; // Predictor
}

parameters {
 real a; // Intercept
 real bC; // Slope (regression coefficients)
 real bTM; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 0.2);         //Priors
  bC ~ normal(0, 0.5);
  bTM ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bC * C + bTM * TM;
  WUE ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m1s = SampleModel("m1", m1);

# Input data for cmdstan

m1_data = Dict("N" => size(df, 1), "C" => df[:, :C_s],
    "TM" => df[:, :TM_s], "WUE" => df[:, :WUE_s]);

# Sample using StanSample

rc = stan_sample(m1s, data=m1_data);

if success(rc)

  # Describe the draws

  dfa1 = read_samples(m1s; output_format=:dataframe)

  p1 = Particles(dfa1)

end
