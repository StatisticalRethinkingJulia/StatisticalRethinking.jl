module StatisticalRethinking

using Requires, StanSample

function __init__()
  @require DataFrames="a93c6f00-e57d-5684-b7b6-d8193f3e46c0" include("require/df.jl")
  @require StatsPlots="f3b207a7-027a-5e70-b257-86293d7955fd" include("require/plotcoef.jl")
  @require MCMCChains="c7f686f2-ff18-58e9-bc7b-31028e88f75d" include("require/chns.jl")
  @require LogDensityProblems="6fdf6af0-433a-55f7-b3ed-c6c6e0b8df7c" include("require/hmc.jl")
  @require MonteCarloMeasurements="0987c9cc-fe09-11e8-30f0-b96dd679fdca" begin
    @require KernelDensity="5ab0869b-81aa-558d-bb23-cbf5423bbe9b" include("require/quap.jl")
  end
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

export
	rel_path,
	link,
 	scale!,
  rescale,
  hpdi,
 	sample,
 	create_a3d,
 	insert_chain,
 	create_mcmcchains

end # module
