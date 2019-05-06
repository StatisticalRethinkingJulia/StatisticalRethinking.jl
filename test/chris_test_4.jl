using Turing,Parameters,Random,DynamicHMC,LogDensityProblems
Random.seed!(54448451)

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
    return LL
end


@model model1(y) = begin
    μ ~ Normal(0,1)
    σ ~ Truncated(Cauchy(0,1),0,Inf)
    N = length(y)
    for n in 1:N
        y[n] ~ Normal(μ,σ)
    end
end

#Function barrier in mydist
@model model2(y) = begin
    μ ~ Normal(0,1)
    σ ~ Truncated(Cauchy(0,1),0,Inf)
    y ~ mydist(μ,σ)
end

function sim(config, models...)
    times = fill(0.0,length(models))
    count = fill(0,length(models))
    for (i, model) in enumerate(models)
      iter = 1
      while iter <= 100
        data = rand(Normal(0,1),100)
        try
          println("\nIter = $iter (model $i)\n")
          times[i] += @elapsed sample(model(data),config)
          iter = iter+1
        catch e
          count[i] += 1
          println("\nCount = $(count[i]) (model $i)\n")
        end
      end
    end
    println(count)
    return times
end

Nsamples = 2000
Nadapt = 1000
δ = .85
#config = NUTS(Nsamples, Nadapt, δ )
config = Turing.DynamicNUTS(Nsamples)
times = sim(config, model1, model2)
