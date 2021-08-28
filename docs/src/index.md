```@meta
CurrentModule = StatisticalRethinking
```

## `sr_path`
```@docs
sr_path(parts...)
```

## `sr_datadir`
```@docs
sr_datadir(parts...)
```

## link
```@docs
link(dfa::DataFrame, vars, xrange)
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

## pairsplot
```@docs
pairsplot(df::DataFrame, vars::Vector{Symbol})
```

## meanlowerupper
```@docs
meanlowerupper(data, PI = (0.055, 0.945))
```

## plotbounds
```@docs
plotbounds(
  df::DataFrame, 
  xvar::Symbol,
  yvar::Symbol, 
  dfs::DataFrame, 
  linkvars::Vector{Symbol};
  fnc = link,
  fig::AbstractString="",
  bounds::Vector{Symbol}=[:predicted, :hpdi],
  title::AbstractString="",
  xlab::AbstractString=String(xvar),
  ylab::AbstractString=String(yvar),
  alpha::Float64=0.11,
  colors::Vector{Symbol}=[:lightgrey, :grey],
  stepsize::Float64=0.01,
  rescale_axis=true,
  kwargs...
)
plotbounds(
  df::DataFrame,
  xvar::Symbol,
  yvar::Symbol,
  nt::NamedTuple, 
  linkvars::Vector{Symbol}; 
  fnc::Function=link,
  fig::AbstractString="",
  stepsize=0.01,
  rescale_axis=true,
  lab::AbstractString="",
  title::AbstractString="",
  kwargs...
)
```

## plotlines
```@docs
plotlines(
  df::DataFrame,
  xvar::Symbol,
  yvar::Symbol,
  nt::NamedTuple, 
  linkvars::Vector{Symbol},
  fig=nothing; 
  fnc::Function=link,
  stepsize=0.01,
  rescale_axis=true,
  lab::AbstractString="",
  title::AbstractString="",
  kwargs...
)
```

## compare
```@docs
compare(m::Vector{Matrix{Float64}}, ::Val{:waic})
```

## `create_observation_matrix`
```@docs 
create_observation_matrix(x::Vector, k::Int)
```

## `r2_is_bad`
```@docs
r2_is_bad(model::NamedTuple, df::DataFrame)
```

## var2
```@docs
var2(x)
```

## sim_happiness
```docs
sim_happiness(; seed=nothing, n_years=1000, max_age=65, n_births=20, aom=18)
```

```
## simulate
```@docs
simulate(df, coefs, var_seq)
simulate(df, coefs, var_seq, coefs_ext)
```
