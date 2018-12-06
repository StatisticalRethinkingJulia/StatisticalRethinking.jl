module StatisticalRethinking

using Reexport 

@reexport using Distributions, RDatasets, DataFrames, StatsBase
@reexport using Plots, StatPlots, MCMCChain
@reexport using CSV, DelimitedFiles
@reexport using Turing

include("maximum_a_posteriori.jl")

export
  maximum_a_posteriori

end # module
