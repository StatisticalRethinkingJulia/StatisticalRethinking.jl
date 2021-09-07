## Github organization

StatisticalRethinking.jl is part of the broader [StatisticalRethinkingJulia](https://github.com/StatisticalRethinkingJulia) Github organization.

Implementations of most models using Stan, DynamicHMC and Turing can currently be found in [StanModels](https://github.com/StatisticalRethinkingJulia/StanModels.jl), [DynamicHMCModels](https://github.com/StatisticalRethinkingJulia/DynamicHMCModels.jl) and [TuringModels](https://github.com/StatisticalRethinkingJulia/TuringModels.jl).

## Why StatisticalRethinking v4?

Over time more and better options become available to express the material covered in Statistical Rethinking. Examples are KeyedArrays as introduced in AxisKeys.jl for the representation of mcmc chains, the recently developed ParetoSmooth.jl for PSIS related examples and the preliminary work by [SHMUMA](https://github.com/Shmuma/Dagitty.jl) on a better Dagitty.jl (vs. StructuralCausalModels.jl)

While StatisticalRethinking v3 focused on making StatisticalRethinking.jl mcmc package independendent, StatisticalRethinking v4 is decoupled from a specific graphical package and thus enables new choices for graphics, e.g. using Makie.jl and AlgebraOfGraphics.jl. 

Also, an attempt has been made to make StatisticalRethinking.jl fit better with the new setup of Pluto notebooks which keep track of used package versions in the notebooks themselves ([see here](https://github.com/fonsp/Pluto.jl/wiki/🎁-Package-management)).

## Workflow of StatisticalRethinkingJulia (v4):

1. Data preparation, typically using CSV.jl, DataFrames.jl and some statistical methods from StatsBase.jl and Statistics.jl. In some cases simulations are used and need Distributions.jl and a few special methods available in StatisticalRethinking.jl.

2. Define the mcmc model, e.g. using StanSample.jl or Turing.jl, and obtain draws from the model.

3. Capture the draws for further processing. In Turing that is ususally done using MCMCChains.jl, in StanSample.jl v4 it's mostly in the form of KeyedArray chains as derived from AxisKeys.jl.

4. Inspect the chains using statistical and visual methods. In many cases this will need one or more statistical packages and one of the graphical options. Currently most visual options are StatsPlots/Plots based, e.g. in MCMCChains.jl and StatisticalRethinkingPlots.jl. The setup of StatisticalRethinking v4 enables the future introduction of a new package, StatisticalRethinkingMakie which will be based on Makie.jl and AlgebraOfGraphics.jl.

5. The above 4 items could all be done by just using StanSample.jl or Turing.jl. The book Statistical Rethinking studies how models compare, how models can help (or mislead) and why multilevel modeling might help in some cases.

6. For this, additional packages are available, explained and demonstrated, e.g. StructuralCausalModels.jl, ParetoSmooth.jl and quite a few more.

### Using StatisticalRethinking v4

To work through the StatisticalRethinking book using Julia and Stan, download `project` [StatisticalRethinkingStan.jl](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingStan.jl). 

To work through the StatisticalRethinking book using Julia and Turing, download `project` [StatisticalRethinkingTuring.jl](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingTuring.jl). 

Both projects create a Julia environment where most needed packages are available.

In addition to providing a Julia package environment, these also contain chapter by chapter Pluto notebooks to work through the Statistical Rethinking book. 

In order to keep environment packages relatively simple (i.e. have a limited set of dependenies on other Julia packages) StatisticalRethinking consists of 2 layers, a top layer containing mcmc dependent methods (e.g. a model comparison method taking Turing.jl or StanSample.jl derived objects) which in turn call common methods in the bottom layer. The same applies for the graphic packages. This feature relies on Requires.jl and the mcmc dependent methods can be found in `src/require` directories.

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

On a high level, the StatisticalRethinkingJulia eco system contains 4 layers:

1. The lowest layer provides mcmc methods, currently Turing.jl and StanSample.jl.

2. Common (mcmc independent) bottom layer in StatisticalRethinking (and StatisticalRethinkingPlots).

3. MCMC dependent top layer in StatisticalRethinking (and StatisticalRethinkingPlots).

4. Chapter by chapter notebooks.

## Future possible projects

A start has been made with a similar [project](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingTuring.jl) using Julia and Turing, but unfortunately only the first 5 chapters have been completed. I just don't have the time to continue to work and complete that project. Luckily there is an excellent other package, [TuringModels.jl](https://github.com/StatisticalRethinkingJulia/TuringModels.jl) that contains a selection of the Statistical Rethinking models in Turing.jl's PPL. There is also [Shuma](https://github.com/Shmuma/rethinking-2ed-julia) which is another good starting point to use Turing.jl.

Along similar lines, I would love to see a StatisticalRethinkingDhmc.jl, which could be a combination of Soss.jl and DynamicHMC.jl, and a StatisticalRethinkingMamba.jl!

If interested in either of these projects, please contact me!

## Some background info on previuos versions

Given that Julia provides several very capable packages that support mcmc simulation, it only seemed appropriate to make StatisticalRethinking (v3) on Julia mcmc implementation independent.

The availablility of DynamicHMC, the huge progress made by the Turing.jl team over the last 2 years, the introduction of Julia `projects` in addition to Julia `packages`, the novel approach to notebooks in Pluto.jl and the work by [Karajan](https://github.com/karajan9/statisticalrethinking) and currently [Shuma](https://github.com/Shmuma/rethinking-2ed-julia) were a few of the ideas that triggered exploring a new setup for StatisticalRethinking.jl and the 'course' projects [StatistcalRethinkingStan](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingStan.jl) and [StatisticalrethinkingTuring](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingTuring.jl)

An early, experimental version of [StructuralCausalModels.jl](https://github.com/StatisticalRethinkingJulia/StructuralCausalModels.jl) is also included as a dependency in the StatisticalRethinking.jl package. In the meantime I will definitely keep my eyes on [Dagitty.jl](https://github.com/Shmuma/Dagitty.jl), [Omega.jl](https://github.com/zenna/Omega.jl) and [CausalInference.jl](https://github.com/mschauer/CausalInference.jl). In particular Dagitty.jl has very similar objectives as StructuralCausalModels.jl and over time might replace it in the StatisticalRethinkingJulia ecosystem. For now, StructuralCausalModels does provide ways to convert DAGs to Dagitty and ggm formats.

The in v3 added introduced dependency [StatsModelComparisons.jl](https://github.com/StatisticalRethinkingJulia/StatsModelComparisons.jl) which provides PSIS and WAIC statistics for model selection is deprecated in v4. For PSIS and LOO ParetoSmooth.jl is now used and WAIC has been moved to StatisticalRethinking.jl

Finally, for a good while I have been looking for a great statistics book using Julia as kind of an introductory text to StatisticalRethinking and I believe the first couple of chapters in an upcoming book [Statistics with Julia](https://statisticswithjulia.org/index.html) by Yoni Nazarathy and Hayden Klok are exactly that.

As [StatisticalRethinking](https://github.com/StatisticalRethinkingJulia) v3/4 is also (DrWatson & Pkg) project based and uses Pluto notebooks, I have converted the book `listings` in the first 5 chapters to Pluto Notebooks in a new repository in StatisticalRethinkingJulia, i.e. [StatisticsWithJuliaPlutoNotebooks](https://github.com/StatisticalRethinkingJulia/StatisticsWithJuliaPlutoNotebooks.jl). 

After chapter 4, `Statistics with Julia` follows the frequentionist approach while `Statistical Rethinking` opts for the Bayesian approach. Most of the material in chapters 5 and 6 of `Statistics with Julia` is therefore also covered using a more Bayesian perspective in the early chapters of the notebook projects [StatisticalRethinkingStan](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingStan.jl) and [StatisticalRethinkingTuring](https://github.com/StatisticalRethinkingJulia/StatisticalRethinkingTuring.jl). 
