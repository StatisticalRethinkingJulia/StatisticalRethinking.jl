```@meta
CurrentModule = StatisticalRethinking
```

## `rel_path`
```@docs
rel_path(parts...)
```

## link
```@docs
link(dfa::DataFrame, vars, xrange)
```


## rescale
```@docs
rescale(x::Vector{Float64}, xbar::Float64, xstd::Float64)
```

## quap
```@docs
quap(df::DataFrame)
```

## sample
```@docs
sample(df::DataFrame, n; replace=true, ordered=false)
```

## hpdi
```@docs
hpdi(x::Vector{T}; alpha::Real=0.05) where {T<:Real}
```

## plotcoef
```@docs
plotcoef(models::Vector{SampleModel}, pars::Vector{Symbol}, fig::AbstractString, title="", func=nothing)
plotcoef(model::SampleModel, pars::Vector{Symbol}, fig::AbstractString, title="", func=nothing)
```

## pairsplot
```@docs
pairsplot(df::DataFrame, vars::Vector{Symbol}, fig::AbstractString)
```

## plotbounds
```@docs
plotbounds(
  df::DataFrame, 
  xvar::Symbol,
  yvar::Symbol, 
  dfs::DataFrame, 
  linkvars::Vector{Symbol};
  fig::AbstractString="",
  bounds::Vector{Symbol}=[:range, :hpdi],
  title::AbstractString="",
  xlab::AbstractString=String(xvar),
  ylab::AbstractString=String(yvar),
  alpha::Float64=0.11,
  colors::Vector{Symbol}=[:lightgrey, :grey],
  stepsize::Float64=0.01
)
```

##`convert_a3d`
```@docs
convert_a3d(a3d_array, cnames, ::Val{:dataframe})
convert_a3d(a3d_array, cnames, ::Val{:dataframes})
```