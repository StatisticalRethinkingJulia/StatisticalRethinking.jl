```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed  in this snippet

```@example snippets02.1
using Distributions
```

Package `Distributions` conatains Julia library of distributions, e.g.
?Distributions

snippet 2.1

```@example snippets02.1
ways  = [0  , 3 , 8 , 9 , 0 ];
ways/sum(ways)
```

snippet 2.2

```@example snippets02.1
d = Binomial(9, 0.5)
pdf(d, 6)
```

snippet 2.3

define grid

```@example snippets02.1
p_grid <- seq( from=0 , to=1 , length.out=20 )
```

define prior

```@example snippets02.1
prior <- rep( 1 , 20 )
```

compute likelihood at each value in grid

```@example snippets02.1
likelihood <- dbinom( 6 , size=9 , prob=p_grid )
```

compute product of likelihood and prior

```@example snippets02.1
unstd.posterior <- likelihood * prior
```

standardize the posterior, so it sums to 1

```@example snippets02.1
posterior <- unstd.posterior / sum(unstd.posterior)
```

snippet 2.4

```@example snippets02.1
plot( p_grid , posterior , type="b" ,
    xlab="probability of water" , ylab="posterior probability" )
mtext( "20 points" )
```

snippet 2.5

```@example snippets02.1
prior <- ifelse( p_grid < 0.5 , 0 , 1 )
prior <- exp( -5*abs( p_grid - 0.5 ) )
```

snippet 2.6

```@example snippets02.1; continued = true
library(rethinking)
globe.qa <- map(
    alist(
        w ~ dbinom(9,p) ,  # binomial likelihood
        p ~ dunif(0,1)     # uniform prior
    ) ,
    data=list(w=6) )
```

display summary of quadratic approximation

```@example snippets02.1
precis( globe.qa )
```

snippet 2.7
analytical calculation

```@example snippets02.1
w <- 6
n <- 9
curve( dbeta( x , w+1 , n-w+1 ) , from=0 , to=1 )
```

quadratic approximation

```@example snippets02.1
curve( dnorm( x , 0.67 , 0.16 ) , lty=2 , add=TRUE )
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

