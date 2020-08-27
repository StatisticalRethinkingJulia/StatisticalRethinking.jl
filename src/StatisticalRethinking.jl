module StatisticalRethinking

using Reexport

@reexport using StatsBase, Statistics, Random, Distributions
@reexport using CSV, DataFrames
@reexport using KernelDensity, StatsPlots, LaTeXStrings
@reexport using NamedArrays, StatsFuns
@reexport using MCMCChains, MonteCarloMeasurements
@reexport using BSplines, Optim

using StatsFuns: logistic, logit
import StatsBase: sample

using DocStringExtensions: SIGNATURES, FIELDS, TYPEDEF

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

include("scale.jl")
include("rescale.jl")
include("link.jl")
include("hpdi.jl")
include("df.jl")
include("quap.jl")
include("pairsplot.jl")
include("plotbounds.jl")
include("simulate.jl")
include("tools.jl")
include("sim_happiness.jl")

export
  sr_path,
  SR

end # module
