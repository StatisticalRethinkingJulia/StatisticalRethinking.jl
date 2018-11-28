```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed

```@example snippets_00_04_05
using StatisticalRethinking
gr(size=(300, 300))
```

snippet 0.4

`dataset(...)` provides access to often used R datasets.

```@example snippets_00_04_05
cars = dataset("datasets", "cars")
```

If this is not a common R dataset, use e.g.:
howell1 = CSV.read(joinpath(ProjDir, "..", "..",  "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1)

This reads the Howell1.csv dataset in the data subdirectory of this package,
 StatisticalRethinking.jl. See also the chapter 4 snippets.

Fit a linear regression of distance on speed

```@example snippets_00_04_05
m = lm(@formula(Dist ~ Speed), cars)
```

estimated coefficients from the model

```@example snippets_00_04_05
coef(m)
```

Plot residuals against speed

```@example snippets_00_04_05; continued = true
scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")
```

snippet 0.5 is replaced above `using StatisticalRethinking`.

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

