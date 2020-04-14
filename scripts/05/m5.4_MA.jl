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

m_5_4 = "
data {
  int N;
  vector[N] A;
  vector[N] M;
}
parameters {
  real a;
  real bMA;
  real<lower=0> sigma;
}
model {
  vector[N] mu = a + bMA * A;
  a ~ normal( 0 , 0.2 );
  bMA ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  M ~ normal( mu , sigma );
}
";

# Define the SampleModel
m5_4_MA = SampleModel("m5.4", m_5_4);

# Input data

m5_4_data = Dict(
  "N" => size(df, 1), 
  "M" => df[:, :M_s],
  "A" => df[:, :A_s] 
);

# Sample using cmdstan

rc = stan_sample(m5_4_MA, data=m5_4_data);

if success(rc)

  # Describe the draws

  dfs_MA = read_samples(m5_4_MA; output_format=:dataframe)

  # Rethinking results

  rethinking_results = "
           mean   sd  5.5% 94.5%
    a      0.00 0.09 -0.14  0.14
    bAM   -0.69 0.10 -0.85 -0.54
    sigma  0.68 0.07  0.57  0.79
  ";

  p_MA = Particles(dfs_MA)
  q_MA = quap(dfs_MA)

  p_MA |> display

end
