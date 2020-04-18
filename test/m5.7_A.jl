# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

# ### snippet 5.1

# Define the Stan language model

m_5_7_A = "
data {
  int N;
  vector[N] K;
  vector[N] M;
  vector[N] NC;
}
parameters {
  real a;
  real bN;
  real bM;
  real aNC;
  real bMNC;
  real<lower=0> sigma;
  real<lower=0> sigma_NC;
}
model {
  // M -> K <- NC
  vector[N] mu = a + bN * NC + bM * M;
  a ~ normal( 0 , 0.2 );
  bN ~ normal( 0 , 0.5 );
  bM ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  K ~ normal( mu , sigma );
  // M -> NC
  vector[N] mu_NC = aNC + bMNC * M;
  aNC ~ normal( 0 , 0.2 );
  bMNC ~ normal( 0 , 0.5 );
  sigma_NC ~ exponential( 1 );
  NC ~ normal( mu_NC , sigma_NC );
}
";

# Define the SampleModel
m5_7_As = SampleModel("m5.7_A", m_5_7_A);

# Input data

m5_7_A_data = Dict(
  "N" => size(df, 1), 
  "K" => df[:, :K_s],
  "M" => df[:, :M_s],
  "NC" => df[:, :NC_s] 
);

# Sample using cmdstan

rc = stan_sample(m5_7_As, data=m5_7_A_data);

if success(rc)

  # Describe the draws

  dfa = read_samples(m5_7_As; output_format=:dataframe)
  p = Particles(dfa)
  display(p)

end
