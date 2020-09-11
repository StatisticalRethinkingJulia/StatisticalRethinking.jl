"""

# plot_density_interval

$(SIGNATURES)

# Extended help

### Required arguments
```julia
* `s::Vector{Float64`                  : Samples
* `bounds::Vector{Float64}`            : Lower and upper bound for interval
```

### Keyword arguments
```julia
* `color = [:grey, :blue]              : Denity and fill colors
* `alpha = 0.25`                       : Transparency factor
* `x::AbstractString`                  : x axis label
* `y::AbstractString`                  : y axis label
* `p = plot()`                         : Plot used as starting point
```
### Return values
```julia
* `p`                                  : Resulting plot
```

"""
function plot_density_interval(s::Vector{Float64},
  bounds::Vector{Float64};
  color = [:grey, :blue],
  alpha = 0.25,
  x = :x,
  y = "density",
  p = plot())
  k = kde(s)
  p = plot!(k.x, k.density, xlim=(0, 1), 
    xlab=x, ylab="density", color=color[1])
  indxs = filter(i -> bounds[1] < k.x[i] < bounds[2], 1:length(k.x))
  for i in indxs
    plot!(p, [k.x[i], k.x[i]], [0.0, k.density[i]], alpha=alpha,
      color=color[2], leg=false)
  end
  p
end

export
  plot_density_interval