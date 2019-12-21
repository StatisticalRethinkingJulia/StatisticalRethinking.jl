```@meta
CurrentModule = StatisticalRethinking
```

## `rel_path`
```@docs
rel_path(parts...)
```

## `link`
```@docs
link(df::DataFrame, vars, xrange, xbar) 
```

## `quap`
```@docs
quap(df::DataFrame)
```

## `scale!`
```@docs
scale!(df::DataFrame, vars::Vector{Symbol}, ext="_s")
```

## `sample`
```@docs
sample(df::DataFrame, n; replace=true, ordered=false)```

## `scale!`
```@docs
sample(q::Particles, n; permute=true)```

