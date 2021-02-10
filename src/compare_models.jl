"""

# compare

Compare waic and psis values for models.

$(SIGNATURES)

"""
function compare(m::Vector{Matrix{Float64}}, ::Val{:waic})
    df = DataFrame()
    
    waics = Vector{NamedTuple}(undef, length(m))
    for i in 1:length(m)
        waics[i] = waic(m[i])
    end
    
    ind = sortperm([waics[i].WAIC for i in 1:length(waics)])
    waics = waics[ind]
    mods = m[ind]

    waics_pw = Vector{Vector{Float64}}(undef, length(m))
    for i in 1:length(m)
        waics_pw[i] = waic(mods[i]; pointwise=true).WAIC
    end
    
    df.WAIC = round.([waics[i].WAIC for i in 1:length(waics)], digits=1)
    df.SE = round.([waics[i].std_err for i in 1:length(waics)], digits=2)
    
    dwaics = zeros(length(m))
    for i in 2:length(m)
        dwaics[i] = df[i, :WAIC] - df[1, :WAIC]
    end
    df.dWAIC = round.(dwaics, digits=1)
    dse = zeros(length(m))
    for i in 2:length(m)
        diff = waics_pw[1] .- waics_pw[i]
        println(diff)
        dse[i] = √(length(waics_pw[1]) * var(diff))
    end
    df.dSE = round.(dse, digits=2)
    df.pWAIC = round.([sum(waics[i].penalty) for i in 1:length(waics)], digits=1)
    weights = ones(length(m))
    sumval = sum([exp(-0.5df[i, :WAIC]) for i in 1:3])
    for i in 1:length(m)
        weights[i] = exp(-0.5df[i, :WAIC])/sumval
    end
    df.weight = round.(weights, digits=0)
    df
end

export
    compare