## Github organization

StatisticalRethinking.jl is part of the broader [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization.

## Purpose of this package

The StatisticalRethinking.jl `package` contains functions comparable to the functions in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath. 

These functions are used in Jupyter and  Pluto notebook `projects` specifically intended for hands-on use while studying the book or taking the course.

Currently there are 3 of these notebook projects:

1. Max Lapan's [rethinking-2ed-julia](https://github.com/Shmuma/rethinking-2ed-julia) which uses Turing.jl and Jupyter notebooks. This has been forked, renamed to SR2TuringJupyter.jl and modified in a few places (e.g. data files are obtained from StatisticalRethinking.jl).

2. The [SR2TuringPluto.jl](https://github.com/StatisticalRethinkingJulia/SR2TuringPluto.jl) project, also Turing.jl based but using Pluto.jl instead of Jupyter. It is based on Max Lapan's work above.

3. The [SR2StanPluto.jl](https://github.com/StatisticalRethinkingJulia/SR2StanPluto.jl) project, which uses Stan as implemented in StanSample.jl and StanQuap.jl. See [StanJulia](https://github.com/StanJulia).

There is a fourth option to study the (Turing.jl) models in the Statistical Rethinking book which is in the form of a package and Franklin web pages: [TuringModels.jl](https://github.com/StatisticalRethinkingJulia/TuringModels.jl).

## Why a StatisticalRethinking v4?

Over time more and better options become available to express the material covered in Statistical Rethinking, e.g. the use of KeyedArrays (provided by [AxisKeys.jl](https://github.com/JuliaArrays/AxisArrays.jl)) for the representation of mcmc chains. 

But other examples are the recently developed [ParetoSmooth.jl](https://github.com/TuringLang/ParetoSmooth.jl) which could be used in the PSIS related examples as a replacement for ParetoSmoothedImportanceSampling.jl and the preliminary work by [SHMUMA](https://github.com/Shmuma/Dagitty.jl) on Dagitty.jl (a potential replacement for StructuralCausalModels.jl).

While StatisticalRethinking v3 focused on making StatisticalRethinking.jl mcmc package independent, StatisticalRethinking v4 aims at de-coupling it from a specific graphical package and thus enables new choices for graphics, e.g. using Makie.jl and AlgebraOfGraphics.jl. 

Also, an attempt has been made to make StatisticalRethinking.jl fit better with the new setup of Pluto notebooks which keep track of used package versions in the notebooks themselves ([see here](https://github.com/fonsp/Pluto.jl/wiki/🎁-Package-management)).

## Workflow of StatisticalRethinkingJulia (v4):

1. Data preparation, typically using CSV.jl, DataFrames.jl and some statistical methods from StatsBase.jl and Statistics.jl. In some cases simulations are used which need Distributions.jl and a few special methods (available in StatisticalRethinking.jl).

2. Define the mcmc model, e.g. using StanSample.jl or Turing.jl, and obtain draws from the model.

3. Capture the draws for further processing. In Turing that is ususally done using MCMCChains.jl, in StanSample.jl v4 it's mostly in the form of a DataFrame, a StanTable, a KeyedArray chains (obtained from AxisKeys.jl).

4. Inspect the chains using statistical and visual methods. In many cases this will need one or more statistical packages and one of the graphical options.

Currently visual options are StatsPlots/Plots based, e.g. in MCMCChains.jl and StatisticalRethinkingPlots.jl.

The above 4 items could all be done by just using StanSample.jl or Turing.jl.

**The book Statistical Rethinking has a different objective and studies how models compare, how models can help (or mislead) and why multilevel modeling might help in some cases.**

For this, additional packages are available, explained and demonstrated, e.g. StructuralCausalModels.jl, ParetoSmoothedImportanceSampling.jl and quite a few more.

## How to use StatisticalRethinking.jl

To work through the StatisticalRethinking book using Julia and Turing, download either of the `projects` [SRTuringJupyter.jl](https://github.com/StatisticalRethinkingJulia/SRTuringJupyter.jl) or [SRTuringPluto.jl](https://github.com/StatisticalRethinkingJulia/SRTuringPluto.jl).

To work through the StatisticalRethinking book using Julia and Stan, download `project` [SRStanPluto.jl](https://github.com/StatisticalRethinkingJulia/SRStanPluto.jl). 

All three projects create a Julia environment where most needed packages are available and can be imported.

In addition to providing a Julia package environment, these also contain chapter by chapter Jupyter or Pluto notebooks to work through the Statistical Rethinking book. 

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

See the notebook examples in the projects for other often used packages.

## Structure of StatisticalRethinkingJulia (v4):

In order to keep environment packages relatively simple (i.e. have a limited set of dependencies on other Julia packages) StatisticalRethinking consists of 2 layers, a top layer containing mcmc dependent methods (e.g. a model comparison method taking Turing.jl or StanSample.jl derived objects) which in turn call common methods in the bottom layer. The same applies for the graphic packages. This feature relies on Requires.jl and the mcmc dependent methods can be found in `src/require` directories.

Consequently, the StatisticalRethinkingJulia ecosystem contains 4 layers:

1. The lowest layer provides mcmc methods, currently Turing.jl and StanSample.jl.

2. Common (mcmc independent) bottom layer in StatisticalRethinking (and StatisticalRethinkingPlots).

3. MCMC dependent top layer in StatisticalRethinking (and StatisticalRethinkingPlots).

4. Chapter by chapter notebooks.
