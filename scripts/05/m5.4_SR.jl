# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

# Define the Stan language model

m_5_4SR = "
data {
  int N;
  vector[N] R;
  vector[N] S;
}
parameters {
  real a;
  real bSR;
  real<lower=0> sigma;
}
model {
  vector[N] mu = a + bSR * R;
  a ~ normal( 0 , 0.2 );
  bSR ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  S ~ normal( mu , sigma );
}
";

# Define the SampleModel
#tmpdir=ProjDir*"/tmp"
m5_4_SR = SampleModel("m5.4", m_5_4SR);

# Input data

m5_4_data = Dict(
  "N" => size(df, 1), 
  "R" => df[:, :R_s],
  "S" => df[:, :S_s] 
);

# Sample using cmdstan

rc = stan_sample(m5_4_SR, data=m5_4_data);

if success(rc)

  # Describe the draws

  dfs_SR = read_samples(m5_4_SR; output_format=:dataframe)

  p_SR = Particles(dfs_SR)
  q_SR = quap(dfs_SR)

  p_RS |> display

end
