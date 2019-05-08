using CmdStan, Turing,DynamicHMC,LogDensityProblems,Statistics
using Random,Distributions,Parameters,DataFrames,StatsPlots

include("chris_test_6a.jl")

Random.seed!(38445)

ProjDir = @__DIR__
cd(ProjDir)

Nsamples = 2000
Nadapt = 1000
Nchains = 1

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
   Sample(num_samples = Nsamples, num_warmup = Nadapt, adapt = CmdStan.Adapt(delta=0.8)
     ,save_warmup = false));

function timing(N, Niters)
  local t = fill(0.0, 3)
  local ttmp = fill(0.0, 3)
  local count = fill(0, 3)
  local success = fill(true, 3)
  local iter = 1
  local chns_t, chns_s, chns_d
  while iter <= Niters
    println("\nIter = $iter\n")
    sleep(1)
    global data = Dict("y" => rand(Normal(0,1),N), "N" => N)
    try
      ttmp[1] = @elapsed chns_t = sample(model(data["y"]), DynamicNUTS(Nsamples))
      success[1] = true
    catch e
      println("\ndNUTS: $(e)\n")
      count[1] += 1
      success[1] = false
    end
    try
      ttmp[2] = @elapsed trc, chns_s, cnames = stan(stanmodel, data, summary=false, ProjDir)
      success[3] = true
    catch e
      println("\nCmdStan: $(e)\n")
      count[2] += 1
      success[3] = false
    end
    try
      ttmp[3] = @elapsed chns_d = dhmc(data, Nsamples)
      success[3] = true
    catch e
      println("\ndHMC: $(e)\n")
      count[3] += 1
      success[3] = false
    end
    if success == [true, true, true]
      iter += 1
      t += ttmp
      show(chns_t)
      println()
      show(chns_s)
      println()
      show(chns_d)
      println()
    end
  end
  return (iter - 1), N, t, count
end

function dataLoop(Ns, nIter=50)
  df = DataFrame(Iters=Int64[], N=Int64[],
    dNUTS=Float64[], dNUTS_f=Int64[],
    CmdStan=Float64[], CmdStan_f=Int64[],
    dHMC=Float64[], dHMC_f=Int64[])
  for N in Ns
    iters, nObs, t, c = timing(N, nIter)
    println(iters, " ", nObs, " ", t,  " ", c )
    push!(df,vcat(iters, nObs, t[1], c[1], t[2], c[2], t[3], c[3]))
  end
  return df
end

Ns = [100, 200, 500, 1000, 1500]
df = dataLoop(Ns)
df2 = df[[:N, :Iters,:dNUTS,:CmdStan,:dHMC]]
summary = aggregate(df2, :N, mean)

gr()
sdf = stack(df2,[:dNUTS,:CmdStan,:dHMC])
rename!(sdf,:value=>:time,:variable=>:sampler)
@df sdf plot(:N,:time,group=:sampler,ylabel="Cummulative Time",
  xlabel="Data Points")
savefig("Comparison Sample Size.pdf")
