"""

# link

Compute the link function

### Method
```julia
link(xrange, chain, vars, xbar) 
```

### Required arguments
```julia
* `xrange::range`				: Range over which link values are computed
* `chain::Float64`              : Chain samples used
* `vars::Vector{Symbol}`               : Variables in chain used
* `xbar::Float64`               : Mean value of observed predictor
```

### Return values
```julia
* `result`                      : Vector of link values
```

"""
function link(xrange, df::DataFrame, vars, xbar) 
  res = [df[:, vars[1]] + df[:, vars[2]] * (x - xbar) for x in xrange]
end

