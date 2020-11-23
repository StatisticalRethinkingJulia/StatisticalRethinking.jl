import StatsBase: sample
import MonteCarloMeasurements:Particles
import StatisticalRethinking: quap

function quap(sm::SampleModel)
  s = read_samples(sm; output_format=:dataframe)
  ntnames = (:coef, :vcov, :converged, :distr, :params)
  n = Symbol.(names(s))
  coefnames = tuple(n...,)
  p = quap(s)
  c = [mean(p[k]) for k in n]
  cvals = reshape(c, 1, length(n))
  coefvalues = tuple(cvals...,)
  v = Statistics.covm(Array(s), cvals)

  ntvalues = tuple(
    namedtuple(coefnames, coefvalues),
    v, true, MvNormal(c, v), n
  )

  namedtuple(ntnames, ntvalues)
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
