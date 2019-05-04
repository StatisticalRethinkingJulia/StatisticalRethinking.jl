using CmdStan, Turing, Plots,DataFrames
using StatsPlots, Random, MCMCDiagnostics

Random.seed!(12395391)

ProjDir = @__DIR__
cd(ProjDir)

Nsamples = 2000
Nadapt = 1000
N = 30
data = Dict("y" => rand(Normal(0,1),N),
  "N" => N)

 normstanmodel = "
 data {
   int<lower=0> N;
   vector[N] y;
 }
 parameters {
   real mu;
   real<lower=0> sigma;
 }
 model {
   mu ~ normal(0,1);
   sigma ~ cauchy(0,5);
   y ~ normal(mu,sigma);
 }
 "

@model model(y) = begin
    μ ~ Normal(0,1)
    σ ~ Truncated(Cauchy(0,5),0,Inf)
    for n = 1:length(y)
        y[n] ~ Normal(μ,σ)
    end
end

stanmodel = Stanmodel(
   name = "normstanmodel", model = normstanmodel, nchains = 4,
   Sample(num_samples = Nsamples-Nadapt, num_warmup = Nadapt, adapt = CmdStan.Adapt(delta=0.8)
     ,save_warmup = false));

initOutput() = DataFrame(μ=Float64[],σ=Float64[])
ess_array_MCMCChains_turing = initOutput()
ess_array_MCMCChains_cmdstan = initOutput()

rhat_array_MCMCChains_turing = initOutput()
rhat_array_MCMCChains_cmdstan = initOutput()

for i in 1:100
  chn = mapreduce(x->sample(model(data["y"]),
    NUTS(Nsamples, Nadapt, 0.8)), chainscat, 1:4)
  dft = describe(chn[(Nadapt+1):end,:,:])[1]
  push!(ess_array_MCMCChains_turing, dft[:ess])
  push!(rhat_array_MCMCChains_turing, dft[:r_hat])
  rc, chns, cnames = stan(stanmodel,data, summary=true, ProjDir)
  dfc = describe(chns)[1]
  push!(ess_array_MCMCChains_cmdstan, dfc[:ess])
  push!(rhat_array_MCMCChains_cmdstan, dfc[:r_hat])
end

essPlots = Plots.Plot[]
parms = names(ess_array_MCMCChains_turing)
for parm in parms
  p = plot(ylabel="ESS")
  plot!(p,ess_array_cmdstan[parm],title=parm,lab="Stan")
  plot!(p,ess_array_MCMCChains_cmdstan[parm],title=parm,lab="MCMCChains/Stan")
  plot!(p,ess_array_MCMCChains_turing[parm],title=parm,lab="Turing")
  plot!(p,ess_array_MCMCDiagnostics_cmdstan[parm],title=parm,lab="Turing")
  push!(essPlots,p)
end
plot(essPlots...)
savefig("ess__estimates_plot.pdf")

r̂Plots = Plots.Plot[]
for parm in parms
  p = plot(ylabel="r̂")
  plot!(p,rhat_array_MCMCChains_cmdstan[parm],title=parm,lab="Stan")
  plot!(p,rhat_array_MCMCChains_turing[parm],title=parm,lab="Turing")
  push!(r̂Plots,p)
end
plot(r̂Plots...)
savefig("rhat__estimates_plot.pdf")
