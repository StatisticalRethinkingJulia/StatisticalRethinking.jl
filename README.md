# StatisticalRethinking v2


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][travis-img]][travis-url] |

## Stargazers over time

[![Stargazers over time](https://starchart.cc/StatisticalRethinkingJulia/StatisticalRethinking.jl.svg)](https://starchart.cc/StatisticalRethinkingJulia/StatisticalRethinking.jl)

## Purpose of this package

This package contains Julia versions of selected `code snippets` and `mcmc models` contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

As stated many times by the author in his [online lectures](https://www.youtube.com/watch?v=ENxTrFf9a7c&list=PLDcUM9US4XdNM4Edgs7weiyIguLSToZRI), this package is not intended to take away the hands-on component of the course. The clips are just meant to get you going but learning means experimenting, in this case using Julia and Stan.

## Versions

### Version 3

A version 3 of StatisticalRethinking.jl is under development.

This is a breaking change from previous versions of StatisticalRethinking.jl. I expect the first stage of this work to be completed by late Nov 2020.

Given that Julia provides several very capable packages that support mcmc simulation, it only seemed appropriate to make StatisticalRethinking mcmc implementation independent.

The availablility of DynamicHMC, the huge progress made by the Turing.jl team over the last 2 years, the introduction of Julia `projects` in addition to Julia `packages`, the novel approach to notebooks in Pluto.jl and the work by [Karajan](https://github.com/karajan9/statisticalrethinking) were a few of the ideas that triggered exploring a new setup for StatisticalRethinking.jl and the 'course' projects [StatistcalRethinkingStan](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingStan.jl) and [StatisticalrethinkingTuring](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingTuring.jl)

An early, experimental version of [StructuralCausalModels.jl](https://github.com/StatisticalRethinkingJulia/StructuralCausalModels.jl) is also included as a dependency in the StatisticalRethinking.jl v3 package. In the meantime I will definitely keep my eyes on [Omega.jl](https://github.com/zenna/Omega.jl) and [CausalInference.jl](https://github.com/mschauer/CausalInference.jl). StructuralCausalModels does provide ways to convert DAGs to Daggity and ggm formats.

Finally, for a good while I have been looking for a great statistics book using Julia as kind of an introductory text to StatisticalRethinking and I believe the first couple of chapters in an upcoming book [Statistics with Julia](https://statisticswithjulia.org/index.html) by Yoni Nazarathy and Hayden Klok are exactly that. As [StatisticalRethinking](https://github.com/StatisticalRethinkingJulia) v3 is also (DrWatson & Pkg) project based and will use Pluto notebooks, I have converted the book `listings` in the first 3 chapters to Pluto Notebooks in a new repository in StatisticalRethinkingJulia, i.e. [StatisticsWithJuliaPlutoNotebooks](https://github.com/StatisticalRethinkingJulia/StatisticsWithJuliaPlutoNotebooks.jl). 

After chapter 4, `Statistics with Julia` follows the frequentionist approach while `Statistical Rethinking` opts for the Bayesian approach. The material in chapters 5 and 6 of `Statistics with Julia` is covered in `Statistical Rethinking` and the notebook projects [StatistcalRethinkingStan](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingStan.jl) and [StatisticalrethinkingTuring](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingTuring.jl). 

Time permitting I would love to see a StatisticalRethinkingDhmc.jl, which could be a combination of Soss.jl and DynamicHMC.jl, and a StatisticalRethinkingMamba.jl!

If interested in either of the last 2 projects, please contact me!

Late Nov 2020 is the target date to merge StatisticalRethinking.jl v3 into the Julia package repository. Come late Oct 2020 StatisticalRethinkingStan.jl v3 should cover the same material as StatisticalRethinking.jl v2.

I plan to maintain (but not further develop) v2 for at least 2 more years. To revert back to StatisticalRethinking.jl v2, do:
```
] add StatisticalRethinking@2.2.7
```

### Version 2.2.7 (in preparation)

Latest release of StatisticalRethinking v2 (once SR v3 is released)

### Version 2.2.6

Removed unused subdirs.
Removed hints on SR v2.3

### Version 2.2.5

Thanks to Joe Wagner a bug in 02/script-03-05.jl has been fixed.

### Version 2.2.1-4

Document simulate().
Chapter 6 scripts
Compat updates
Re-enabling coverage

### Version 2.2.0

Added StatsPlots.jl and MCMCChains.jl to the dependencies.

Updated plotcoef and plotbounds.

Updated documentation and scripts accordingly.

Moved dagitty example to StructuralCausalModels.jl (WIP!).

### Version 2.1.1-6

Updated src/require/plotcoef.jl (and made plotcoef() more general). Plotcoef() reuires StatsPlots to be loaded.

Added Stan reults for the first example in R's dagitty package using the above mentioned plotcoef() function (see scripts/05/dagitty-example).

### Version 2.1.0

This version adds [Particles](https://baggepinnen.github.io/MonteCarloMeasurements.jl/latest/) based summaries, quap() and several more plot examples.

From chapter 5 onwards a format for the scripts is used that is hopefully more stable over time.
In a future version the sripts might be imported from StanModels.

### Version 2.0.0 

This version follows the ongoing changes in the packages in the StanJulia Github organization, particularly the changes in StanSample.jl. This version breaks the approach chosen in v1.x with respect to the return values of stan_sample().

Another major change is that not all dependencies for the scripts are included in StatisticalRethinking.jl. Please see the `install_packages.jl` script in `scripts/00` for other packages needed in some of the scipts.

### Version 1.0.0

Initial release of StatisticalRethinking.jl.

## Installation

This package is part of the broader [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization.

To install the package (from the REPL):

```
] add StatisticalRethinking
```

or, easier in some cases to use from within an editor:

```
] dev StatisticalRethinking
```

All scripts contain in fact examples. A good initial introduction to running a Stan language program is in `scripts/03/intro-stan/intro-part-1.jl`.

## Introduction

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

[StatisticalRethinking.jl](https://github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl) is intended to allow experimenting with this learning process using [StanJulia](https://github.com/StanJulia).

## Rethinking `rethinking`

There are a few important differences between `rethinking` and `StatisticalRethinking.jl`:

1. In v2.x of StatisticalRethinking.jl, ulam() has been replaced by StanSample.jl.

This means that much earlier on than in the book, StatisticalRethinking.jl introduces the reader to the Stan language.

To help out with this, in the subdirectory `scripts/03/intro-stan` the Stan language is introduced and the execution of Stan language programs illustrated. Chapter 9 of the book contains a nice introduction to translating the `alist` R models to the Stan language (just before section 9.5).

To check the chains produced MCMCChains.jl can be used, e.g. see the scripts in chapter 5.

2. The equivalent of the R function `quap()` in StatisticalRethinking.jl v2.0 uses the MAP density of the Stan samples as the mean of the Normal distribution and reports the approximation as a NamedTuple. e.g. from `scripts/04-part-1/clip-31.jl`:
```
if success(rc)
  df = read_samples(sm; output_format=:dataframe)
  q = quap(df)
  q |> display
end
```
returns:
```
(mu = 178.0 ± 0.1, sigma = 24.5 ± 0.94)
```

The above call to read_samples(...) appends all chains in a single dataframe. To retrieve the chains in separate dataframes ( `Vector{DataFrames}` ) use:
```
df = read_samples(sm; output-Format=:dataframes)
```

To obtain the mu quap:
```
q.mu
```

To obtain the samples:
```
q.mu.particles
```

Examples and comparisons of different ways of computing a quap approximation can be found in `scripts/03/intro-stan/intro-part-4.jl`.

3. In `scripts/04-part-1` an additional section has been added, `intro-logpdf` which introduces an alternative way to compute the MAP (quap) using Optim.jl. This kind of builds on the logpdf formulation introduced in `scripts/03/intro-stan/intro-part-4.jl`

4. In `scripts/09` an additional intro section has been included, `scripts/09/intro-dhmc`. It is envisage that a future version of StatisticalRethinking.jl will be based on DynamicHMC.jl. No time line has been set for this work.

## Layout of the package

Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:

1. `clip-01-03.jl` - contains snippets 0.1 through 0.3
2. `clip-04-05.jl` - contains snippets 0.4 and 0.5.

A single snippet clip will be referred to as `03/clip-02.jl`.

As mentioned above, a few chapters contain additional scripts intended as introductions for specific topics.

### Data Access

If you want to use this package as an easy way to access the dataset samples, the package offers the function `rel_path` to work with paths inside the StatisticalRethinking package:

```julia

using StatisticalRethinking

# for example, grabbing the `Howell1` dataset used in Chapter 4
datapath = rel_path("..", "data/","Howell1.csv") 
df = DataFrame(CSV.read(datapath))
```

## Other packages in the StatisticalRethinkingJulia Github organization

Implementations of the models using Stan, DynamicHMC and Turing can be found in [StanModels](https://github.com/StatisticalRethinkingJulia/StanModels.jl), [DynamicHMCModels](https://github.com/StatisticalRethinkingJulia/DynamicHMCModels.jl) and [TuringModels](https://github.com/StatisticalRethinkingJulia/TuringModels.jl).

In the meantime time, Chris Fisher has made tremendous progress with [MCMCBenchmarks.jl](https://github.com/StatisticalRethinkingJulia/MCMCBenchmarks.jl), which compares three NUTS mcmc options.

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

[travis-img]: https://travis-ci.com/StatisticalRethinkingJulia/StatisticalRethinking.jl.svg?branch=master
[travis-url]: https://travis-ci.com/StatisticalRethinkingJulia/StatisticalRethinking.jl

[codecov-img]: https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl

[issues-url]: https://github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl/issues

[project-status-img]: https://img.shields.io/badge/lifecycle-wip-orange.svg

