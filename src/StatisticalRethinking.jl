module StatisticalRethinking

using Reexport

@reexport using Distributions, RDatasets, DataFrames, StatsBase, GLM
@reexport using Optim, Turing, Flux.Tracker
@reexport using Plots, StatPlots
@reexport using CSV, DelimitedFiles
@reexport using CmdStan, StanMCMCChain, MCMCChain

include("maximum_a_posteriori.jl")

export
  maximum_a_posteriori

end # module
