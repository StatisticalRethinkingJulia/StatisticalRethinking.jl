using CmdStan, Turing,DynamicHMC,LogDensityProblems
using Random,Distributions,Parameters

include("chris_test_5a.jl")

Random.seed!(38445)

ProjDir = @__DIR__
cd(ProjDir)

Nsamples = 2000
Nadapt = 1000
Nchains = 1
N = 30
Niters = 100

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
   sigma ~ cauchy(0,1);
   y ~ normal(mu,sigma);
 }
 "

 import Distributions: logpdf
 mutable struct mydist{T1,T2} <: ContinuousUnivariateDistribution
     μ::T1
     σ::T2
 end

 function pdf(dist::mydist, x::Float64)
   @unpack μ,σ=dist
   pdf(Normal(μ,σ), x)
 end

 function logpdf(dist::mydist,data::Array{Float64,1})
     @unpack μ,σ=dist
     #=
     LL = 0.0
     for d in data
         LL += logpdf(Normal(μ,σ),d)
     end
     LL
     =#
     loglikelihood(mydist(μ, σ), data)
 end

 #Function barrier in mydist
 @model model(y) = begin
     μ ~ Normal(0,1)
     σ ~ Truncated(Cauchy(0,1),0,Inf)
     y ~ mydist(μ,σ)
 end


stanmodel = Stanmodel(
   name = "normstanmodel", model = normstanmodel, nchains = Nchains,
   Sample(num_samples = Nsamples, num_warmup = Nadapt, 
     adapt = CmdStan.Adapt(delta=0.8) ,save_warmup = false));

function timing(Niters, model,stanmodel)
  t = fill(0.0, 3)
  iter = fill(1, 3)
  count = fill(0, 3)
  while iter[1] <= Niters || iter[2] <= Niters || iter[3] <= Niters
    println("\nIter = $iter\n")
    global data = Dict("y" => rand(Normal(0,1),N), "N" => N)
    try
      if iter[1] <= Niters
        t1tmp = @elapsed chns_t = sample(model(data["y"]), DynamicNUTS(Nsamples))
        t[1] += t1tmp
        iter[1] += 1
        show(chns_t)
        println()
      end
    catch e
      println("\ndNUTS: $(e)\n")
      count[1] += 1
    end
    try
      if iter[2] <= Niters
        t2tmp = @elapsed trc, chns_s, cnames = stan(stanmodel, data, summary=false, ProjDir)
        t[2] += t2tmp
        iter[2] += 1
        show(chns_s)
        println()
      end
    catch e
      println("\nCmdStan: $(e)\n")
      count[2] += 1
    end
    try
      if iter[3] <= Niters
        t3tmp = @elapsed chns_d = dhmc(data, Nsamples)
        t[3] += t3tmp
        iter[3] += 1
        show(chns_d)
        println()
      end
    catch e
      println("\ndHMC: $(e)\n")
      count[3] += 1
    end
  end
  return t, (iter .- 1), count
end

t, iter, count = timing(Niters, model,stanmodel)
println([t..., iter..., count...])
