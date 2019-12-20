"""

# link

Compute the link function

### Method
```julia
link(xrange, df, vars, xbar) 
```

### Required arguments
```julia
* `df::DataFrame`               : Chain samples converted to a DataFrame
* `vars::Vector{Symbol}`        : Variables in DataFrame (2 variables)
* `xrange::range`               : Range over which link values are computed
* `xbar::Float64`               : Mean value of observed predictor
```

### Return values
```julia
* `result`                      : Vector of link values
```

"""
function link(df::DataFrame, vars, xrange, xbar) 
  [df[:, vars[1]] + df[:, vars[2]] * (x - xbar) for x in xrange]
end

