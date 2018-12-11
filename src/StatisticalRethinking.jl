module StatisticalRethinking

using Reexport 

@reexport using Distributions, RDatasets, DataFrames, StatsBase
@reexport using Plots, StatPlots, StatsFuns, MCMCChain
@reexport using JLD, CSV, DelimitedFiles
@reexport using CmdStan, StanMCMCChain
using Turing

include("maximum_a_posteriori.jl")

export
  maximum_a_posteriori

end # module
