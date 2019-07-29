# Load Julia packages (libraries) needed

using StatisticalRethinking, CmdStan
#gr(size=(600,600));

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

# Define the Stanmodel and set the output format to :mcmcchains.

stanmodel = Stanmodel(name="binomial", monitors = ["theta"], model=binomialstanmodel,
  output_format=:mcmcchains);

# Use 16 observations

N2 = 15
d = Binomial(9, 0.66)
n2 = Int.(9 * ones(Int, N2));

# Show first 5 (generated) observations

k2 = rand(d, N2);
k2[1:min(5, N2)]

# Input data for cmdstan

binomialdata = Dict("N" => length(n2), "n" => n2, "k" => k2);

# Sample using cmdstan
 
rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

# Describe the draws

MCMCChains.describe(chn)

# Allocate array of Normal fits

fits = Vector{Normal{Float64}}(undef, 4)
for i in 1:4
  fits[i] = fit_mle(Normal, convert.(Float64, chn.value[:, 1, i]))
  println(fits[i])
end

# Plot the 4 chains

mu_avg = sum([fits[i].μ for i in 1:4]) / 4.0;
sigma_avg = sum([fits[i].σ for i in 1:4]) / 4.0;

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
  #savefig("m2.1s.pdf")
end

# Show the hpd region

hpd(chn, alpha=0.055)

# Compute the hpd bounds for plotting

d, p, c = size(chn);
theta = convert(Vector{Float64}, reshape(chn.value, (d*p*c)));
bnds = quantile(theta, [0.045, 0.945])

# Show hpd region

println("hpd bounds = $bnds\n")

# quadratic approximation

# Compute MAP, compare with CmndStan & MLE

tmp = convert(Array{Float64,3}, chn.value)
draws = reshape(tmp, (size(tmp, 1)*size(tmp, 3)),)

# Compute MAP

using Optim

x0 = [0.5]
lower = [0.2]
upper = [1.0]

inner_optimizer = GradientDescent()

function loglik(x)
  ll = 0.0
  ll += log.(pdf.(Beta(1, 1), x[1]))
  ll += sum(log.(pdf.(Binomial(9, x[1]), k2)))
  -ll
end

res = optimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))

# Summarize mean and sd estimates

# CmdStan mean and sd:

[mean(chn.value), std(chn.value)]

# MAP estimate and associated sd:

[Optim.minimizer(res)[1], std(draws, mean=mean(chn.value))]

# MLE of mean and sd:

[mu_avg, sigma_avg]

# Turing Chain &  89% hpd region boundaries

plot( x, pdf.(Normal( mu_avg , sigma_avg  ) , x ),
xlim=(0.0, 1.2), lab="Normal approximation using MLE")
plot!( x, pdf.(Normal( Optim.minimizer(res)[1] , std(draws, mean=mean(chn.value))) , x),
lab="Normal approximation using MAP")
density!(draws, lab="CmdStan chain")
vline!([bnds[1]], line=:dash, lab="hpd lower bound")
vline!([bnds[2]], line=:dash, lab="hpd upper bound")

# End of `02/clip_08s.jl`
