"""
# plot_models

Multiple regression coefficient plot for multiple models.

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
```

### Return values
```julia
* `(s, f)`                             : (particles, plot)
```

"""
function plot_models(models::Vector{SampleModel}, pars::Vector{Symbol};
  fig="", title="")

  mnames = [models[i].name for i in 1:length(models)]
  for i in 1:length(mnames)
    if length(mnames[i]) > 9
      mnames[i] = mnames[i][1:9]
    end
  end

  s = Vector{NamedTuple}(undef, length(models))
  for (mindx, mdl) in enumerate(models)
    df = read_samples(mdl; output_format=:dataframe)
    m, l, u = estimparam(df)
    d = Dict{Symbol, NamedTuple}()
    for (indx, par) in enumerate(names(df))
        d[Symbol(par)] = (mean=m[indx], lower=l[indx], upper=u[indx])
    end
    s[mindx] =   (; d...)
  end
  
  plot_models(s, mnames, pars; fig, title)
end

export
  plot_models
