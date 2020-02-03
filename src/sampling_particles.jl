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
