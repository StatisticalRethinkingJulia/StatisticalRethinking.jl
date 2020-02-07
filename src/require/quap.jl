using .KernelDensity, .MonteCarloMeasurements

import .StatsBase: sample
import .MonteCarloMeasurements: Particles

"""

# sample

Sample from a Particles object

### Method
```julia
sample(q::Particles, n; permute=true) 
```

### Required arguments
```julia
* `q::Particles`                : Particles object
* `n::Int`                      : Number of samples
```

### Optional argument
```julia
* permute::Bool=false`          : Sort sample 
```

This method uses `systematic_sample`.
See [MonteCarloMeasurements](https://baggepinnen.github.io/MonteCarloMeasurements.jl/latest/).

### Return values
```julia
* `result`                      : Vector of samples
```

"""
sample(q::Particles, n; permute=true) =
  systematic_sample(n, q, permute=permute)

function convert_a3d(a3d_array, cnames, ::Val{:particles};
    start=1, kwargs...)
  
  df = convert_a3d(a3d_array, cnames, Val(:dataframe))
  d = Dict{Symbol, typeof(Particles(size(df, 1), Normal(0.0, 1.0)))}()

  for var in names(df)
    dens = kde(df[:, var])
    mu = collect(dens.x)[findmax(dens.density)[2]]
    sigma = std(df[:, var], mean=mu)
    d[var] = Particles(size(df, 1), Normal(mu, sigma))
  end

  (; d...)

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
* `df::DataFrame`               : Dataframe generated from a chain
```

### Return values
```julia
* `result::NamedTuple`          : NamedTuple representing the quadratic approximation
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

	for var in names(df)
		dens = kde(df[:, var])
		mu = collect(dens.x)[findmax(dens.density)[2]]
		sigma = std(df[:, var], mean=mu)
		d[var] = Particles(size(df, 1), Normal(mu, sigma))
	end

	(; d...)

end

Particles(df::DataFrame) = MonteCarloMeasurements.Particles(Array(df))

export
	quap,
  Particles,
  NamedTuple

