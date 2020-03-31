# # clip-05s.jl

# Load Julia packages (libraries) needed

using StatisticalRethinking
using MCMCChains, StatsPlots

ProjDir = @__DIR__
cd(ProjDir)

# Define the Stan language model

model_05s = "
// Inferring a Rate
data {
  int N;
  int<lower=0> k[N];
  int<lower=1> n[N];
}
parameters {
  real<lower=0,upper=1> theta;
  real<lower=0,upper=1> thetaprior;
}
model {
  // Prior Distribution for Rate Theta
  theta ~ beta(1, 1);
  thetaprior ~ beta(1, 1);

  // Observed Counts
  k ~ binomial(n, theta);
}
";

# Define the Stanmodel and set the output format to :mcmcchains.

sm = SampleModel("m_05s", model_05s);

# Use 16 observations

N2 = 4^2
d = Binomial(9, 0.66)
n2 = Int.(9 * ones(Int, N2))
k2 = rand(d, N2);

# Input data for cmdstan

m_05s_data = Dict("N" => length(n2), "n" => n2, "k" => k2);

# Sample using cmdstan
 
rc = stan_sample(sm, data=m_05s_data);

# Plot the 4 chains

if success(rc)

  # Describe the draws

  chn = read_samples(sm; output_format=:mcmcchains)
  show(chn)
  plot(chn)
  savefig("Fig-05.png")
  println()

  # Show Particles summary of theta and thetaprior

  dict = read_samples(sm; output_format=:particles)
  dict |> display

  # Notice in this example that the prior theta ("thetaprior"),
  # the `unconditioned-on-the data theta`, shows a mean of 0.5
  # and a std of 0.29.

end

# End of `03/clip-05.jl`
