using MonteCarloMeasurements
import StatisticalRethinking: quap

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
function quap(df::DataFrame)

  d = Dict{Symbol, typeof(Particles(size(df, 1), Normal(0.0, 1.0)))}()

  for var in Symbol.(names(df))
    dens = kde(df[:, var])
    mu = collect(dens.x)[findmax(dens.density)[2]]
    sigma = std(df[:, var], mean=mu)
    d[var] = Particles(size(df, 1), Normal(mu, sigma))
  end

  (; d...)

end

export
  quap
  
