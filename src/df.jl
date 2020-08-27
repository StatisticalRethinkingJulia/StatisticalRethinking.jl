import MonteCarloMeasurements:Particles

"""

# sample

Sample rows from a DataFrame

### Method
```julia
sample(df, n; replace, ordered) 
```

### Required arguments
```julia
* `df::DataFrame`                      : DataFrame
* `n::Int`                             : Number of samples
```

### Optional argument
```julia
* `rng::AbstractRNG`                   : Random number generator
* `replace::Bool=true`                 : Sample with replace 
* `ordered::Bool=false`                : Sort sample 
```

### Return values
```julia
* `result`                             : Array of samples
```

"""
function sample(df::DataFrame, n; replace=true, ordered=false)
  indxs = sample(Random.GLOBAL_RNG, 
    1:size(df,1), 
    n,
    replace=replace, ordered=ordered)
  df[indxs, :]
end

function sample(rng::AbstractRNG, df::DataFrame, n; replace=true, ordered=false)
  indxs = sample(rng,
    1:size(df,1), 
    n,
    replace=replace, ordered=ordered)
  df[indxs, :]
end

function Particles(df::DataFrame)

  d = Dict{Symbol, typeof(Particles(size(df, 1), Normal(0.0, 1.0)))}()

  for var in Symbol.(names(df))
    d[var] = Particles(df[:, var])
  end

  (;d...)

end


export
  sample,
  Particles
