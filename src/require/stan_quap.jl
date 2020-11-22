import StatsBase: sample
import MonteCarloMeasurements:Particles
import StatisticalRethinking: quap

"""

# QuapModel

"""
struct QuapModel
  sm::SampleModel
  names::Vector{Symbol}
  particles::NamedTuple
  coef::Vector{Float64}
  vcov::Matrix{Float64}
end

function quap(sm::SampleModel)
  s = read_samples(sm; output_format=:dataframe)
  n = Symbol.(names(s))
  p = quap(s)
  c = [mean(p[k]) for k in n]
  cvals = reshape(c, 1, length(n))
  v = Statistics.covm(Array(s), cvals)
  QuapModel(sm, n, p, c, v)
end

function Particles(qm::T; nsamples=4000) where {T <: QuapModel}
  d = Dict{Symbol, Particles}()
  p = Particles(nsamples, MvNormal(qm.coef, qm.vcov))
  for (ind, key) in enumerate(qm.names)
    d[key] = p[ind]
  end
  (;d...)
end

function sample(qm::QuapModel; nsamples=4000)
  d = DataFrame()
  p = Particles(qm; nsamples)
  for key in qm.names
    d[!, key] = p[key].particles
  end
  d
end

export
  QuapModel,
  quap,
  Particles,
  sample
