module StatisticalRethinking

#using Reexport 

#@reexport using Distributions, Random
#@reexport using RDatasets, DataFrames
#@reexport using StatsBase, StatsPlots, StatsFuns 
#@reexport using CSV, DelimitedFiles, Serialization
#@reexport using MCMCChains, KernelDensity
#@reexport using Parameters, Random, MonteCarloMeasurements

#using DataStructures
import StatsBase: sample
#import MCMCChains: describe

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

include("sampling.jl")
include("scale.jl")
include("shading.jl")
include("generate_n_samples.jl")
include("link.jl")
#include("HMC.jl")
#include("dhmc2mcmcchains.jl")
include("quap.jl")

export
	rel_path,
	link,
 	quap,
 	scale,
 	sample,
 	create_a3d,
 	insert_chain,
 	create_mcmcchains
 	#shade

end # module
