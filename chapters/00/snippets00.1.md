```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Chapter 0 snippets

### snippet 0.0

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example snippets00.1
using RDatasets, DataFrames, GLM, Plots
```

Package `RDatasets` provides access to the often used R datasets.
See RData if you have local .rda files.

Package `DataFrames` supports a Julia implementation DataFrames.

Package `Plos` is one of the available plotting options in Julia.
By default Plots uses GR as the .

### snippet 0.1

```@example snippets00.1
println( "All models are wrong, but some are useful." )
```

### snippet 0.2

This is a StepRange, not a vector

```@example snippets00.1
x = 1:3
x = x*10
x = log.(x)
x = sum(x)
x = exp(x)
x = x*10
x = log(x)
x = sum(x)
x = exp(x)
```

### snippet 0.3

```@example snippets00.1
log( 0.01^200 )
200 * log(0.01)
```

### snippet 0.4

`dataset(...)` provides access to often used R datasets.

```@example snippets00.1
cars = dataset("datasets", "cars")
println()
```

Fit a linear regression of distance on speed

```@example snippets00.1
m = lm(@formula(Dist ~ Speed), cars)
```

estimated coefficients from the model

```@example snippets00.1
coef(m)
```

Plot residuals against speed

```@example snippets00.1; continued = true
fig1 = scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")
```

Save the plot

### snippet 0.5

Thie contents of this snipper is partially replaced by snippet 0.0.
If any of these packages is not installed in your Julia system,
you can add it by e.g. `Pkg.add("RDatasets")`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

