# Load Julia packages (libraries) needed

using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,800));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "02")
cd(ProjDir)

# Define the Stan language model

binomialstanmodel = "
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

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="binomial", monitors = ["theta"], model=binomialstanmodel,
  output_format=:mcmcchain);

# Use 16 observations

N2 = 4^2
d = Binomial(9, 0.66)
n2 = Int.(9 * ones(Int, N2));

# Show first 5 (generated) observations

k2 = rand(d, N2);
k2[1:5]

# Input data for cmdstan

binomialdata = Dict("N" => length(n2), "n" => n2, "k" => k2);

# Sample using cmdstan
 
rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

# Allocate array of Normal fits

fits = Vector{Normal{Float64}}(undef, 4)
for i in 1:4
  fits[i] = fit_mle(Normal, convert.(Float64, chn.value[:, 1, i]))
  println(fits[i])
end

# Plot the 4 chains

if rc == 0
  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
  x = 0:0.001:1
  for i in 1:4
    vals = convert.(Float64, chn.value[:, 1, i])
    μ = round(fits[i].μ, digits=2)
    σ = round(fits[i].σ, digits=2)
    p[i] = density(vals, lab="Chain $i density",
       xlim=(0.45, 1.0), title="$(N2) data points")
    plot!(p[i], x, pdf.(Normal(fits[i].μ, fits[i].σ), x), lab="Fitted Normal($μ, $σ)")
  end
  plot(p..., layout=(4, 1))
end

# End of `clip_08s.jl`
