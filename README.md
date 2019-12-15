# StatisticalRethinking


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] |

## Important note

Over the next 2 months I'm planning to update StatisticalRethinking.jl to reflect the changes in the 2nd edition of the book. At the same time (but this will likely take longer) I'll also expand coverage of chapters 5 and beyond.

Documentation will change substantially. I no longer plan to generate and store notebook (and chapter) versions as part of the documentation.

## Introduction

This package contains Julia versions of selected code snippets and mcmc models contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

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

[StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) is intended to allow experimenting with this learning process using [StanJulia](https://github.com/StanJulia).

As such, in v1.x, quap() and ulam() have been replaced by StanOptimize.jl and StanSample.jl. This means that much earlier on StatisticalRethinking.jl introduces the reader to the Stan language.
Chapter 9 of the book contains a nice introduction to translating the `alist` R models to the Stan language (just before section 9.4). This is illustrated in the 4 snippets in the subdirectory `intro_scripts` in this package.

As stated many times by the author in his [online lectures](https://www.youtube.com/watch?v=ENxTrFf9a7c&list=PLDcUM9US4XdNM4Edgs7weiyIguLSToZRI), this package is not intended to take away the hands-on component of the course. The clips are just meant to get you going but learning means experimenting, in this case using Julia.

## Layout of the package

Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:

1. `clip-01-03.jl` - contains snippets 0.1 through 0.3
2. `clip-04-05.jl` - contains snippets 0.4 and 0.5.

A single snippet clip will be referred to as `03/clip-02.jl`. 

## Other packages in the StatisticalRethinkingJulia Github organization

Implementations of the models using Stan, DynamicHMC and Turing can be found in [StanModels](https://github.com/StatisticalRethinkingJulia/StanModels.jl), [DynamicHMCModels](https://github.com/StatisticalRethinkingJulia/DynamicHMCModels.jl) and [TuringModels](https://github.com/StatisticalRethinkingJulia/TuringModels.jl).

StanModels has been updated to use the new suite of packages StanSample.jl, StanOptimize.jl, StanVariational.jl, etc. (all modeled after Tamas Papp's StanDump.jl, StanRun.jl and StanSamples.jl). 

In the meantime time, Chris Fisher has made tremendous progress with MCMCBenchmarks.jl, which compares three NUTS mcmc options.

## Future plans

There is a plan to release a version 2 of StatisticalRethinking.jl that will be based on Soss.jl and DynamicHMC.jl. No firm timeline has been set for this.

## Documentation

- [**STABLE**][docs-stable-url] &mdash; **documentation of the most recently tagged version.**
- [**DEVEL**][docs-dev-url] &mdash; *documentation of the in-development version.*

## Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models contained in [TuringModels](https://github.com/StatisticalRethinkingJulia/TuringModels.jl). 

Tamas Papp has been very helpful during the development of the DynamicHMC versions of the models.

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer are followed closely in several example scripts.

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

## Versions & notes

Developing `rethinking` must have been an on-going process over several years, `StatisticalRethinking.jl` will likely follow a similar path.

1. The first version (v1.x) of `StatisticalRethinking` is really just a first attempt to capture the models and show ways of setting up those models, execute the models and post-process the results using Julia.

2. Many other R functions such as precis(), link(), shade(), etc. are not in v1, although some very early versions are being tested. Expect significant refactoring of those in future versions and at the same time better integration with MCMCChains.Chains objects.

3. Several other interesting approaches to mcmc modeling are being explored in Julia, e.g. Soss.jl and Omega.jl. These are tracked as candidates for use in a future v2 of StatisticalRethinking.jl.

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://statisticalrethinkingjulia.github.io/StatisticalRethinking.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://statisticalrethinkingjulia.github.io/StatisticalRethinking.jl/stable

[travis-img]: https://travis-ci.org/StatisticalRethinkingJulia/StatisticalRethinking.jl.svg?branch=master
[travis-url]: https://travis-ci.org/StatisticalRethinkingJulia/StatisticalRethinking.jl

[codecov-img]: https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl

[issues-url]: https://github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl/issues

[project-status-img]: https://img.shields.io/badge/lifecycle-wip-orange.svg

