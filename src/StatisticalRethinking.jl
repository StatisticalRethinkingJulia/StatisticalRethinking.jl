module StatisticalRethinking

using Reexport

@reexport using StatsBase, Statistics, Random, Distributions
@reexport using CSV, DataFrames
@reexport using KernelDensity, StatsPlots, LaTeXStrings
@reexport using NamedArrays
@reexport using MCMCChains

#using UnicodePlots
using StatsFuns: logistic, logit

import StatsBase: sample

using DocStringExtensions: SIGNATURES, FIELDS, TYPEDEF

const src_path = @__DIR__

"""

# rel_path

Relative path using the StatisticalRethinking src/ directory.

### Example to get access to the data subdirectory
```julia
rel_path("..", "data")
```

"""
rel_path(parts...) = normpath(joinpath(src_path, parts...))

include("scale.jl")
include("rescale.jl")
include("link.jl")
include("hpdi.jl")
include("df.jl")
include("quap.jl")
include("pairsplot.jl")
include("plotbounds.jl")
include("simulate.jl")
#include("precis.jl")
include("tools.jl")
include("sim_happiness.jl")

export
  rel_path,
  link,
  scale!,
  rescale,
  sample,
  hpdi,
  quap

end # module
