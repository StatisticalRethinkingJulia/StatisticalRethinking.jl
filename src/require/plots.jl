using .StatsPlots

import .StanSample: SampleModel

"""
# plotcoef

Multiple regression coefficient plot.

$(SIGNATURES)

### Required arguments
```julia
* `models`                        : Vector of `SampleModel`s to compare
* `pars`                          : Vector of parameters to include in comparison
* `fig`                           : File to store the produce plot
```
### Optional arguments
```julia
* `title=""`                      : Title for plot
* `func=nothing`                  : Optional funtion to apply to sample dataframe
```
Currently the only function available is `quap`.
The function will be called with a single argument, a dataframe constructed from all
samples in all chains in the SampleModels. It should return a Partcles type NamedTuple. e.g.:
```julia
(a = 0.000527 ± 0.1, bM = -0.0628 ± 0.16, bA = -0.608 ± 0.16, sigma = 0.828 ± 0.089)
```
Examples can be found in `scipts/05/clip-13.jl` and in `scripts/05/dagitty-example`.
### Return values
```julia
* `result::NamedTuple`            : Vector{NamedTuple} of estimates (Particles or Quap)
```
"""
function plotcoef(models::Vector{SampleModel}, pars::Vector{Symbol}, fig::AbstractString, 
  title="", func=nothing)

  mnames = [models[i].name for i in 1:length(models)]
  levels = length(models) * (length(pars) + 1)
  colors = [:blue, :red, :green, :darkred, :black]

  s = Vector{NamedTuple}(undef, length(models))
  for (mindx, mdl) in enumerate(models)
    if isnothing(func)
      s[mindx] = read_samples(mdl; output_format=:particles)
    else
      dfs = read_samples(mdl; output_format=:dataframe)      
      s[mindx] = func(dfs)
    end
  end

  xmin = 0; xmax = 0.0
  for i in 1:length(s)
    for par in pars
      syms = Symbol.(keys(s[i]))
      if Symbol(par) in syms
        mp = mean(s[i][Symbol(par)])
        sp = std(s[i][Symbol(par)])
        xmin = min(xmin, mp - sp)
        xmax = max(xmax, mp + sp)
      end
    end
  end

  ylabs = String[]
  for j in 1:length(models)
    for i in 1:length(pars)
      l = length(String(pars[i]))
      str = repeat(" ", 9-l) * String(pars[i])
      append!(ylabs, [str])
    end
    l = length(models[j].name)
    str = models[j].name * repeat(" ", 9-l)
    append!(ylabs, [str])
  end

  ys = [string(ylabs[i]) for i = 1:length(ylabs)]
  plot(xlims=(xmin, xmax), leg=false, framestyle=:grid)
  title!(title)
  yran = range(1, stop=length(ylabs), length=length(ys))
  yticks!(yran, ys)

  line = 0
  for (mindx, model) in enumerate(models)
    line += 1
    hline!([line] .+ length(pars), color=:darkgrey, line=(2, :dash))
    for (pindx, par) in enumerate(pars)
      line += 1
      syms = Symbol.(keys(s[mindx]))
      if Symbol(par) in syms
        ypos = (line - 1)
        mp = mean(s[mindx][Symbol(par)])
        sp = std(s[mindx][Symbol(par)])
        plot!([mp-sp, mp+sp], [ypos, ypos], leg=false, color=colors[pindx])
        scatter!([mp], [ypos], color=colors[pindx])
      end
    end
  end
  savefig(fig)
  s
end

"""
# plotcoef

Multiple regression coefficient plot.

$(SIGNATURES)

### Required arguments
```julia
* `model`                         : SampleModel to display
* `pars`                          : Vector of parameters to include in comparison
* `fig`                           : File to store the produced plot
```
### Optional arguments
```julia
* `title=""`                      : Title for plot
* `func=nothing`                  : Optional funtion to apply to sample dataframe
```
Currently the only function available is `quap`.
The function will be called with a single argument, a dataframe constructed from all
samples in all chains in the SampleModels. It should return a Partcles type NamedTuple. e.g.:
```julia
(a = 0.000527 ± 0.1, bM = -0.0628 ± 0.16, bA = -0.608 ± 0.16, sigma = 0.828 ± 0.089)
```
An examples can be found in `scipts/06/clip-12-05.jl`.
### Return values
```julia
* `result::NamedTuple`            : NamedTuple of estimates (Particles or Quap)
```
"""
function plotcoef(model::SampleModel, pars::Vector{Symbol}, fig::AbstractString, 
  title="", func=nothing)

  mname = model.name
  levels = length(pars)
  colors = [:blue, :red, :green, :darkred, :black]

  if isnothing(func)
    s = read_samples(model; output_format=:particles)
  else
    dfs = read_samples(model; output_format=:dataframe)      
    s = func(dfs)
  end

  xmin = 0; xmax = 0.0
  for par in pars
    syms = Symbol.(keys(s))
    if Symbol(par) in syms
      mp = mean(s[Symbol(par)])
      sp = std(s[Symbol(par)])
      xmin = min(xmin, mp - sp)
      xmax = max(xmax, mp + sp)
    end
  end

  ys = String[""]
  for i in 1:length(pars)
   append!(ys, [String(pars[i])])
  end

  plot(xlims=(xmin, xmax), leg=false, framestyle=:grid)
  title!(title)
  yran = range(0, stop=length(ys)-1, length=length(ys))
  yticks!(yran, ys)

  for (pindx, par) in enumerate(pars)
    syms = Symbol.(keys(s))
    if Symbol(par) in syms
      lineno = pindx
      mp = mean(s[Symbol(par)])
      sp = std(s[Symbol(par)])
      plot!([mp-sp, mp+sp], [lineno, lineno], leg=false, color=colors[pindx])
      scatter!([mp], [lineno], color=colors[pindx])
    end
  end
  savefig(fig)
  s
end

"""
# pairsplot

Multiple regression coefficient plotSimple version of StatsPlots cornerplot.

$(SIGNATURES)

### Required arguments
```julia
* `df`                                 : DataFrame containing the variables (as columns)
* `vars`                               : Vector of variables to include in plot
* `fig`                                : File to store the produced plot
```
"""
function pairsplot(df::DataFrame, vars::Vector{Symbol}, fig::AbstractString)

  l = length(vars)
  pmat = Matrix{Plots.Plot{Plots.GRBackend}}(undef, l, l)

  for i in 1:l
    for j in 1:l
      if i == j
        pmat[i, j] = plot(xlims=(0, 2), ylims=(0, 2), leg=false, framestyle=:none)
        plot!(pmat[i, j], annotations=(1, 1, Plots.text(String(vars[i]), :mid)),
          leg=false)
      else
        pmat[i,j] = scatter(df[:, vars[i]], df[:, vars[j]],
          markersize=5, color=:darkblue, leg=false)
      end
    end
  end
  plot(pmat..., layout=(l, l))
  savefig(fig)

end

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
  plotcoef,
  pairsplot,
  plotbounds
  