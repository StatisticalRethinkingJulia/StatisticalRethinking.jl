# Load Julia packages (libraries) needed for clip

using StatisticalRethinking
using CSV, DataFrames
using StanSample, MonteCarloMeasurements

ProjDir = @__DIR__

# ### snippet 5.1

df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])

# Define the Stan language model

m_5_2 = "
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
m5_2s = SampleModel("m5.2", m_5_2);

# Input data

m5_2_data = Dict(
  "N" => size(df, 1), 
  "divorce_s" => df[:, :Divorce_s],
  "marriage_s" => df[:, :Marriage_s] 
);

# Sample using cmdstan

rc = stan_sample(m5_2s, data=m5_2_data);

if success(rc)

  # Describe the draws

  dfa2 = read_samples(m5_2s; output_format=:dataframe)

  # Result rethinking

  rethinking = "
          mean   sd  5.5% 94.5%
    a     0.00 0.11 -0.17  0.17
    bM    0.35 0.13  0.15  0.55
    sigma 0.91 0.09  0.77  1.05
  "

  Particles(dfa2)
  
end
