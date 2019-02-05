# StatisticalRethinking

This package contains Julia versions of selected code snippets and mcmc models contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

In the book and associated R package `rethinking`, statistical models are defined as illustrated below:

```
flist <- alist(
  height ~ dnorm( mu , sigma ) ,
  mu <- a + b*weight ,
  a ~ dnorm( 156 , 100 ) ,
  b ~ dnorm( 0 , 10 ) ,
  sigma ~ dunif( 0 , 50 )
)
```

Posterior values can be approximated by
 
```
# Simulate quadratic approximation (for simpler models)
m4.31 <- quad(flist, data=d2)
```

or generated using Stan by:

```
# Generate a Stan model and run a simulation
m4.32 <- ulam(flist, data=d2)
```

The author of the book states: "*If that (the statistical model) doesn't make much sense, good. ... you're holding the right textbook, since this book teaches you how to read and write these mathematical descriptions*" (page 77).

The `StatisticalRethinking.jl` package is intended to allow experimenting with this learning process introducing 4 available mcmc options in Julia.

The mcmc components are based on:

1. [TuringLang](https://github.com/TuringLang)
2. [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia)
3. [Mamba](https://github.com/brian-j-smith/Mamba.jl)
4. [DynamicHMC](https://github.com/tpapp/DynamicHMC.jl)

At least one other mcmc option is available for mcmc in Julia:

5. [Klara](https://github.com/JuliaStats/Klara.jl)

Time constraints prevented this option to be in `StatisticalRethinking.jl`.

A secondary objective of `StatisticalRethinking.jl` is to compare definition and executions of a variety of models in the above lited 4 mcmc options.
