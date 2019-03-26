using StatisticalRethinking, StatsBase

ProjDir = @__DIR__
cd(ProjDir)

include("samplechain.jl")

describe(chns)

display(StatsBase.summarystats(chns).summaries[1])
pars = StatsBase.summarystats(chns).summaries[1].value
println()

display(StatsBase.summarystats(chns, section=:internals).summaries[1])
internals = StatsBase.summarystats(chns, section=:internals).summaries[1].value

chns.name_map