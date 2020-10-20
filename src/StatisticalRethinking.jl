module StatisticalRethinking

using Reexport, Requires

@reexport using StatsBase, Statistics
@reexport using LinearAlgebra, Random, Distributions
@reexport using CSV, DataFrames
@reexport using KernelDensity, StatsPlots, LaTeXStrings
@reexport using NamedArrays, StatsFuns
@reexport using MCMCChains, MonteCarloMeasurements
@reexport using BSplines
@reexport using Optim
@reexport using GLM, PrettyTables, Unicode

import StatsBase: sample
import MonteCarloMeasurements:Particles

using StatsFuns: logistic, logit
using DocStringExtensions: SIGNATURES, FIELDS, TYPEDEF

function __init__()
  @require Turing="fce5fe82-541a-59a6-adf8-730c64b5f9a0" include("require/turing.jl")
  @require StanSample="c1514b29-d3a0-5178-b312-660c88baa699" include("require/stan.jl")
  @require StanOptimize="fbd8da12-e93d-5a64-9231-612a0707ab99" include("require/stan.jl")
  @require LogDensityProblems="6fdf6af0-433a-55f7-b3ed-c6c6e0b8df7c" include("require/hmc.jl")
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

"""
sr_path(parts...) = normpath(joinpath(src_path, parts...))

# DrWatson extension
sr_datadir(parts...) = sr_path("..", "data", parts...)

include("scale.jl")
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
#if isdefined(Main, :StanSample)
#  import StanSample: convert_a3d
#end
#include("convert_a3d.jl")
include("plot_density_interval.jl")
include("plotbounds.jl")

export
  sr_path,
  sr_datadir,
  SR

end # module
