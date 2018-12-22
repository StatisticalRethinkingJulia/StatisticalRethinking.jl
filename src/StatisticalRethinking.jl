module StatisticalRethinking

using Reexport 

@reexport using Distributions, RDatasets, DataFrames, StatsBase
@reexport using Plots, StatPlots, StatsFuns, MCMCChain
@reexport using JLD, CSV, DelimitedFiles
@reexport using CmdStan, StanMCMCChain
@reexport using Turing

const src_path = @__DIR__

"""

# rel_path

Relative path using the StatisticalRethinking src/ directory.
Copied from DynamicHMCEcmaples.jl

### Example to get access to the data subdirectory
```julia
rel_path("..", "data")
```
"""
rel_path(parts...) = normpath(joinpath(src_path, parts...))

include("maximum_a_posteriori.jl")

export
  maximum_a_posteriori,
  rel_path

end # module
