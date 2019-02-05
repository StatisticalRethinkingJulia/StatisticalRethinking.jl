# StatisticalRethinking


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] |

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

The [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization is intended to allow experimenting with this learning process introducing 4 available mcmc options in Julia.

The mcmc components are based on:

1. [TuringLang](https://github.com/TuringLang)
2. [StanJulia](https://github.com/StanJulia)
3. [Mamba](https://github.com/brian-j-smith/Mamba.jl)
4. [DynamicHMC](https://github.com/tpapp/DynamicHMC.jl)

At least one other package is available for mcmc in Julia:

5. [Klara](https://github.com/JuliaStats/Klara.jl)

Time constraints prevented this option to be in `StatisticalRethinkingJulia`.

A secondary objective of `StatisticalRethinkingJulia` is to compare definition and execution of a variety of models in the above four mcmc packages.

Scripts using Turing, Mamba, CmdStan or DynamicHMC can be found in [TuringModels](https://github.com/StatisticalRethinkingJulia/TuringModels.jl), [StanModels](https://github.com/StatisticalRethinkingJulia/StanModels.jl), [DynamicHMCModels](https://github.com/StatisticalRethinkingJulia/DynamicHMCModels.jl) and [MambaModels](https://github.com/StatisticalRethinkingJulia/MambaModels.jl), part of the [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization set of packages.


## Layout of the package

Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:

1. `clip-01-03.jl` - contains snippets 0.1 through 0.3
2. `clip-04-05.jl` - contains snippets 0.4 and 0.5.

These 2 files are in scripts/00 and later on processed by Literate.jl to create 3 derived versions, e.g. from `clip_01_03.jl` in scripts/00:

1. `clip-01-03.md` - included in the documentation
2. `clip-01-03.ipynb` - stored in the notebooks/_chapter_ directory
3. `clip-01-03.jl` - stored in the chapters/_chapter_ directory

Occasionally lines in scripts are suppressed when Literate processes input source files, e.g. in Turing scripts the statement
`#nb Turing.turnprogress(false);` is only inserted in the generated notebook but not in the corresponding chapter .jl script. Similarly `#src ...` will only be included in the .jl scripts in the chapters subdirectories.

A single snippet clip will be referred to as `03/clip-02.jl`. 

Models with names such as `08/m8.1t.jl`, `04/m4.1s.jl`, `04/m4.4m.jl` and `04/m4.5d.jl` generate mcmc samples using **Turing.jl**, **CmdStan.jl**, **Mamba.jl** or **DynamicHMC.jl** respectively. In some cases the results of the mcmc chains have been stored and retrieved (or regenerated if missing) in other clips, e.g. `04/clip-30s.jl`.

## Documentation

- [**STABLE**][docs-stable-url] &mdash; **documentation of the most recently tagged version.**
- [**DEVEL**][docs-dev-url] &mdash; *documentation of the in-development version.*

## Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8 and subsequent chapters. 

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer have been a great help and followed closely in several example scripts.

The  documentation has been generated using Literate.jl and Documenter.jl based on several ideas demonstrated by Tamas Papp in above mentioned  [DynamicHMCExamples.jl](https://tpapp.github.io/DynamicHMCExamples.jl).

Tamas Papp has also been very helpful during the development og the DynamicZHMC versions of the models.

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

## Versions

Developing `rethinking` must have been an on-going process over several years, `StatisticalRethinkinh.jl` will likely follow a similar path.

1. The initial version (v1) of `StatisticalRethinking` is really just a first attempt to capture the models and show ways of setting up those models, execute the models and post-process the results using Julia.

2. As mentioned above, a second objective of v1 is to experiment and compare the four selected mcmc options in Julia in terms of results, performance, ease of expressing models, etc.

3. The R package `rethinking`, in the experimental branch on Github, contains 2 functions `quap` and `ulam` (previously called `map` and `map2stan`) which are not in v1 of `Statisticalrethinking.jl`. It is my *intention* to study those and _possibly_ include `quap` or `ulam` (or both) in a future of `Statisticalrethinking`.

4. Several other interesting approaches that could become a good basis for such an endeavour are being explored in Julia, e.g. Soss.jl and Omega.jl.

5. Many other R functions such as precis(), link(), shade(), etc. are not in v1, although some very early versions are being tested. Expect significant refactoring of those in future versions.

## Miscellaneous notes

1. The Mamba examples should really use `@everywhere using Mamba` in stead of `using Mamba`. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode. 

2. In the `src` directory is a file scriptentry.jl which defines an object `script_dict` which is used to control the generation of documentation, notebooks and .jl scripts in chapters and testing of the notebooks. Output from CmdStan and DynamicHMC scripts are automatically inserted in the documentation. For Turing scripts this needs to be done manually by executing the notebook, exporting the results as .md files (and .svg files if graphics are generated) and copy these to `docs/src/nn`, where nn is the chapter. See `?ScriptEntry` or enter e.g. `script_dict["02"]` in the REPL.

3. A utility function, generate() is part of the package to regenerate notebooks and chapter scripts, please see ?generate.


[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://stanjulia.github.io/StatisticalRethinking.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://stanjulia.github.io/StatisticalRethinking.jl/stable

[travis-img]: https://travis-ci.org/StanJulia/StatisticalRethinking.jl.svg?branch=master
[travis-url]: https://travis-ci.org/StanJulia/StatisticalRethinking.jl

[codecov-img]: https://codecov.io/gh/StanJulia/StatisticalRethinking.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/StanJulia/StatisticalRethinking.jl

[issues-url]: https://github.com/StanJulia/StatisticalRethinking.jl/issues

[project-status-img]: https://img.shields.io/badge/lifecycle-wip-orange.svg

