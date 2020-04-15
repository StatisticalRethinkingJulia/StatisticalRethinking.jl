# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

# ### snippet 5.1

df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])

# Define the Stan language model

m_5_3_A = "
data {
  int N;
  vector[N] divorce_s;
  vector[N] marriage_s;
  vector[N] medianagemarriage_s;
}
parameters {
  real a;
  real bA;
  real bM;
  real aM;
  real bAM;
  real<lower=0> sigma;
  real<lower=0> sigma_M;
}
model {
  // A -> D <- M
  vector[N] mu = a + bA * medianagemarriage_s + bM * marriage_s;
  a ~ normal( 0 , 0.2 );
  bA ~ normal( 0 , 0.5 );
  bM ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  divorce_s ~ normal( mu , sigma );
  // A -> M
  vector[N] mu_M = aM + bAM * medianagemarriage_s;
  aM ~ normal( 0 , 0.2 );
  bAM ~ normal( 0 , 0.5 );
  sigma_M ~ exponential( 1 );
  marriage_s ~ normal( mu_M , sigma_M );
}
";

# Define the SampleModel
m5_3_As = SampleModel("m5.3_A", m_5_3_A);

# Input data

m5_3_A_data = Dict(
  "N" => size(df, 1), 
  "divorce_s" => df[:, :Divorce_s],
  "marriage_s" => df[:, :Marriage_s],
  "medianagemarriage_s" => df[:, :MedianAgeMarriage_s] 
);

# Sample using cmdstan

rc = stan_sample(m5_3_As, data=m5_3_A_data);

if success(rc)

  # Describe the draws

  dfa = read_samples(m5_3_As; output_format=:dataframe)
  Particles(dfa)

end
