using .KernelDensity, .MonteCarloMeasurements

import .StatsBase: sample

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

  d

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
* `result::Dict`                : Dictionary summarizing approximation
```

### Example
```julia

# Run stan_sample() on a SampleModel

if success(rc)
	
	chn = read_samples(sm)
	quap(DataFrame(chn))

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

	d

end

export
	quap
