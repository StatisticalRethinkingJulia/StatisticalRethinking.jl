module StatisticalRethinking

using Reexport

@reexport using Distributions, RDatasets, DataFrames, StatsBase, GLM
@reexport using Optim, Turing
@reexport using Plots, StatPlots
@reexport using CSV, DelimitedFiles

include("maximum_a_posteriori.jl")

export
  maximum_a_posteriori

end # module
