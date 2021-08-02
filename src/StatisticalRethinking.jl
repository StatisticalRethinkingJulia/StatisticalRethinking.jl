module StatisticalRethinking

using Reexport, Requires

@reexport using StatsBase, Statistics
@reexport using ParetoSmooth
@reexport using StructuralCausalModels
@reexport using LinearAlgebra, Random, Distributions
@reexport using CSV, DataFrames
@reexport using KernelDensity
@reexport using StatsPlots, LaTeXStrings
@reexport using NamedArrays, StatsFuns
@reexport using MCMCChains, MonteCarloMeasurements
@reexport using BSplines, GLM
@reexport using Optim, NamedTupleTools
@reexport using PrettyTables, Unicode
@reexport using Makie, AlgebraOfGraphics

import StatsBase: sample
import MonteCarloMeasurements:Particles

using DocStringExtensions: SIGNATURES, FIELDS, TYPEDEF

function __init__()
  @require Turing="fce5fe82-541a-59a6-adf8-730c64b5f9a0" include("require/turing/turing.jl")
  @require StanSample="c1514b29-d3a0-5178-b312-660c88baa699" include("require/stan/sample.jl")
  #@require StanOptimize="fbd8da12-e93d-5a64-9231-612a0707ab99" include("require/stan/optimize.jl")
  @require LogDensityProblems="6fdf6af0-433a-55f7-b3ed-c6c6e0b8df7c" include("require/dhmc/dhmc.jl")
end

const src_path = @__DIR__
const SR = StatisticalRethinking

"""

# sr_path

Relative path using the StatisticalRethinking src/ directory.

### Example to get access to the data subdirectory
```julia
sr_path("..", "data")
```

Note that in the projects, e.g. StatisticalRethinkingStan.jl and StatisticalRethinkingTuring.jl, the
DrWatson approach is a better choics, i.e: `sr_datadir(filename)`

"""
sr_path(parts...) = normpath(joinpath(src_path, parts...))

# DrWatson extension
"""

# sr_datadir

Relative path using the StatisticalRethinking src/ directory.

### Example to access `Howell1.csv` in StatisticalRethinking:
```julia
df = CSV.read(sr_datadir("Howell1.csv"), DataFrame)
```
"""
sr_datadir(parts...) = sr_path("..", "data", parts...)

include("scale.jl")             # Rename to standardize of zscore?
#include("center.jl")            # Center columns of a df, todo.
include("rescale.jl")
include("link.jl")
include("hpdi.jl")
include("df.jl")
include("quap.jl")
include("particles.jl")
include("precis.jl")
include("pairsplot.jl")
include("simulate.jl")
include("srtools.jl")
include("sim_happiness.jl")
include("plot_density_interval.jl")
include("plotbounds.jl")
include("plotlines.jl")
include("pluto_helpers.jl")
include("sim_train_test.jl")
include("lppd.jl")
include("logprob.jl")
include("compare_models.jl")
include("plot_models.jl")
include("trankplot.jl")
include("hmc.jl")
include("plot_model_coef.jl")
include("plot_logistic_coef.jl")
include("pk_utilities.jl")
include("waic.jl")

export
  sr_path,
  sr_datadir,
  SR

end # module
