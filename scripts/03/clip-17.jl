# Load Julia packages (libraries) needed

using StatisticalRethinking, StanSample, Distributions, MCMCChains, StatsPlots

ProjDir = @__DIR__

# Define the Stan language model

m_17s = "
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

sm = SampleModel("m_17s", m_17s);

# Use 4 observations

N2 = 4
n2 = Int.(9 * ones(Int, N2))
k2 = [6, 5, 7, 6]

# Input data for cmdstan

m_17s_data = Dict("N" => length(n2), "n" => n2, "k" => k2);

# Sample using cmdstan
 
rc = stan_sample(sm, data=m_17s_data)

if success(rc)

  # Describe the draws
  chn = read_samples(sm; output_format=:mcmcchains)
  show(chn)

  # Look at area of hpd

  hpd(chn)

  # Plot the 4 chains

  mixeddensity(chn, xlab="height [cm]", ylab="density")
  bnds = hpd(chn[:,1,1])
  vline!([bnds[:lower]], line=:dash)
  vline!([bnds[:upper]], line=:dash)
  savefig("$(ProjDir)/Fig_17.png")

end

# End of `clip-17.jl`
