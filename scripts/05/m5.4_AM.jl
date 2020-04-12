# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

df1 = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')

df = DataFrame(
  :A => df1[:, :MedianAgeMarriage],
  :M => df1[:, :Marriage],
  :D => df1[:, :Divorce]
 )

scale!(df, [:M, :A, :D])

# Define the Stan language model

m_5_4AM = "
data {
  int N;
  vector[N] A;
  vector[N] M;
}
parameters {
  real a;
  real bAM;
  real<lower=0> sigma;
}
model {
  vector[N] mu = a + bAM * M;
  a ~ normal( 0 , 0.2 );
  bAM ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  A ~ normal( mu , sigma );
}
";

# Define the SampleModel
#tmpdir=ProjDir*"/tmp"
m5_4_AM = SampleModel("m5.4", m_5_4AM);

# Input data

m5_4_data = Dict(
  "N" => size(df, 1), 
  "M" => df[:, :M_s],
  "A" => df[:, :A_s] 
);

# Sample using cmdstan

rc = stan_sample(m5_4_AM, data=m5_4_data);

if success(rc)

  # Describe the draws

  dfs_AM = read_samples(m5_4_AM; output_format=:dataframe)

  p_AM = Particles(dfs_AM)
  q_AM = quap(dfs_AM)

  p_AM |> display

end
