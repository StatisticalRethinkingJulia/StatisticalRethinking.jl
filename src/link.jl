"""

# link

Compute the link function

### Method
```julia
link(xrange, chain, vars, xbar) 
```

### Required arguments
```julia
* `xrange::Turing model`        : Range over which link values are computed
* `chain::Float64`              : Chain samples used
* `vars::Float64`               : Variables in chain used
* `xbar::Float64`               : Mean value of observed predictor
```

### Return values
```julia
* `result`                      : Vector of link values
```

"""
function link(xrange, chain, vars, xbar) 
  res = [chain.value[:, vars[1], :] + chain.value[:, vars[2], :] * (x - xbar) for x in xrange]
end

