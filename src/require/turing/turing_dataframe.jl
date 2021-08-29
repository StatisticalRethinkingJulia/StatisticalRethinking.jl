import DataFrames: DataFrame

DataFrame(m::MCMCChains.Chains; section=:parameters) =
    DataFrame(Dict(n => vec(m[n].data) for n in names(m, section)))

