# Load Julia packages (libraries) needed

using StatisticalRethinking, StanSample, MCMCChains

ProjDir = @__DIR__

# Define the Stan language model

m1_1s = "
// Inferring a Rate
data {
  int N;
  int<lower=0> k[N];
  int<lower=1> n[N];
}
parameters {
  real<lower=0,upper=1> theta;
}
model {
  // Prior Distribution for Rate Theta
  theta ~ beta(1, 1);

  // Observed Counts
  k ~ binomial(n, theta);
}
";

# Define the Stanmodel.

sm = SampleModel("m1.1s", m1_1s);

# Use 16 observations

N = 15
d = Binomial(9, 0.66)
k = rand(d, N)
n = repeat([9], N)

# Input data for cmdstan

m1_1_data = Dict("N" => N, "n" => n, "k" => k);

# Sample using cmdstan
 
rc = stan_sample(sm, data=m1_1_data);

# Collect the draws

if success(rc)
 chn = read_samples(sm; ouput_format=:mcmcchains);
end

println()
