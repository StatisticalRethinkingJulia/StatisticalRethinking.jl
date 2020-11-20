
"""

# rescale

Rescale a vector to "un-standardize", the opposite of scale!().

$(SIGNATURES)

# Extended help

### Required arguments
```julia
* `x::Vector{Float64}`                 : Vector to be rescaled
* `xbar`                               : Mean value for rescaling
* `xstd`                               : Std for rescaling
```

### Return values
```julia
* `result::AbstractVector`             : Rescaled vector
```

"""
function rescale(x::AbstractVector, xbar::Float64, xstd::Float64)
  x .* xstd .+ xbar
end

export
  rescale