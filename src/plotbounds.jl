"""
# plotbounds

Plot regression line and intervals based on Stan samples of coeffficients.

$(SIGNATURES)

### Required arguments
```julia
* `df::DataFrame`                      : DataFrame with observed variables and scaled variables
* `xvar::Symbol`                       : X variable in df
* `yvar::Symbol`                       : Y variable in df
* `dfs::DataFrame`                     : DataFrame with Stan samples
* `linkvars::Vector{Symbol}`           : Initial 2 Symbols are regression coefficients,
                                         3rd - only for :predict bounds indicates σ.
```
### Optional arguments
```julia
* `fig::AbstractString=""`             : File to store the plot. If "", a plot is returned
* `bounds::Vector{Symbol}`             : Bounds to display, see below
* `title::AbstractString=""`           : Title for plot
* `title::AbstractString=String(xvar)` : X axis variable label
* `title::AbstractString=String(yvar)` : Y axis variable label
* `alpha::Float64=0.11`                : Interval value, defaults to [0.045, 0.945]
* `colors::Vector{Symbol}`             : Colors for regions, defaults to [:lightgrey, :grey]
* `stepsize::Float64=0.01`             : Stepsize for boundary accuracy            
```

This method is primarily intended to display 2 regions, typically predicted values and 
the quantile or hpdi region around the mean line. This is specified using the `bounds`
keyword argument, e.g. `bounds = [:predicted, :hpdi]`.

For the prediction interval, a 3rd parameter needs to be present in the Stan sample
DataFrame (dfs) indication the σ value. For other options 2 parameters suffice typically
the itercept and slope parameters.
"""
function plotbounds(
  df::DataFrame, 
  xvar::Symbol,
  yvar::Symbol, 
  dfs::DataFrame, 
  linkvars::Vector{Symbol};
  fig::AbstractString="",
  bounds::Vector{Symbol}=[:predicted, :hpdi],
  title::AbstractString="",
  xlab::AbstractString=String(xvar),
  ylab::AbstractString=String(yvar),
  alpha::Float64=0.11,
  colors::Vector{Symbol}=[:lightgrey, :grey],
  stepsize::Float64=0.01
)
  
  xbar = mean(df[:, xvar])
  xstd = std(df[:, xvar])
  ybar = mean(df[:, yvar])
  ystd = std(df[:, yvar])
  
  xvar_s = Symbol(String(xvar)*"_s")
  yvar_s = Symbol(String(yvar)*"_s")

  x_s = minimum(df[:, xvar_s]):stepsize:maximum(df[:, xvar_s])
  y_s = link(dfs, linkvars, x_s);

  x = rescale(x_s, xbar, xstd)
  y = [rescale(y_s[i], ybar, ystd) for i in 1:length(x)]
  mu = [mean(y[i]) for i in 1:length(x)]

  p = plot(xlab=xlab, ylab=ylab, title=title)

  if :range in bounds
    bnds_range = [[minimum(y[i]), maximum(y[i])] for i in 1:length(x)]
    for i in 1:length(x)
      plot!([x[i], x[i]], bnds_range[i], color=colors[1], leg=false)
    end
  end
   
  if :predicted in bounds
    predictions = zeros(length(x), nrow(dfs))
    for i in 1:length(x)
      for j in 1:nrow(dfs)
        predictions[i, j] = 
          ybar .+ rand(Normal(dfs[j, linkvars[1]] + ystd/xstd * dfs[j, linkvars[2]] * (x[i] - xbar), ystd*dfs[j, linkvars[3]]), 1)[1] 
      end
    end
    pred_hpd = [hpdi(predictions[i, :], alpha=alpha) for i in 1:length(x)]
    for i in 1:length(x)
      plot!([x[i], x[i]], pred_hpd[i], color=colors[1], leg=false)
    end
  end
   
  if :quantile in bounds
    bnds_quantile = [quantile(y[i], [alpha/2, 1-alpha/2]) for i in 1:length(x)]
    for i in 1:length(x)
      plot!([x[i], x[i]], bnds_quantile[i], color=colors[2], leg=false)
    end
  end
  
  if :hpdi in bounds
    bnds_hpd = [hpdi(y[i], alpha=alpha) for i in 1:length(x)]
    for i in 1:length(x)
      plot!([x[i], x[i]], bnds_hpd[i], color=colors[2], leg=false)
    end
  end

  plot!(x, mu, color=:black)
  scatter!(df[:, xvar], df[:, yvar], leg=false, color=:darkblue)

  if fig == ""
    return(p)
  else
    savefig(p, fig)
  end

end

export
  plotbounds
  