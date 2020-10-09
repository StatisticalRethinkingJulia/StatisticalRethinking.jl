"""
# plotcoef

Multiple regression coefficient plot.

$(SIGNATURES)

### Required arguments
```julia
* `models`                             : Vector of `SampleModel`s to compare
* `pars`                               : Vector of parameters to include in comparison
```
### Optional arguments
```julia
* `fig=""`                             : File to store plot
* `title=""`                           : Title for plot
* `func=nothing`                       : Funtion to apply to sample df
```
Currently the only function available is `quap`. NOT YET IMPLEMENTED.

### Return values
```julia
* `(s, f)`                             : (particles, plot)
```

"""
function plotcoef(
  models::Vector{SampleModel}, 
  pars::Vector{Symbol};
  fig="", title="", 
  func=nothing)

  mnames = [models[i].name for i in 1:length(models)]
  levels = length(models) * (length(pars) + 1)
  colors = [:blue, :red, :green, :darkred, :black]

  s = Vector{NamedTuple}(undef, length(models))
  for (mindx, mdl) in enumerate(models)
    if isnothing(func)
      df = read_samples(mdl; output_format=:dataframe)
      m, l, u = estimparam(df)
      d = Dict{Symbol, NamedTuple}()
      for (indx, par) in enumerate(names(df))
          d[Symbol(par)] = (mean=m[indx], lower=l[indx], upper=u[indx])
      end
      s[mindx] =   (; d...)
    else
      df = read_samples(mdl; output_format=:dataframe) 
      m, l, u = estimparam(df)
      d = Dict{Symbol, NamedTuple}()
      for (indx, par) in enumerate(names(df))
          d[Symbol(par)] = (mean=m[indx], lower=l[indx], upper=u[indx])
      end

      # TODO: Implement quap simulation

      #s[mindx] = func(dfs)
      s[mindx] =   (; d...)
    end
  end

  xmin = 0; xmax = 0.0
  for i in 1:length(s)
    for par in pars
      syms = Symbol.(keys(s[i]))
      if Symbol(par) in syms
        mp = s[i][par].mean
        xmin = min(xmin, s[i][par].lower)
        xmax = max(xmax, s[i][par].upper)
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
    l = length(mnames[j])
    str = mnames[j] * repeat(" ", 9-l)
    append!(ylabs, [str])
  end

  ys = [string(ylabs[i]) for i = 1:length(ylabs)]
  p = plot(xlims=(xmin, xmax), leg=false, framestyle=:grid)
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
        mp = s[mindx][Symbol(par)].mean
        lower = s[mindx][Symbol(par)].lower
        upper = s[mindx][Symbol(par)].upper
        plot!([lower, upper], [ypos, ypos], leg=false, color=colors[pindx])
        scatter!([mp], [ypos], color=colors[pindx])
      end
    end
  end
  if length(fig) > 0
    savefig(p, fig)
  end
  (s, p)
end

"""
# plotcoef

Multiple regression coefficient plot.

$(SIGNATURES)

### Required arguments
```julia
* `model`                              : SampleModel to display
* `pars`                               : Vector of parameters to include in comparison
* `fig`                                : File to store the produced plot
```
### Optional arguments
```julia
* `title=""`                           : Title for plot
* `func=nothing`                       : Funtion to apply to sample dataframe
```
Currently the only function available is `quap`. NOT YET IMPLEMENTED.

### Return values
```julia
* `(s, f)`                             : (particles, plot)
```

"""
function plotcoef(model::SampleModel, pars::Vector{Symbol};
  fig="", title="", func=nothing)

  plotcoef([model], pars; fig, title, func)

end

export
  plotcoef
