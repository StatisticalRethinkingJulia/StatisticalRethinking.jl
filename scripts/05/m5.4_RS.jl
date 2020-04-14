# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

# Define the Stan language model

m_5_4RS = "
data {
  int N;
  vector[N] R;
  vector[N] S;
}
parameters {
  real a;
  real bRS;
  real<lower=0> sigma;
}
model {
  vector[N] mu = a + bRS * S;
  a ~ normal( 0 , 0.2 );
  bRS ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  R ~ normal( mu , sigma );
}
";

# Define the SampleModel
#tmpdir=ProjDir*"/tmp"
m5_4_RS = SampleModel("m5.4", m_5_4RS);

# Input data

m5_4_data = Dict(
  "N" => size(df, 1), 
  "R" => df[:, :R_s],
  "S" => df[:, :S_s] 
);

# Sample using cmdstan

rc = stan_sample(m5_4_RS, data=m5_4_data);

if success(rc)

  # Describe the draws

  dfs_RS = read_samples(m5_4_RS; output_format=:dataframe)

  p_RS = Particles(dfs_RS)
  q_RS = quap(dfs_RS)

  p_RS |> display

end
