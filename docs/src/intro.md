# StatisticalRethinking

## Introduction

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

The [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization is intended to allow experimenting with this learning process using four available mcmc options in Julia:

1. [CmdStan](https://github.com/StanJulia)
2. [DynamicHMC](https://github.com/tpapp/DynamicHMC.jl)
3. [TuringLang](https://github.com/TuringLang)
4. [Mamba](https://github.com/brian-j-smith/Mamba.jl)

At least one other package is available for mcmc in Julia:

5. [Klara](https://github.com/JuliaStats/Klara.jl)

Time constraints prevented this option to be in `StatisticalRethinkingJulia`.

A secondary objective of `StatisticalRethinkingJulia` is to compare definition and execution of a variety of models in the above four mcmc packages.

Model scripts using Turing, Mamba, CmdStan or DynamicHMC can be found in [TuringModels](https://github.com/StatisticalRethinkingJulia/TuringModels.jl), [StanModels](https://github.com/StatisticalRethinkingJulia/StanModels.jl), [DynamicHMCModels](https://github.com/StatisticalRethinkingJulia/DynamicHMCModels.jl) and [MambaModels](https://github.com/StatisticalRethinkingJulia/MambaModels.jl), part of the [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization set of packages.

