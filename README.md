# StatisticalRethinking


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] |

## Purpose of this package

Given that Julia provides several very capable packages that support mcmc simulations, it seems more appropiate to make StatisticalRethinking mcmc implementation independent.

This `package` contains preliminary "common components" for Julia versions of selected `functions` contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

To work through the StatisticalRethinking book using Julia and Stan, install `project` StatisticalRethinkingStan.jl.

A parallel [effort](https://github.com/karajan9/statisticalrethinking) is under development using Turing.jl.

## Versions

### Version 3.0.0 (in preparation)

StatisticalRethinking.jl v3 is independent of the underlying mcmc package. 

Any feedback is appreciated. Please open an issue.

## Installation

To install the package (from the REPL):

```
] add StatisticalRethinking
```

but in most cases this package will be a dependency of another package, e.g. StatisticalRethinkingStan.jl.

## Documentation

- [**STABLE**][docs-stable-url] &mdash; **documentation of the most recently tagged version.**
- [**DEVEL**][docs-dev-url] &mdash; *documentation of the in-development version.*

## Acknowledgements

Of course, without this excellent textbook by Richard McElreath, this package would not have been possible. The author has also been supportive of this work and gave permission to use the datasets.

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

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

