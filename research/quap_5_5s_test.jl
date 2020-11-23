# Load Julia packages (libraries) needed.

using Pkg, DrWatson

@quickactivate "StstisticalRethinkingStan"
using StanSample
using StatisticalRethinking

using NamedTupleTools

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

q = quap(m5_5s)
r = rand(q.distr, 4000)'

mean(r, dims=1) |> display