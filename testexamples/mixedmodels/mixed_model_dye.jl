using DataFrames, MixedModels, RData, StatsBase

const dat = Dict(Symbol(k)=>v for (k,v) in 
           load(joinpath(dirname(pathof(MixedModels)), "..", "test", "dat.rda")));

describe(dat[:Dyestuff])

fm1 = fit(LinearMixedModel, @formula(Y ~ 1 + (1|G)), dat[:Dyestuff])


