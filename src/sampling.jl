using Random, StatsBase, DataFrames, MonteCarloMeasurements
import StatsBase: sample

"""

# sample

Sample rows from a DataFrame

### Method
```julia
sample(df, n; replace, ordered) 
```

### Required arguments
```julia
* `df::DataFrame`               : DataFrame
* `n::Int`                      : Number of samples
```

### Optional argument
```julia
* `rng::AbstractRNG`            : Random number generator
* `replace::Bool=true`          : Sample with replace 
* `ordered::Bool=false`         : Sort sample 
```

### Return values
```julia
* `result`                      : Array of samples
```

"""
function sample(df::DataFrame, n;
    replace=true, ordered=false)
  indxs = sample(Random.GLOBAL_RNG, 
    1:size(df,1), 
    n,
    replace=replace, ordered=ordered)
  df[indxs, :]
end

function sample(rng::AbstractRNG, df::DataFrame, n;
    replace=true, ordered=false)
  indxs = sample(rng,
    1:size(df,1), 
    n,
    replace=replace, ordered=ordered)
  df[indxs, :]
end


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
