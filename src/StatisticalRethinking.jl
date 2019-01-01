module StatisticalRethinking

using Reexport 

@reexport using Distributions, RDatasets, DataFrames, StatsBase
@reexport using Plots, StatPlots, StatsFuns, MCMCChain
@reexport using JLD, CSV, DelimitedFiles
@reexport using CmdStan, StanMCMCChain
@reexport using Turing, MLDataUtils
using DataStructures

const src_path = @__DIR__

"""

# rel_path

Relative path using the StatisticalRethinking src/ directory. Copied from
[DynamicHMCExamples.jl](https://github.com/tpapp/DynamicHMCExamples.jl)

### Example to get access to the data subdirectory
```julia
rel_path("..", "data")
```
"""
rel_path(parts...) = normpath(joinpath(src_path, parts...))

include("maximum_a_posteriori.jl")
include("link.jl")
include("script_entries.jl")

export
  maximum_a_posteriori,
  link,
  rel_path,
  Script_entry,
  script_dict

end # module
