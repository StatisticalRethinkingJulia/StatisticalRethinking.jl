module StatisticalRethinking

using Pkg
using Reexport

@reexport using Distributions, RDatasets, DataFrames, StatsBase, GLM
@reexport using CmdStan, StanMCMCChain, MCMCChain
@reexport using StatsFuns, Optim, Turing, Flux.Tracker
@reexport using Plots, StatPlots
@reexport using CSV, DelimitedFiles

Pkg.resolve()

include("maximum_a_posteriori.jl")

export
  maximum_a_posteriori

end # module
