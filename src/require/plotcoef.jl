using .StatsPlots

import .StanSample: SampleModel

"""

# plotcoef

Multiple regression coefficient plot.

Note: See the node in TODO about the a possible dagitty.jl.

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
  levels = length(models) * (length(pars) + 1) + 2
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
  append!(ylabs, ["        "])
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
  append!(ylabs, ["        "])

  ys = [string(ylabs[i]) for i = 1:length(ylabs)]
  plot(xlims=(xmin, xmax), ys, leg=false, framestyle=:grid)
  title!(title)
  yran = range(0, stop=length(ylabs)-1, length=length(ylabs))
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
        #println([mnames[mindx], par, syms, mp, ypos])
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

export
  plotcoef
