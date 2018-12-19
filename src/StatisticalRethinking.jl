module StatisticalRethinking

using Reexport 

@reexport using Distributions, RDatasets, DataFrames, StatsBase
@reexport using Plots, StatPlots, StatsFuns, MCMCChain
@reexport using JLD, CSV, DelimitedFiles
@reexport using CmdStan, StanMCMCChain
@reexport using Turing

const src_path = @__DIR__

"Relative path using the StatisticalRethinking src/ directory."
rel_path(parts...) = normpath(joinpath(src_path, parts...))

include("maximum_a_posteriori.jl")

export
  maximum_a_posteriori,
  rel_path

end # module
