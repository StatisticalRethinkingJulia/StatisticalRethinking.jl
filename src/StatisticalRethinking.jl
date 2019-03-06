module StatisticalRethinking

using Reexport 

@reexport using Distributions, RDatasets, DataFrames
@reexport using StatsBase, StatsPlots, StatsFuns 
@reexport using CSV, DelimitedFiles, Serialization
@reexport using MCMCChains

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

include("link.jl")
include("scriptentry.jl")
include("generate.jl")
include("quap.jl")
include("to_df.jl")

export
  link,
  rel_path,
  ScriptEntry,
  scriptentry,
  script_dict,
  generate,
  quap,
  to_df

end # module
