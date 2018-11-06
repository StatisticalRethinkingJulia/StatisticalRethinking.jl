# Chapter 23snippets

### snippet 230

Load Julia packages (libraries) needed  for the snippets in chapter 0

```julia
using Distributions, RDatasets, DataFrames, GLM, StatsBase, Plots, StatPlots
gr(size=(600,300))
```

Package `RDatasets` provides access to the often used R datasets.
See RData if you have local .rda files.

Package `DataFrames` supports a Julia implementation DataFrames.

Package `Plots` is one of the available plotting options in Julia.
By default Plots uses GR as the .

snippet 3.1

```julia
PrPV = 0.95
PrPM = 0.01
PrV = 0.001
PrP = PrPV*PrV + PrPM*(1-PrV)
PrVP = PrPV*PrV / PrP
```

snippet 3.2

Grid of 1001 steps

```julia
p_grid = range(0, step=0.001, stop=1)
```

all priors = 1.0

```julia
prior = ones(length(p_grid))
```

Binomial pdf

```julia
likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
```

As Uniform priar has been used, unstandardized posterior is equal to likelihood

```julia
posterior = likelihood .* prior
```

Scale posterior such that they become probabilities

```julia
posterior = posterior / sum(posterior)
```

Sample using the computed posterior values as weights
In this example we keep the number of samples equal to the length of p_grid,
but that is not required.

```julia
samples = sample(p_grid, Weights(posterior), length(p_grid))

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)

p[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab="Draws")
```

analytical calculation

```julia
w = 6
n = 9
x = 0:0.01:1
p[2] = density(samples, ylim=(0.0, 5.0), lab="Sample density")
p[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
```

quadratic approximation

```julia
plot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")
plot(p..., layout=(1, 2))
savefig("s3_2.pdf")
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

