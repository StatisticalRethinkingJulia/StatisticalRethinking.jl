```@meta
CurrentModule = StatisticalRethinking
```

## `rel_path`
```@docs
rel_path(parts...)
```

## `link`
```@docs
link(dfa::DataFrame, vars, xrange)
link(dfa::DataFrame, vars, xrange, xbar) 
link(dfa::DataFrame, vars, xrange, xbar, ybar) 
```


## `rescale`
```@docs
rescale(x::Vector{Float64}, xbar::Float64, xstd::Float64)
```

## `quap`
```@docs
quap(df::DataFrame)
```

## `sample`
```@docs
sample(df::DataFrame, n; replace=true, ordered=false)
sample(rng::AbstractRNG, df::DataFrame, n; replace=true, ordered=false)
```

##`hpdi`
```@docs
hpdi(x::Vector{T}; alpha::Real=0.05) where {T<:Real}
```

##`plotcoef`
```@docs
plotcoef(models::Vector{SampleModel}, pars::Vector{Symbol}, fig::AbstractString, "", nothing)
plotcoef(model::SampleModel, pars::Vector{Symbol}, fig::AbstractString, "", nothing)```

##`pairsplot`
```@docs
pairsplot(df::DataFrame, vars::Vector{Symbol}, fig::AbstractString)
```

##`plotbounds`
```@docs
plotbounds
```

##`convert_a3d`
```@docs
convert_a3d(a3d_array, cnames, ::Val{:dataframe})
convert_a3d(a3d_array, cnames, ::Val{:dataframes})
```