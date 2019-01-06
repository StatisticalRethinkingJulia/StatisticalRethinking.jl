# StatisticalRethinking


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] [![][appveyor-img]][appveyor-url] [![][codecov-img]][codecov-url] |

## Introduction

This package contains Julia versions of selected code snippets contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

In the book and associated R package `rethinking`, statistical models are defined as illustrated below:

```
m4.3 <- map(
    alist(
        height ~ dnorm( mu , sigma ) ,
        mu <- a + b*weight ,
        a ~ dnorm( 156 , 100 ) ,
        b ~ dnorm( 0 , 10 ) ,
        sigma ~ dunif( 0 , 50 )
    ) ,
    data=d2
)
```

The author of the book states: "*If that (the statistical model) doesn't make much sense, good. ... you're holding the right textbook, since this book teaches you how to read and write these mathematical descriptions*" (page 77).

This package is intended to allow experimenting with this learning process using 3 available mcmc options in Julia.

## Layout of the package

Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:

1. `clip-01-03.jl` - contains snippets 0.1 through 0.3
2. `clip-04-05.jl` - contains snippets 0.4 and 0.5.

These 2 files are in scripts/00 and later on processed by Literate.jl to create 3 derived versions, e.g. from `clip_01_03.jl` in scripts/00:

1. `clip-01-03.md` - included in the documentation
2. `clip-01-03.ipynb` - stored in the notebooks/_chapte_r directory
3. `clip-01-03.jl` - stored in the chapters/_chapter_ directory

Occasionally lines in scripts are suppressed when Literate processes input source files, e.g. in Turing scripts the statement
`#nb Turing.turnprogress(false);` is only inserted in the generated notebook but not in the corresponding chapter .jl script.

A clip will contain just a single snippet will be referred to as `03/clip-02.jl`. 

Clips with names such as `02/clip-08t.jl`, `clip_08s.jl` and `clip_08m.jl` contain mcmc implementations using Turing.jl, CmdStan.jl and Mamba.jl respectively. Examples have been added to chapter 2.

The **Turing** versions of the mcmc models are available as e.g. `chapters/08/m8.1t.jl`. Equivalent **CmdStan** versions and, in a few cases **Mamba** models, are provided as well.

Almost identical clips are named e.g. `04/clip-07.0s.jl` and `04/clip-07.1s.jl`. In that specific example just the priors differ.

Scripts using Turing, Mamba or CmdStan need to import those, see the examples in `scripts/02`.

In the `src` directory is a file scriptentry.jl which defines an object `script_dict` which is used to control the generation of documentation, notebooks and .jl scripts in chapters and testing of the notebooks. Output of CmdStan and Mamba scripts is automatically inserted in the documentation. For Turing scripts this needs to be done manually by executing the notebook, exporting the results as .md files (and .svg files if graphics are generated) and copy these to `docs/src/nn`, where nn is the chapter. See `?ScriptEntry` or enter e.g. `script_dict["02"]` in the REPL.

## Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8. 

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer have been a great help and followed closely in several example scripts. 

The mcmc components are based on:

1. [TuringLang](https://github.com/TuringLang)
2. [StanJulia](https://github.com/StanJulia)
3. [Mamba](https://github.com/brian-j-smith/Mamba.jl)

At least 2 other mcmc options are available for mcmc in Julia:

4. [DynamicHMC](https://github.com/tpapp/DynamicHMC.jl)
5. [Klara](https://github.com/JuliaStats/Klara.jl)

Time constraints prevents inclusion of those. The linear regression example in [DynamicHMCExamples](https://tpapp.github.io/DynamicHMCExamples.jl/latest/example_linear_regression/) is a good starting point.

The Mamba examples should really use `@everywhere using Mamba` in stead of `using Mamba`. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode.

## Documentation

- [**STABLE**][docs-stable-url] &mdash; **documentation of the most recently tagged version.**
- [**DEVEL**][docs-dev-url] &mdash; *documentation of the in-development version.*

The  documentation has been generated using Literate.jl and Documenter.jl based on several ideas demonstrated by Tamas Papp in above mentioned  [DynamicHMCExamples.jl](https://tpapp.github.io/DynamicHMCExamples.jl).

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://stanjulia.github.io/StatisticalRethinking.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://stanjulia.github.io/StatisticalRethinking.jl/stable

[travis-img]: https://travis-ci.org/StanJulia/StatisticalRethinking.jl.svg?branch=master
[travis-url]: https://travis-ci.org/StanJulia/StatisticalRethinking.jl

[appveyor-img]: https://ci.appveyor.com/api/projects/status/whhifxtx8jb2208f?svg=true
[appveyor-url]: https://ci.appveyor.com/project/StanJulia/StatisticalRethinking-jl

[codecov-img]: https://codecov.io/gh/StanJulia/StatisticalRethinking.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/StanJulia/StatisticalRethinking.jl

[issues-url]: https://github.com/StanJulia/StatisticalRethinking.jl/issues

[project-status-img]: https://img.shields.io/badge/lifecycle-wip-orange.svg

