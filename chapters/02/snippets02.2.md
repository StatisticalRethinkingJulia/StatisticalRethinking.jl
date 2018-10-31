# Chapter 0 snippets

### snippet 2.0

Load Julia packages (libraries) needed  for the snippets in chapter 0

```julia
using Distributions, RDatasets, DataFrames, Plots
```

Package `RDatasets` provides access to the often used R datasets.
See RData if you have local .rda files.

Package `DataFrames` supports a Julia implementation DataFrames.

Package `Plos` is one of the available plotting options in Julia.
By default Plots uses GR as the .

snippet 2.1

```julia
ways  = [0  , 3 , 8 , 9 , 0 ];
ways/sum(ways)
```

snippet 2.2

```julia
d = Binomial(9, 0.5)
pdf(d, 6)
```

snippet 2.3

define grid

```julia
p_grid = range( 0 , stop=1 , length=20 )
```

define prior

```julia
prior = ones( 20 )
```

compute likelihood at each value in grid

```julia
likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
```

compute product of likelihood and prior

```julia
unstd_posterior = likelihood .* prior
```

standardize the posterior, so it sums to 1

```julia
posterior = unstd_posterior  ./ sum(unstd_posterior)
```

snippet 2.4

```julia
p1 = plot( p_grid , posterior ,
    xlab="probability of water" , ylab="posterior probability",
    lab = "interpolated", title="20 points" )
p2 = scatter!( p1, p_grid , posterior, lab="computed" )

savefig("Chapter02snippet24.pdf")
```

snippet 2.5

```julia
prior1 = [p < 0.5 ? 0 : 1 for p in p_grid]
prior2 = [exp( -5*abs( p - 0.5 ) ) for p in p_grid]

p3 = plot(p_grid, prior1,
  xlab="probability of water" , ylab="posterior probability",
  lab = "semi_uniform", title="Other priors" )
p4 = plot!(p3, p_grid, prior2,  lab = "double_exponential" )

savefig("Chapter02snippet25.pdf")

#=
```

snippet 2.6

```julia
library(rethinking)
globe.qa <- map(
    alist(
        w ~ dbinom(9,p) ,  # binomial likelihood
        p ~ dunif(0,1)     # uniform prior
    ) ,
    data=list(w=6) )
```

display summary of quadratic approximation

```julia
precis( globe.qa )
```

snippet 2.7
analytical calculation

```julia
w <- 6
n <- 9
curve( dbeta( x , w+1 , n-w+1 ) , from=0 , to=1 )
```

quadratic approximation

```julia
curve( dnorm( x , 0.67 , 0.16 ) , lty=2 , add=TRUE )

=#
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

