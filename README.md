# StatisticalRethinking v2.2.9


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] |

## Purpose of this package

This package contains Julia versions of selected code snippets and mcmc models contained in the R package "rethinking" associated with the book Statistical Rethinking by Richard McElreath.

As stated many times by the author in his online lectures, this package is not intended to take away the hands-on component of the course. The clips are just meant to get you going but learning means experimenting, in this case using Julia and Stan.

## Current release of StatisticalRethinking: 2.2.9

StatisticalRethinking.jl v2.x.y contains the setup as has been around for the last 2 years. I'm planning on maintaining it until late 2021. To install:
```
] add StatisticalRethinking
```

To continue using version 2 after v3 is released, you can add it by:
```
] add StatisticalRethinking@2.x.y
```
New development work and additional chapters will happen in v3.

## Important note on StatisticalRethinking v3 (under development)

Version 3 will be a breaking change from previous versions of StatisticalRethinking.jl. I expect the first stage of this work to be completed by late Nov 2020.

Given that Julia provides several very capable packages that support mcmc simulation, it only seemed appropriate to make StatisticalRethinking mcmc implementation independent.

The availablility of DynamicHMC, the huge progress made by the Turing.jl team over the last 2 years, the introduction of Julia `projects` in addition to Julia `packages`, the novel approach to notebooks in Pluto.jl and the work by [Karajan](https://github.com/karajan9/statisticalrethinking) were a few of the ideas that triggered exploring a new setup for StatisticalRethinking.jl and the 'course' projects [StatistcalRethinkingStan](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingStan.jl) and [StatisticalrethinkingTuring](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingTuring.jl)

## Versions

### Version 2.2.8

Latest released version. 

## Installation

To install the package (from the REPL):

```
] add StatisticalRethinking
```

## Documentation

- [**STABLE**][docs-stable-url] &mdash; **documentation of the most recently tagged version.**
- [**DEVEL**][docs-dev-url] &mdash; *documentation of the in-development version.*

## Acknowledgements

Of course, without the excellent textbook by Richard McElreath, this package would not have been possible. The author has also been supportive of this work and gave permission to use the datasets.

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://statisticalrethinkingjulia.github.io/StatisticalRethinking.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://statisticalrethinkingjulia.github.io/StatisticalRethinking.jl/stable

[travis-img]: https://travis-ci.com/StatisticalRethinkingJulia/StatisticalRethinking.jl.svg?branch=master
[travis-url]: https://travis-ci.com/StatisticalRethinkingJulia/StatisticalRethinking.jl

[codecov-img]: https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl

[issues-url]: https://github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl/issues

[project-status-img]: https://img.shields.io/badge/lifecycle-wip-orange.svg

