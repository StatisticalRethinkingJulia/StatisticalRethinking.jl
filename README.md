# StatisticalRethinking


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] |

## Important note

Over the next 2 months I'm planning to update StatisticalRethinking.jl to reflect the changes in the 2nd edition of the book. At the same time (but this will likely take longer) I'll also expand coverage of chapters 5 and beyond.

Version 0.9.0 introduced model simulations based on DynamicHMC, e.g. the nice explanation of HMC (and NUTS) in chapter 9.

In version 1.0 I plan to switch to predominantly use DynamicHMC but
I'm still experimenting with a useful replacement for quap().

StanModels will be updated to use the new suite of packages StanSample.jl, StanOptimize.jl, StanVariational.jl, etc. (all modeled after Tamas Papp's StanDump.jl, StanRun.jl and StanSamples.jl). 

Documentation will also change substantially. I no longer plan to generate and store notebook (and chapter) versions as part of the documentation. If a user is interested to use the notebook versions they can be generated. This also has consequences for testing. 

Figures will be stored in the chapter directories. This is one of the reasons why I am planning this change. I have noticed that the quality of the figures as generated and included by Literate.jl are less than optimal. 

Towards the end of this year I also plan to update TuringModels.jl based on the new AdvancedHMC option.

At the meantime time, Chris Fisher has made tremendous progress with MCMCBenchmarks.jl, which compares three NUTS mcmc options.

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

[StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) is intended to allow experimenting with this learning process using four available mcmc options in Julia:

1. [CmdStan](https://github.com/StanJulia)
2. [DynamicHMC](https://github.com/tpapp/DynamicHMC.jl)
3. [TuringLang](https://github.com/TuringLang)
4. [Mamba](https://github.com/brian-j-smith/Mamba.jl)

Implementations of the models using Turing, CmdStan, DynamicHMC and Mamba can be found in [TuringModels](https://github.com/StatisticalRethinkingJulia/TuringModels.jl), [StanModels](https://github.com/StatisticalRethinkingJulia/StanModels.jl), [DynamicHMCModels](https://github.com/StatisticalRethinkingJulia/DynamicHMCModels.jl) and [MambaModels](https://github.com/StatisticalRethinkingJulia/MambaModels.jl).

A secondary objective of `StatisticalRethinkingJulia` is to compare definition and execution of a variety of models in the above four mcmc packages.

As stated many times by the author in his [online lectures](https://www.youtube.com/watch?v=ENxTrFf9a7c&list=PLDcUM9US4XdNM4Edgs7weiyIguLSToZRI), this package is not intended to take away the hands-on component of the course. The clips are just meant to get you going but learning means experimenting, in this case using Julia.

At least one other package  [(Klara)](https://github.com/JuliaStats/Klara.jl) is available for mcmc in Julia. Time constraints prevented this option to be included in `StatisticalRethinkingJulia`. For similar reasons, the number of models implemented in MambaModels is very limited.


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

Tamas Papp has also been very helpful during the development og the DynamicHMC versions of the models.

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer are followed closely in several example scripts.

The  documentation has been generated using Literate.jl and Documenter.jl based on several ideas demonstrated by Tamas Papp in  [DynamicHMCExamples.jl](https://tpapp.github.io/DynamicHMCExamples.jl).

## Questions and issues

Question and contributions are very welcome, as are feature requests and suggestions. Please open an [issue][issues-url] if you encounter any problems or have a question.

## Versions & notes

Developing `rethinking` must have been an on-going process over several years, `StatisticalRethinkinh.jl` will likely follow a similar path.

1. The initial version (v1) of `StatisticalRethinking` is really just a first attempt to capture the models and show ways of setting up those models, execute the models and post-process the results using Julia.

2. As mentioned above, a second objective of v1 is to experiment and compare the four selected mcmc options in Julia in terms of results, performance, ease of expressing models, etc.

3. The R package `rethinking`, in the experimental branch on Github, contains 2 functions `quap` and `ulam` (previously called `map` and `map2stan`) which are not in v1 of `Statisticalrethinking.jl`. It is my *intention* to study those and _possibly_ include something similar to `quap` or `ulam` (or both) in a future of `Statisticalrethinking`. In `clip-02-05.jl` an inital example of using the `maximum_a_posteriori` estimate and associated quadratic (Normal) approximation is illustrated.

4. Several other interesting approaches that could become a good basis for such an endeavour are being explored in Julia, e.g. Soss.jl and Omega.jl.

5. Many other R functions such as precis(), link(), shade(), etc. are not in v1, although some very early versions are being tested. Expect significant refactoring of those in future versions and at the same time better integration with MCMCChains.Chains objects.

6. The Mamba examples should really use `@everywhere using Mamba` in stead of `using Mamba`. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode. 

7. In the `src` directory of all packages is a file scriptentry.jl which defines an object `script_dict` which is used to control the generation of documentation, notebooks and .jl scripts in chapters and testing of the notebooks. See `?ScriptEntry` or enter e.g. `script_dict["02"]` in the REPL. In the model packages this file is suffixed by an indication of the used mcmc option. e.g. `script_dict_d` in DynamicHMCModels.

8. A utility function, generate() is part of each package to regenerate notebooks and chapter scripts, please see ?generate. Again, e.g. `generate_t` in TuringModels generates all model notebooks and chapter scripts for Turing models.

9. In a similar fashion, borrowed from DynamicHMCExamples I define several variations on `rel_path()`. By itself, `rel_path()` points at the scr directory of StatisticalRethinking.jl and e.g. `rel_path_s()` points to the src directory of StanModels. The `rel_path()` version is typically used to read in data files. All others are used to locate directorres to read from or store generated files into.


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

