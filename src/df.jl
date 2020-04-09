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


"""
# convert_a3d

# Convert the output file(s) created by cmdstan to a single DataFrame.

"""
function convert_a3d(a3d_array, cnames, ::Val{:dataframe})
  # Inital DataFrame
  df = DataFrame(a3d_array[:, :, 1], Symbol.(cnames))

  # Append the other chains
  for j in 2:size(a3d_array, 3)
    df = vcat(df, DataFrame(a3d_array[:, :, j], Symbol.(cnames)))
  end
  df
end

"""

# convert_a3d

# Convert the output file(s) created by cmdstan to a Vector{DataFrame).

"""
function convert_a3d(a3d_array, cnames, ::Val{:dataframes})

  dfa = Vector{DataFrame}(undef, size(a3d_array, 3))
  for j in 1:size(a3d_array, 3)
    dfa[j] = DataFrame(a3d_array[:, :, j], Symbol.(cnames))
  end

  dfa
end

