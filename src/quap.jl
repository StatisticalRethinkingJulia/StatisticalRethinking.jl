using NamedTupleTools

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

export
	quap
	