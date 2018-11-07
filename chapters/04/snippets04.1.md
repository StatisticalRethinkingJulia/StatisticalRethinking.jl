```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Chapter 4 snippets

### snippet 4.0

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example snippets04.1
using StatisticalRethinking
gr(size=(600,300))
```

snippet 4.1

Grid of 1001 steps

```@example snippets04.1
p_grid = range(0, step=0.001, stop=1)
```

all priors = 1.0

```@example snippets04.1
prior = ones(length(p_grid))
```

Binomial pdf

```@example snippets04.1
likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
```

As Uniform priar has been used, unstandardized posterior is equal to likelihood

```@example snippets04.1
posterior = likelihood .* prior
```

Scale posterior such that they become probabilities

```@example snippets04.1
posterior = posterior / sum(posterior)
```

Sample using the computed posterior values as weights
In this example we keep the number of samples equal to the length of p_grid,
but that is not required.

```@example snippets04.1
samples = sample(p_grid, Weights(posterior), length(p_grid))

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)

p[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab="Draws")
```

analytical calculation

```@example snippets04.1
w = 6
n = 9
x = 0:0.01:1
p[2] = density(samples, ylim=(0.0, 5.0), lab="Sample density")
p[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
```

quadratic approximation

```@example snippets04.1
plot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")
plot(p..., layout=(1, 2))
savefig("s4_1.pdf")
```

snippet 4.7

```@example snippets04.1
howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1)
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

