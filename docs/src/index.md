```@meta
CurrentModule = StatisticalRethinking
```

## sr\_path
```@docs
sr_path(parts...)
```

## sr\_datadir
```@docs
sr_datadir(parts...)
```

## link
```@docs
link
```

## rescale
```@docs
rescale(x::Vector{Float64}, xbar::Float64, xstd::Float64)
```

## sample
```@docs
sample(df::DataFrame, n; replace=true, ordered=false)
```

## hpdi
```@docs
hpdi(x::Vector{T}; alpha::Real=0.05) where {T<:Real}
```

## meanlowerupper
```@docs
meanlowerupper(data, PI = (0.055, 0.945))
```

## compare
```@docs
compare(m::Vector{Matrix{Float64}}, ::Val{:waic})
```

## create\_observation\_matrix
```@docs
create_observation_matrix(x::Vector, k::Int)
```

## r2\_is\_bad
```@docs
r2_is_bad(model::NamedTuple, df::DataFrame)
```

## PI
```@docs
PI
```

## var2
```@docs
var2(x)
```

## sim\_happiness
```docs
sim_happiness
```

## simulate
```@docs
simulate
```
