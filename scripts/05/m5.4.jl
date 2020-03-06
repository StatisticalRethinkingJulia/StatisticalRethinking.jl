# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])

# Define the Stan language model

m_5_4 = "
data {
  int N;
  vector[N] medianagemarriage_s;
  vector[N] marriage_s;
}
parameters {
  real a;
  real bAM;
  real<lower=0> sigma;
}
model {
  vector[N] mu = a + bAM * medianagemarriage_s;
  a ~ normal( 0 , 0.2 );
  bAM ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  marriage_s ~ normal( mu , sigma );
}
";

# Define the SampleModel
m5_4s = SampleModel("m5.4", m_5_4);

# Input data

m5_4_data = Dict(
  "N" => size(df, 1), 
  "marriage_s" => df[:, :Marriage_s],
  "medianagemarriage_s" => df[:, :MedianAgeMarriage_s] 
);

# Sample using cmdstan

rc = stan_sample(m5_4s, data=m5_4_data);

if success(rc)

  # Describe the draws

  dfa4 = read_samples(m5_4s; output_format=:dataframe)

  # Rethinking results

  rethinking_results = "
           mean   sd  5.5% 94.5%
    a      0.00 0.09 -0.14  0.14
    bAM   -0.69 0.10 -0.85 -0.54
    sigma  0.68 0.07  0.57  0.79
  ";

  Particles(dfa4)
  quap(dfa4)

end
