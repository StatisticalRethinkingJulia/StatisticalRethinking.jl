using CmdStan, Turing,DynamicHMC,LogDensityProblems
using Random,Distributions,Parameters

Random.seed!(38445)

ProjDir = @__DIR__
cd(ProjDir)

Nsamples = 2000
Nadapt = 1000
Nchains = 1
N = 30

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

 function logpdf(dist::mydist,data::Array{Float64,1})
     @unpack μ,σ=dist
     LL = 0.0
     for d in data
         LL += logpdf(Normal(μ,σ),d)
     end
     isnan(LL) ? (return Inf) : (return LL) #not as robust as I thought
 end

 #Function barrier in mydist
 @model model(y) = begin
     μ ~ Normal(0,1)
     σ ~ Truncated(Cauchy(0,1),0,Inf)
     y ~ mydist(μ,σ)
 end


stanmodel = Stanmodel(
   name = "normstanmodel", model = normstanmodel, nchains = Nchains,
   Sample(num_samples = Nsamples-Nadapt, num_warmup = Nadapt, adapt = CmdStan.Adapt(delta=0.8)
     ,save_warmup = false));

function timing(model,stanmodel)
  t1 = 0.0
  t2 = 0.0
  iter = 1
  count = 0
  while iter <= 100
    println("\nIter = $iter\n")
    data = Dict("y" => rand(Normal(0,1),N),
      "N" => N)
    try
      t1tmp = @elapsed chn = sample(model(data["y"]), DynamicNUTS(Nsamples))
      t2tmp = @elapsed trc, chns, cnames = stan(stanmodel,data, summary=true, ProjDir)
      t1 += t1tmp
      t2 += t2tmp
      iter += 1
    catch e
      println(e)
      count += 1
    end
  end
  println(count)
  return t1,t2, iter, count
end

t1,t2, iter, count = timing(model,stanmodel)
println(t1/t2)
