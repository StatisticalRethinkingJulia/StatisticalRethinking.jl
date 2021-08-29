"""
# plot_model_coef

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
function plot_model_coef(models::Vector{SampleModel}, 
  pars::Vector{Symbol}; fig="", title="")

  mnames = [models[i].name for i in 1:length(models)]
  for i in 1:length(mnames)
    if length(mnames[i]) > 9
      mnames[i] = mnames[i][1:9]
    end
  end

  s = Vector{NamedTuple}(undef, length(models))
  for (mindx, mdl) in enumerate(models)
    df = read_samples(mdl, :dataframe)
    m, l, u = estimparam(df)
    d = Dict{Symbol, NamedTuple}()
    for (indx, par) in enumerate(names(df))
        d[Symbol(par)] = (mean=m[indx], lower=l[indx], upper=u[indx])
    end
    s[mindx] =   (; d...)
  end

  plot_model_coef(s, pars; mnames, fig, title)
end

"""
# plot_model_coef

Multiple regression coefficient plot for a single model.

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
```

### Return values
```julia
* `(s, f)`                             : (particles, plot)
```

"""
function plot_model_coef(model::SampleModel, pars::Vector{Symbol};
  fig="", title="")
  plot_model_coef([model], pars; fig, title)
end

function plot_models(models::Vector{SampleModel}, type::Symbol;
  fig="", title = uppercase(String(type)))

  mnames = [models[i].name for i in 1:length(models)]
  for i in 1:length(mnames)
    if length(mnames[i]) > 9
      mnames[i] = mnames[i][1:9]
    end
  end

  df_waic = compare(models, type)
  plot_models(df_waic, type; fig, title)
end

export
  plot_model_coef,
  plot_models
