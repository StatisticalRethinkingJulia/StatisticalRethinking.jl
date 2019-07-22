module StatisticalRethinking

using Reexport 

@reexport using Distributions, RDatasets, DataFrames
@reexport using StatsBase, StatsPlots, StatsFuns 
@reexport using CSV, DelimitedFiles, Serialization
@reexport using MCMCChains, KernelDensity

using DataStructures
import StatsBase: sample

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
include("sampling.jl")
include("scale.jl")
include("shading.jl")
include("HMC2.jl")
include("generate_n_samples.jl")

export
  rel_path,
  ScriptEntry,
  scriptentry,
  script_dict,
  generate,
  quap,
  link,
  #shade,
  scale,
  standardize,
  HMC2,
  generate_n_samples

end # module
