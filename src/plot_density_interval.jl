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
* `xlab::AbstractString`               : x axis label
* `ylab::AbstractString`               : y axis label
```
### Return values
```julia
* `p`                                  : Resulting plot
```

"""
function plot_density_interval(s::Vector{Float64}, bounds::Vector{Float64};
  colors = [:grey, :blue], alpha = 0.25, xlab = :x, ylab = "Density", kwargs...)
  k = kde(s)
  p = plot(k.x, k.density;
    xlim=(0, 1), xlab=xlab, ylab=ylab, color=colors[1], kwargs...)
  indxs = filter(i -> bounds[1] < k.x[i] < bounds[2], 1:length(k.x))
  for i in indxs
    plot!(p, [k.x[i], k.x[i]], [0.0, k.density[i]], alpha=alpha;
      color=colors[2], leg=false, kwargs...)
  end
  p
end

"""

# plot_density_interval!

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
* `xlab::AbstractString`               : x axis label
* `ylab::AbstractString`               : y axis label
```
### Return values
```julia
* `p`                                  : Resulting plot
```

"""
function plot_density_interval!(s::Vector{Float64}, bounds::Vector{Float64};
  colors = [:grey, :blue], alpha = 0.25, xlab = :x, ylab = "Density", kwargs...)
  k = kde(s)
  p = plot!(k.x, k.density;
    xlim=(0, 1), xlab=xlab, ylab=ylab, color=colors[1], kwargs...)
  indxs = filter(i -> bounds[1] < k.x[i] < bounds[2], 1:length(k.x))
  for i in indxs
    plot!(p, [k.x[i], k.x[i]], [0.0, k.density[i]], alpha=alpha;
      color=colors[2], leg=false, kwargs...)
  end
  p
end

export
  plot_density_interval