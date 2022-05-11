# StatisticalRethinking v4


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | ![][CI-build] |

## Purpose of this package

The StatisticalRethinking.jl `package` contains functions comparable to the functions in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath. 

These functions are used in Jupyter and  Pluto notebook `projects` specifically intended for hands-on use while studying the book or taking the course.

Currently there are 3 of these notebook projects:

1. Max Lapan's [rethinking-2ed-julia](https://github.com/Shmuma/rethinking-2ed-julia) which uses Turing.jl and Jupyter notebooks.

2. The [SR2TuringPluto.jl](https://github.com/StatisticalRethinkingJulia/SR2TuringPluto.jl) project, also Turing.jl based but using Pluto.jl instead of Jupyter. It is based on Max Lapan's work above.

3. The [SR2StanPluto.jl](https://github.com/StatisticalRethinkingJulia/SR2StanPluto.jl) project, which uses Stan as implemented in StanSample.jl and StanQuap.jl. See [StanJulia](https://github.com/StanJulia).

There is a fourth option to study the (Turing.jl) models in the Statistical Rethinking book which is in the form of a package and Franklin web pages: [TuringModels.jl](https://github.com/StatisticalRethinkingJulia/TuringModels.jl).

As listed in issue [#145](https://github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl/issues/145#issue-1064657635) recently it was noticed that some very old Jupyter notebook files are still present which makes an inital download, e.g. when `dev`-ing the package, rather long. This is not a problem when you just `add` the package.

## Why a StatisticalRethinking v4?

Over time more and better options become available to express the material covered in Statistical Rethinking, e.g. the use of KeyedArrays (provided by [AxisKeys.jl](https://github.com/JuliaArrays/AxisArrays.jl)) for the representation of mcmc chains. 

Other examples are the recently developed [ParetoSmooth.jl](https://github.com/TuringLang/ParetoSmooth.jl) which could be used in the PSIS related examples as a replacement for ParetoSmoothedImportanceSampling.jl and the preliminary work by [SHMUMA](https://github.com/Shmuma/Dagitty.jl) on Dagitty.jl (a potential replacement for StructuralCausalModels.jl).

While StatisticalRethinking v3 focused on making StatisticalRethinking.jl mcmc package independent, StatisticalRethinking v4 aims at de-coupling it from a specific graphical package and thus enables new choices for graphics, e.g. using Makie.jl and AlgebraOfGraphics.jl.

StatisticalRethinking.jl v4 fits better with the new setup of Pluto notebooks which keep track of used package versions in the notebooks themselves ([see here](https://github.com/fonsp/Pluto.jl/wiki/🎁-Package-management)).

## Workflow of StatisticalRethinkingJulia (v4):

1. Data preparation, typically using CSV.jl, DataFrames.jl and some statistical methods from StatsBase.jl and Statistics.jl. In some cases simulations are used which need Distributions.jl and a few special methods (available in StatisticalRethinking.jl).

2. Define the mcmc model, e.g. using StanSample.jl or Turing.jl, and obtain draws from the model.

3. Capture the draws for further processing. In Turing that is ususally done using MCMCChains.jl, in StanSample.jl v4 it's mostly in the form of a DataFrame, a StanTable, a KeyedArray chains (obtained from AxisKeys.jl).

4. For further processing, these projects nearly always convert chains to a DataFrame.

5. Inspect the chains using statistical and visual methods. In many cases this will need one or more statistical packages and one of the graphical options.

Currently visual options are StatsPlots/Plots based, e.g. in MCMCChains.jl and StatisticalRethinkingPlots.jl.

5. The above 5 steps could all be done by just using StanSample.jl or Turing.jl.

**The book Statistical Rethinking has a different objective and studies how models compare, how models can help (or mislead) and why multilevel modeling might help in some cases.**

6. For this, additional packages are available, explained and demonstrated, e.g. StructuralCausalModels.jl, ParetoSmoothedImportanceSampling.jl and quite a few more.

## Using StatisticalRethinking v4

To work through the StatisticalRethinking book using Julia and Turing or Stan, download either one of the above mentioned `projects` and start Pluto.

An early, experimental version of [StructuralCausalModels.jl](https://github.com/StatisticalRethinkingJulia/StructuralCausalModels.jl) is also included as a dependency in the StatisticalRethinking.jl package.

In the meantime I will definitely keep my eyes on [Dagitty.jl](https://github.com/Shmuma/Dagitty.jl), [Omega.jl](https://github.com/zenna/Omega.jl) and [CausalInference.jl](https://github.com/mschauer/CausalInference.jl). In particular Dagitty.jl has very similar objectives as StructuralCausalModels.jl and over time might replace it in the StatisticalRethinkingJulia ecosystem. For now, StructuralCausalModels does provide ways to convert DAGs to Dagitty and ggm formats.

Similarly, a dependency [ParetoSmoothedImportanceSampling.jl](https://github.com/StatisticalRethinkingJulia/ParetoSmoothedImportanceSampling.jl) is used which provides PSIS and WAIC statistics for model comparison.

## Versions

### Version 4

- Drop the heavy use of @reexport.
- Enable a future switch to Makie.jl and AlgebraOfGraphics.jl by moving all graphics to StatisticalRethinkingPlots and StatisticalRethinkingMakie (in the future).
- Many more improvements by Max Lapan (@shmuma).

### Versions 3.2.1 - 3.3.6

- Improvements by Max Lapan.
- Added trankplot.jl.
- Add compare() and plot_models() abstractions.

### Version 3.2.0

- Option to retieve sampling results as a NamedTuple.
- Added new method to plotbounds() to handle NamedTuples.
- Added plotlines().

### Versions v3.1.1 - 3.1.8

- Updates from CompatHelper.
- Switch to Github actions (CI, Documenter).
- Updates from Rik Huijzer (link function).
- Redo quap() based on StanOptimize.
- Start Updating notebooks in ch 2-8 using new quap().
- Redoing and updating the models in the models subdirectory.

### Version 3.1.0

Align (stanbased) quap with Turing quap. quap() now returns a NamedTuple that includes a field `distr` which represents the quadratic Normal (MvNormal) approximation.

### Version 3.0.0

StatisticalRethinking.jl v3 is independent of the underlying mcmc package. All scripts previously in StatisticalRethinking.jl v2 holding the snippets have been replaced by Pluto notebooks in the above mentioned mcmc specific `project` repositories.

Initially SR2TuringPluto.jl will lag SR2StanPluto.jl somewhat but later this year both will cover the same chapters.

It is the intention to develop *tests* for StatisticalRethinking.jl v3 that work across the different mcmc implementations. This will limit dependencies to the `test/Project.toml`.

### Version 2.2.9

Currently the latest release available in the StatisticalRethinking.jl v2 format.

## Installation

To install the package (from the REPL):

```
] add StatisticalRethinking
```

but in most cases this package will be a dependency of another package or project, e.g. SR2StanPluto.jl or SR2TuringPluto.jl.

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

[CI-build]: https://github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl/workflows/CI/badge.svg?branch=master

[![codecov](https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl/branch/master/graph/badge.svg?token=TFxRFbKONS)](https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl)

[![Coverage Status](https://coveralls.io/repos/github/StatisticalRethinkingJulia/StatisticalRethinking.jl/badge.svg?branch=master)](https://coveralls.io/github/StatisticalRethinkingJulia/StatisticalRethinking.jl?branch=master)

[codecov-img]: https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/StatisticalRethinkingJulia/StatisticalRethinking.jl

[issues-url]: https://github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl/issues

[project-status-img]: https://img.shields.io/badge/lifecycle-stable-green.svg

