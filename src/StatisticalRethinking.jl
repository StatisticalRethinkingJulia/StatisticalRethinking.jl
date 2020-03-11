module StatisticalRethinking

using Reexport, Requires

@reexport using StanSample, StatsBase, Statistics
@reexport using CSV, DataFrames, Random, Distributions
@reexport using KernelDensity, MonteCarloMeasurements

import StatsBase: sample

function __init__()
  @require StatsPlots="f3b207a7-027a-5e70-b257-86293d7955fd" include("require/plots.jl")
  @require MCMCChains="c7f686f2-ff18-58e9-bc7b-31028e88f75d" include("require/chns.jl")
  @require LogDensityProblems="6fdf6af0-433a-55f7-b3ed-c6c6e0b8df7c" include("require/hmc.jl")
end

using DocStringExtensions: SIGNATURES, FIELDS, TYPEDEF

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

include("scale.jl")
include("rescale.jl")
include("link.jl")
include("a3d_utils.jl")
include("hpdi.jl")
include("df.jl")
include("quap.jl")

export
	rel_path,
	link,
 	scale!,
  rescale,
 	sample,
  hpdi,
  convert_a3d,
  quap

end # module
