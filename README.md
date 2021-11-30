# StatisticalRethinking v4


| **Project Status**                                                               |  **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
|![][project-status-img] | [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | ![][CI-build] |

## Purpose of this package

The StatisticalRethinking.jl `package` contains functions comparable to the functions in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath. 

These functions are used in Jupyter and  Pluto notebook `projects` specifically intended for hands-on use while studying the book or taking the course.

Currently there are 3 of these notebook projects:

1. Max Lapan's [rethinking-2ed-julia](https://github.com/Shmuma/rethinking-2ed-julia) which uses Turing.jl and Jupyter notebooks. The intention is to move this project to StatisticalRethinkingJulia and rename it to SR2TuringJupyter.jl.

### *Note 1: Renaming of `rethinking-2ed-julia` to SR2TuringJupyter.jl.*

Currently `SR2TuringJupyter.jl` has not yet been renamed. This will be done after working through the projects 2 and 3 below. Use above link to access the repository.

2. The [SR2TuringPluto.jl](https://github.com/StatisticalRethinkingJulia/SR2TuringPluto.jl) project, also Turing.jl based but using Pluto.jl instead of Jupyter. It will be completely based on Max Lapan's work above, but only in Pluto.

3. The [SR2StanPluto.jl](https://github.com/StatisticalRethinkingJulia/SR2StanPluto.jl) project, which uses Stan as implemented in StanSample.jl and StanQuap.jl. See [StanJulia](https://github.com/StanJulia).

There is a fourth option to study the (Turing.jl) models in the Statistical Rethinking book which is in the form of a package and Franklin web pages: [TuringModels.jl](https://github.com/StatisticalRethinkingJulia/TuringModels.jl).

### *Note 2: Version 4 is under development and breaking in many respects.*

Version 4 has a very different setup and is a breaking change from v3 of StatisticalRethinking.jl. See below for what has changed.

For now StatisticalRethinking v3.3.6 is more complete in conjunction with the SR2StanPluto (v3) and SR2TuringPluto (v1-3) projects.

### *Note 3: Large size issue of StatisticalRethinking when `dev`-ed.*

As listed in issue [#145](https://github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl/issues/145#issue-1064657635) recently it was noticed that some very old Jupyter notebook files are still present which makes an inital download, e.g. when `dev`-ing the package rather long. This is not a problem when you just `add` the package.

## Why a StatisticalRethinking v4?

Over time more and better options become available to express the material covered in Statistical Rethinking, e.g. the use of KeyedArrays (provided by [AxisKeys.jl](https://github.com/JuliaArrays/AxisArrays.jl)) for the representation of mcmc chains.

But other examples are the recently developed [ParetoSmooth.jl](https://github.com/TuringLang/ParetoSmooth.jl) used in the PSIS related examples and the preliminary work by [SHMUMA](https://github.com/Shmuma/Dagitty.jl) on a better Dagitty.jl (vs. StructuralCausalModels.jl).

While StatisticalRethinking v3 focused on making StatisticalRethinking.jl mcmc package independendent, StatisticalRethinking v4 aims at de-coupling it from a specific graphical package and thus enables new choices for graphics, e.g. using Makie.jl and AlgebraOfGraphics.jl. 

Also, an attempt has been made to make StatisticalRethinking.jl fit better with the new setup of Pluto notebooks which keep track of used package versions in the notebooks themselves ([see here](https://github.com/fonsp/Pluto.jl/wiki/🎁-Package-management)).

## Workflow of StatisticalRethinkingJulia (v4):

1. Data preparation, typically using CSV.jl, DataFrames.jl and some statistical methods from StatsBase.jl and Statistics.jl. In some cases simulations are used which need Distributions.jl and a few special methods (available in StatisticalRethinking.jl).

2. Define the mcmc model, e.g. using StanSample.jl or Turing.jl, and obtain draws from the model.

3. Capture the draws for further processing. In Turing that is ususally done using MCMCChains.jl, in StanSample.jl v4 it's mostly in the form of a DataFrame, a StanTable, a KeyedArray chains (obtained from AxisKeys.jl).

4. Inspect the chains using statistical and visual methods. In many cases this will need one or more statistical packages and one of the graphical options.

Currently most visual options are StatsPlots/Plots based, e.g. in MCMCChains.jl and StatisticalRethinkingPlots.jl. The setup of StatisticalRethinking v4 enables the future introduction of a new package, StatisticalRethinkingMakie which will be based on Makie.jl and AlgebraOfGraphics.jl.

5. The above 4 items could all be done by just using StanSample.jl or Turing.jl.

**The book Statistical Rethinking has a different objective and studies how models compare, how models can help (or mislead) and why multilevel modeling might help in some cases.**

6. For this, additional packages are available, explained and demonstrated, e.g. StructuralCausalModels.jl, ParetoSmooth.jl and quite a few more.

## Using StatisticalRethinking v4

To work through the StatisticalRethinking book using Julia and Turing, download either of the `projects` [SRTuringJupyter.jl](https://github.com/StatisticalRethinkingJulia/SRTuringJupyter.jl) or [SRTuringPluto.jl](https://github.com/StatisticalRethinkingJulia/SRTuringPluto.jl).

### Note 3:

To work through the StatisticalRethinking book using Julia and Stan, download `project` [SRStanPluto.jl](https://github.com/StatisticalRethinkingJulia/SRStanPluto.jl). 

All three projects create a Julia environment where most needed packages are available.

In addition to providing a Julia package environment, these also contain chapter by chapter Jupyter or Pluto notebooks to work through the Statistical Rethinking book. 

In order to keep environment packages relatively simple (i.e. have a limited set of dependencies on other Julia packages) StatisticalRethinking consists of 2 layers, a top layer containing mcmc dependent methods (e.g. a model comparison method taking Turing.jl or StanSample.jl derived objects) which in turn call common methods in the bottom layer. The same applies for the graphic packages. This feature relies on Requires.jl and the mcmc dependent methods can be found in `src/require` directories.

To tailor StatisticalRethinking.jl for Stan, use (in that order!):
```
using StanSample
using StatisticalRethinking
```

or, for Turing:
```
using Turing
using StatisticalRethinking
```

See the notebook examples.

## Structure of StatisticalRethinkingJulia (v4):

On a high level, the StatisticalRethinkingJulia ecosystem contains 4 layers:

1. The lowest layer provides mcmc methods, currently Turing.jl and StanSample.jl.

2. Common (mcmc independent) bottom layer in StatisticalRethinking (and StatisticalRethinkingPlots).

3. MCMC dependent top layer in StatisticalRethinking (and StatisticalRethinkingPlots).

4. Chapter by chapter notebooks.

I would love to see a SR2DHMC....jl, which could be a combination of Soss.jl and DynamicHMC.jl, and a SR2Mamba.jl!

If interested in either of these projects, please contact me!

## Some background info on previous versions

Given that Julia provides several very capable packages that support mcmc simulation, it only seemed appropriate to make StatisticalRethinking (v3) on Julia mcmc implementation independent.

The availablility of DynamicHMC, the huge progress made by the Turing.jl team over the last 2 years, the introduction of Julia `projects` in addition to Julia `packages`, the novel approach to notebooks in Pluto.jl and the work by [Karajan](https://github.com/karajan9/statisticalrethinking) and currently [Shuma](https://github.com/Shmuma/rethinking-2ed-julia) were a few of the ideas that triggered exploring a new setup for StatisticalRethinking.jl and the 'course' projects [StatistcalRethinkingStan](https://github.com/StatisticalRethinkingJulia/SR2StanPluto.jl) and [StatisticalrethinkingTuring](https://github.com/StatisticalRethinkingJulia/SR2TuringPluto.jl),

An early, experimental version of [StructuralCausalModels.jl](https://github.com/StatisticalRethinkingJulia/StructuralCausalModels.jl) is also included as a dependency in the StatisticalRethinking.jl package. In the meantime I will definitely keep my eyes on [Dagitty.jl](https://github.com/Shmuma/Dagitty.jl), [Omega.jl](https://github.com/zenna/Omega.jl) and [CausalInference.jl](https://github.com/mschauer/CausalInference.jl). In particular Dagitty.jl has very similar objectives as StructuralCausalModels.jl and over time might replace it in the StatisticalRethinkingJulia ecosystem. For now, StructuralCausalModels does provide ways to convert DAGs to Dagitty and ggm formats.

The in v3 added introduced dependency [StatsModelComparisons.jl](https://github.com/StatisticalRethinkingJulia/StatsModelComparisons.jl) which provides PSIS and WAIC statistics for model comparison is deprecated in v4. For PSIS and LOO ParetoSmooth.jl is now used and WAIC has been moved to StatisticalRethinking.jl,

Finally, for a good while I have been looking for a great statistics book using Julia as kind of an introductory text to StatisticalRethinking and I believe the first couple of chapters in an upcoming book [Statistics with Julia](https://statisticswithjulia.org/index.html) by Yoni Nazarathy and Hayden Klok are exactly that.

As [StatisticalRethinking](https://github.com/StatisticalRethinkingJulia) v3/4 is also (DrWatson & Pkg) project based and uses Pluto notebooks, I have converted the book `listings` in the first 5 chapters to Pluto Notebooks in a new repository in StatisticalRethinkingJulia, i.e. [StatisticsWithJuliaPlutoNotebooks](https://github.com/StatisticalRethinkingJulia/StatisticsWithJuliaPlutoNotebooks.jl). 

After chapter 4, `Statistics with Julia` follows the frequentist approach while `Statistical Rethinking` opts for the Bayesian approach. Most of the material in chapters 5 and 6 of `Statistics with Julia` is therefore also covered using a more Bayesian perspective in the early chapters of the notebook projects [SR2StanPluto](https://github.com/StatisticalRethinkingJulia/SR2StanPluto.jl) and [SR2TuringPluto](https://github.com/StatisticalRethinkingJulia/SR2TuringPluto.jl). 

## Versions

### Version 4 (under construction!)

- Drop the heavy use of @reexport.
- Switch to ParetoSmooth.jl
- Enable the use of AxisKeys.jl for mcmc chains if Stan(Sample) is used.
- Enable a switch to Makie.jl and AlgebraOfGraphics.jl by moving all graphics to StatisticalRethinkingPlots and StatisticalRethinkingMakie (in the future).
- Use projects to set up the needed Julia environment to run the examples, e.g. SRStanPluto.jl and SRTuringJupyter.jl and SRTuringPluto.jl.
- Refine 'tailoring' StatisticalRethinking.jl and the graphics packages based on the availability of StanSample, Turing.jl, etc. using Requires.jl.
- Many more improvements by Max Lapan (@shmuma).

### Versions 3.2.1 - 3.3.6

- Improvements by Max Lapan.
- Introduction of StatsModelCoparisons.jl for PSIS and WAIC.
- Removed dependencied on DynamicHMC (will be covered in StatisticalRethinkingDHMC).
- Added trankplot.jl.
- Further separation of methods needed to convert output of mcmc package to SR inputs.
- Add compare() and plot_models() abstractions.
- Manifest.toml updates.

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

[project-status-img]: https://img.shields.io/badge/lifecycle-wip-orange.svg

