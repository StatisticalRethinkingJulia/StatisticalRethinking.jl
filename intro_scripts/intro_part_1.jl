# Load Julia packages (libraries) needed

using StatisticalRethinking, StanSample

ProjDir = @__DIR__

# Define the Stan language model

m1_1s = "
// Inferring a rate
data {
  int N;
  int<lower=0> k[N];
  int<lower=1> n[N];
}
parameters {
  real<lower=0,upper=1> theta;
}
model {
  // Prior distribution for θ
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
 
(sample_file, log_file) = stan_sample(sm, data=m1_1_data);

# Describe the draws

if !(sample_file == nothing)
  chn = read_samples(sm)

  println()
  show(chn)

  savefig(plot(chn), "$ProjDir/Fig-part_1.png")

end

# End of `intro/intro_part_1.jl`
