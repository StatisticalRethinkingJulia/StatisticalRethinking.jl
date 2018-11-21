# Chapter 0 snippets

### snippet 0.0

Load Julia packages (libraries) needed  for the snippets in chapter 0

```julia
using StatisticalRethinking
gr(size=(300, 300))
```

### snippet 0.1

```julia
println( "All models are wrong, but some are useful." )
```

### snippet 0.2

This is a StepRange, not a vector

```julia
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

```julia
log( 0.01^200 )
200 * log(0.01)
```

### snippet 0.4

`dataset(...)` provides access to often used R datasets.

```julia
cars = dataset("datasets", "cars")
```

If this is not a common R dataset, use e.g.:
howell1 = CSV.read(joinpath(ProjDir, "..", "..",  "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1)

This reads the Howell1.csv dataset in the data subdirectory of this package,
 StatisticalRethinking.jl. See also the chapter 4 snippets.

Fit a linear regression of distance on speed

```julia
m = lm(@formula(Dist ~ Speed), cars)
```

estimated coefficients from the model

```julia
coef(m)
```

Plot residuals against speed

```julia
fig1 = scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")
```

Save the plot

### snippet 0.5

Thie contents of this snipper is partially replaced by snippet 0.0.
If any of these packages is not installed in your Julia system,
you can add it by e.g. `Pkg.add("RDatasets")`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

