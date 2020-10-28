import DataFrames: DataFrame

function DataFrame(m::MCMCChains.Chains)
    DataFrame(Array(m, :parameters), names(m, :parameters))
end
