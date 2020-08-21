# StatisticalRethinking


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] |

## Purpose of this package

This `package` contains common components for Julia versions of selected `code snippets` and `mcmc models` contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

To work through the StatisticalRethinking book using Julia and Stan, install `project` StatisticalRethinkingStan.jl. 

## Versions

### Version 3.0.0 (in preparation)

StatisticalRethinking.jl v3 is independent of the underlying mcmc package. 
Any feedback is appreciated. Please open an issue.

## Installation

This package is part of the broader [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization.

To install the package (from the REPL):

```
] add StatisticalRethinking
```

but in most cases this package will be a dependency of another package, e.g. 
All scripts contain in fact examples. A good initial introduction to running a Stan language program is in `scripts/03/intro-stan/intro-part-1.jl`.


## Documentation

- [**STABLE**][docs-stable-url] &mdash; **documentation of the most recently tagged version.**
- [**DEVEL**][docs-dev-url] &mdash; *documentation of the in-development version.*

## Acknowledgements

Of course, without this excellent textbook by Richard McElreath, this package would not have been possible. The author has also been supportive of this work and gave permission to use the datasets.

Richard Torkar has taken the lead in developing the Turing versions of the models contained in [TuringModels](https://github.com/StatisticalRethinkingJulia/TuringModels.jl). 

Tamas Papp has been very helpful during the development of the DynamicHMC versions of the models.

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer are followed closely in several example scripts.

The increasing use of Particles to represent quap approximations is possible thanks to the package [MonteCarloMeasurements.jl](https://github.com/baggepinnen/MonteCarloMeasurements.jl). Package [Soss.jl](https://github.com/cscherrer/Soss.jl) and [related write-ups](https://cscherrer.github.io) introduced me to that option.

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

## Versions & notes

Developing `rethinking` must have been an on-going process over several years, `StatisticalRethinking.jl` will likely follow a similar path.

1. The first version (v1.x) of `StatisticalRethinking` attempts to capture the models and to show ways of setting up those models, execute the models and post-process the results using Julia.

2. Many R functions such as precis(), shade(), etc. are either not in v1 or replaced by Julia equivalents, e.g. the Particles approach is used instead of precis(). Expect significant refactoring of those in future versions of StatisticalRethinking.jl. 

3. Several other interesting approaches to mcmc modeling are being explored in Julia, e.g. Soss.jl and Omega.jl. These are tracked as candidates for use in a future version of StatisticalRethinking.jl.

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

