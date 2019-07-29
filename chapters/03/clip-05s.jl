using StatisticalRethinking, CmdStan
#gr(size=(600,800));

ProjDir = rel_path("..", "scripts", "03")
cd(ProjDir)

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

stanmodel = Stanmodel(name="binomial", monitors = ["theta"], model=binomialstanmodel,
  output_format=:mcmcchains);

N2 = 4^2
d = Binomial(9, 0.66)
n2 = Int.(9 * ones(Int, N2))
k2 = rand(d, N2);

binomialdata = Dict("N" => length(n2), "n" => n2, "k" => k2);

rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

MCMCChains.describe(chn)

if rc == 0
  plot(chn)
end

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

