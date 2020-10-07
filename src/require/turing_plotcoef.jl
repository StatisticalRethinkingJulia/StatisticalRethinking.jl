"""
# plotcoef

Multiple regression coefficient plot for Turing models.

$(SIGNATURES)

### Required arguments
```julia
* `models`                             : Vector of `SampleModel`s to compare
* `pars`                               : Vector of parameters to include in comparison
```
### Optional arguments
```julia
* `fig`                                : File to store plot
* `title=""`                           : Title for plot
* `func=nothing`                       : Funtion to apply to sample df
```
Currently the only function available is `quap`.

The function will be called with a single argument, a dataframe constructed from all
samples in all chains in the SampleModels. 

### Return values
```julia
* `(s, f)`                             : (particles, plot)
```

"""
function plotcoef(
  models::Vector{T},
  mnames::Vector{String},
  pars::Vector{Symbol};
  fig="", title="", func=nothing,
  sampler=NUTS(0.65), nsamples=2000, nchains=4) where {T <: DynamicPPL.Model}

  # mnames = [nameof(m) for m in models]
  levels = length(models) * (length(pars) + 1)
  colors = [:blue, :red, :green, :darkred, :black]

  s = Vector{NamedTuple}(undef, length(models))
  for (mindx, mdl) in enumerate(models)
    if isnothing(func)
        chns = mapreduce(c -> sample(mdl, sampler, nsamples),
            chainscat, 1:nchains)
        df = DataFrame(Array(chns), names(chns, [:parameters]))
        m, l, u = estimparam(df)
        d = Dict{Symbol, NamedTuple}()
        for (indx, par) in enumerate(names(chns, [:parameters]))
            d[par] = (mean=m[indx], lower=l[indx], upper=u[indx])
        end
        s[mindx] =   (; d...)
    else
        quap_mdl = quap(mdl)
        post = rand(quap_mdl.distr, 10_000)
        df = DataFrame(post', [keys(quap_mdl.coef)...])
        m, l, u = estimparam(df)
        d = Dict{Symbol, NamedTuple}()
        for (indx, par) in enumerate(names(chns, [:parameters]))
            d[par] = (mean=m[indx], lower=l[indx], upper=u[indx])
        end
        s[mindx] =   (; d...)
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
        mp = mean(s[mindx][Symbol(par)])
        sp = std(s[mindx][Symbol(par)])
        plot!([mp-sp, mp+sp], [ypos, ypos], leg=false, color=colors[pindx])
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

Multiple regression coefficient plot for a single Turing model.

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
Currently the only function available is `quap`.

The function will be called with a single argument, a dataframe constructed from all
samples in all chains in the SampleModel.

### Return values
```julia
* `(s, f)`                             : (particles, plot)
```

"""
function plotcoef(
  mdl::DynamicPPL.Model,
  mname::AbstractString,
  pars::Vector{Symbol};
  fig="", title="", func=nothing,
  sampler=NUTS(0.65), nsamples=2000, nchains=4)

  # mname = nameof(mdl)
  levels = length(pars)
  colors = [:blue, :red, :green, :darkred, :black]

  if isnothing(func)
      chns = mapreduce(c -> sample(mdl, sampler, nsamples),
          chainscat, 1:nchains)
      df = DataFrame(Array(chns), names(chns, [:parameters]))
      m, l, u = estimparam(df)
      d = Dict{Symbol, NamedTuple}()
      for (indx, par) in enumerate(names(chns, [:parameters]))
          d[par] = (mean=m[indx], lower=l[indx], upper=u[indx])
      end
      s[mindx] =   (; d...)
  else
      quap_mdl = quap(mdl)
      post = rand(quap_mdl.distr, 10_000)
      df = DataFrame(post', [keys(quap_mdl.coef)...])
      m, l, u = estimparam(df)
      d = Dict{Symbol, NamedTuple}()
      for (indx, par) in enumerate(names(chns, [:parameters]))
          d[par] = (mean=m[indx], lower=l[indx], upper=u[indx])
      end
      s[mindx] =   (; d...)
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

  p = plot(xlims=(xmin, xmax), leg=false, framestyle=:grid)
  length(title) > 0 && title!(title)
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
  if length(fig) > 0
    savefig(p, fig)
  end
  (s, p)
end

export
  plotcoef
