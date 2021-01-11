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
* `fnc = link`                         : Link function
* `fig::AbstractString=""`             : File to store the plot. If "", a plot is returned
* `bounds::Vector{Symbol}`             : Bounds to display, see below
* `title::AbstractString=""`           : Title for plot
* `xlab::AbstractString=String(xvar)`  : X axis variable label
* `ylab::AbstractString=String(yvar)`  : Y axis variable label
* `alpha::Float64=0.11`                : Interval value, defaults to [0.045, 0.945]
* `colors::Vector{Symbol}`             : Colors for regions, defaults to [:lightgrey, :grey]
* `stepsize::Float64=0.01`             : Stepsize for boundary accuracy 
* `rescale_axis=true`                  : Display using un-standardized scale         
```

This method is primarily intended to display 2 regions, typically predicted values and 
the quantile or hpdi region around the mean line. This is specified using the `bounds`
keyword argument, e.g. `bounds = [:predicted, :hpdi]`.

For the prediction interval, a 3rd parameter needs to be present in the Stan sample
DataFrame (dfs) containing the σ value. This symbol needs to be added to `linkvars`, e.g.
```julia
linkvars = [:a, :bM, :sigma]
```

For other options, :quantile and :hpdi, two parameters suffice (typically the itercept
and slope parameters).

"""
function plotbounds(
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
  
  xbar = mean(df[:, xvar])
  xstd = std(df[:, xvar])
  ybar = mean(df[:, yvar])
  ystd = std(df[:, yvar])
  
  xvar_s = Symbol(String(xvar)*"_s")
  yvar_s = Symbol(String(yvar)*"_s")

  x_s = minimum(df[:, xvar_s]):stepsize:maximum(df[:, xvar_s])
  y_s = fnc(dfs, linkvars, x_s);

  if rescale_axis
    x = rescale(x_s, xbar, xstd)
    y = [rescale(y_s[i], ybar, ystd) for i in 1:length(x)]
  else
    x = x_s
    y = y_s
    xbar = 0.0
    xstd = 1.0
    ybar = 0.0
    ystd = 1.0
  end

  mu = [mean(y[i]) for i in 1:length(x)]

  p = plot(;xlab=xlab, ylab=ylab, title=title, kwargs...)

  if :predicted in bounds
    predictions = zeros(length(x), nrow(dfs))
    for i in 1:length(x)
      for j in 1:nrow(dfs)
        predictions[i, j] = 
          ybar .+ rand(Normal(dfs[j, linkvars[1]] + ystd/xstd * dfs[j, linkvars[2]] * (x[i] - xbar), ystd*dfs[j, linkvars[3]]))
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
  if rescale_axis
    scatter!(df[:, xvar], df[:, yvar], leg=false, color=:darkblue)
  else
    scatter!(df[:, xvar_s], df[:, yvar_s], leg=false, color=:darkblue)
  end

  if fig == ""
    return(p)
  else
    savefig(p, fig)
  end

end

"""
# plotbounds

Plot regression line and PI interval with alpha=0.11.

$(SIGNATURES)

### Required arguments
```julia
* `df::DataFrame`                      : DataFrame with observed variables and scaled variables
* `xvar::Symbol`                       : X variable in df
* `yvar::Symbol`                       : Y variable in df
* `nt::NamedTuple`                     : NamedTuple with Stan samples
* `linkvars::Vector{Symbol}`           : Initial 2 Symbols are regression coefficients,
                                         3rd - only for :predict bounds indicates σ.
```
### Optional arguments
```julia
* `fnc = link`                         : Link function
* `fig::AbstractString=""`             : File to store the plot. If "", a plot is returned
* `stepsize::Float64=0.01`             : Stepsize for boundary accuracy 
* `rescale_axis=true`                  : Display using un-standardized scale         
* `title::AbstractString=""`           : Title for plot
* `lab::AbstractString=""`             : X axis variable label
```

This method is intended to the PI region around the mean line. 

The 2nd symbol in `linkvars` needs to match the matrix 
```julia
linkvars = [:a, :bM]
```

For other options, :quantile and :hpdi, two parameters suffice (typically the itercept
and slope parameters).

"""
function plotbounds(
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
    kwargs...)

    xbar = mean(df[:, xvar])
    xstd = std(df[:, xvar])
    ybar = mean(df[:, yvar])
    ystd = std(df[:, yvar])

    xvar_s = Symbol(String(xvar)*"_s")
    yvar_s = Symbol(String(yvar)*"_s")

    minx = minimum(df[!, xvar_s]) - 0.1
    maxx = maximum(df[!, xvar_s]) + 0.1
    x_s = minx:stepsize:maxx

    k = size(nt[Symbol(linkvars[2])], 1)
    m = fnc(collect(x_s), k)
    y_s = m * nt[Symbol(linkvars[2])]
    y_s .+= nt[Symbol(linkvars[1])]'
    mul = meanlowerupper(y_s)

    p = plot(;title, kwargs...)
    if rescale_axis
        xrange = rescale(x_s, xbar, xstd)
        mm = rescale(mul.mean, ybar, ystd)
        lm = rescale(mul.lower, ybar, ystd)
        um = rescale(mul.upper, ybar, ystd)
        plot!(p, xrange, mm;
            xlab=String(xvar), ylab=String(yvar),
            ribbon=(mm-lm, um-mm),
            lab)
    else
        plot!(p, xrange, mul.mean;
            xlab=String(xvar), ylab=String(yvar),
            ribbon=(mul.mean-mul.lower, mul.upper-mul.mean),
            lab)
    end

    if fig == ""
        return(p)
    else
        savefig(p, fig)
    end
end

export
  plotbounds
  
