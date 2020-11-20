"""

# link

Compute the link function for standardized variables.

$(SIGNATURES)

# Extended help

### Required arguments
```julia
* `df::DataFrame`                      : Chain samples converted to a DataFrame
* `vars::Vector{Symbol}`               : Variables in DataFrame (2 variables)
* `xrange::range`                      : Range over which link values are computed
```

### Optional arguments
```julia
* `xbar::Float64`                      : Mean value of observed predictor
* `ybar::Float64`                      : Mean value of observed outcome (requires xbar argument)
```
### Return values
```julia
* `result`                             : Vector of link values
```

"""
function link(dfa::DataFrame, vars, xrange) 
  [dfa[:, vars[1]] + dfa[:, vars[2]] * x for x in xrange]
end

function link(dfa::DataFrame, vars, xrange, xbar) 
  [dfa[:, vars[1]] + dfa[:, vars[2]] * (x - xbar) for x in xrange]
end

function link(dfa::DataFrame, vars, xrange, xbar, ybar) 
  [ybar .+ dfa[:, vars[1]] + dfa[:, vars[2]] * (x - xbar) for x in xrange]
end

export
  link