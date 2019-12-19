## Purpose of this package

This package contains Julia versions of selected code snippets and mcmc models contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

As stated many times by the author in his [online lectures](https://www.youtube.com/watch?v=ENxTrFf9a7c&list=PLDcUM9US4XdNM4Edgs7weiyIguLSToZRI), this package is not intended to take away the hands-on component of the course. The clips are just meant to get you going but learning means experimenting, in this case using Julia and Stan.

## Introduction

This package is part of the broader [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization.

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

[StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) is intended to allow experimenting with this learning process using [Stan](https://github.com/StanJulia) and Julia.

In v1.x of StatisticalRethinking.jl, ulam() has been replaced by StanSample.jl. This means that much earlier on than in the book StatisticalRethinking.jl introduces the reader to the Stan language.

In the subdirectory `scripts/03/intro-stan` the Stan Language is introduced.

Chapter 9 of the book contains a nice introduction to translating the `alist` R models to the Stan language (just before section 9.5).

The R function quap() in StatisticalRethinking.jl uses the MAP density of the Stan samples as the mean of the Normal distribution. An example can be found in `scripts/03/intro-stan/intro-part-4.jl`. 

