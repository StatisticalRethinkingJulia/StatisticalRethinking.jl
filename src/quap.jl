using NamedTupleTools

function mode_estimates(df::DataFrame)

  d = Dict{Symbol, typeof(Particles(size(df,1), Normal(0.9, 1.0)))}()

  for var in Symbol.(names(df))
    dens = kde(df[:, var])
    mu = collect(dens.x)[findmax(dens.density)[2]]
    sigma = std(df[:, var], mean=mu)
    d[var] = Particles(size(df, 1), Normal(mu, sigma))
  end

  (;d...)
end

"""

# quap

Quadratic approximation of a posterior distribution

### Method
```julia
quap(df) 
```

### Required arguments
```julia
* `df::DataFrame`                      : Dataframe generated from samples (chains)
```

### Return values
```julia
* `result::NamedTuple`                 : NamedTuple representing the quadratic approximation
```

To convert to a Dict use:
```julia
dct = Dict(pairs(result))
```

### Example
```julia

# Run stan_sample() on a SampleModel

if success(rc)
  
  df = read_samples(sm; output_format=:dataframe)
  q = quap(df)

end

```

"""
function quap(s::DataFrame)
  ntnames = (:coef, :vcov, :converged, :distr, :params)
  n = Symbol.(names(s))
  coefnames = tuple(n...,)
  p = mode_estimates(s)
  c = [mean(p[k]) for k in n]
  cvals = reshape(c, 1, length(n))
  coefvalues = tuple(cvals...,)
  v = Statistics.covm(Array(s), cvals)

  distr = if length(coefnames) == 1
    Normal(coefvalues[1], √v[1])  # Normal expects stddev
  else
    MvNormal(coefvalues, v)       # MvNormal expects variance matrix
  end

  ntvalues = tuple(
    namedtuple(coefnames, coefvalues),
    v, true, distr, n
  )

  namedtuple(ntnames, ntvalues)
end

export
	quap,
  mode_estimates
	