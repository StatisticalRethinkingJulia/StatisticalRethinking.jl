"""

# compare

Compare waic and psis values for models.

$(SIGNATURES)

### Required arguments
```julia
* `models`                             : Vector of logprob matrices
* `criterium`                          : Either ::Val{:waic} or ::Val{:psis}
```

### Optional argument
```julia
* `mnames::Vector{Symbol}`             : Vector of model names
```

### Return values
```julia
* `df`                                 : DataFrame with statistics
```

"""
function compare(m::Vector{Matrix{Float64}}, ::Val{:waic};
    mnames=[])

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
    
    if length(mnames) > 0
        df.models = Symbol.(mnames[ind])
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
        dse[i] = √(length(waics_pw[1]) * var(diff))
    end
    df.dSE = round.(dse, digits=2)
    df.pWAIC = round.([sum(waics[i].penalty) for i in 1:length(waics)],
        digits=2)
    weights = ones(length(m))
    sumval = sum([exp(-0.5df[i, :WAIC]) for i in 1:length(waics)])
    for i in 1:length(m)
        weights[i] = exp(-0.5df[i, :WAIC])/sumval
    end
    df.weight = round.(weights, digits=2)
    df
end

function compare(m::Vector{Matrix{Float64}}, ::Val{:psis};
    mnames=[])

    df = DataFrame()
    loo = Vector{Float64}(undef, length(m))
    loos = Vector{Vector{Float64}}(undef, length(m))
    pk = Vector{Vector{Float64}}(undef, length(m))
    for i in 1:length(m)
        loo[i], loos[i], pk[i] = psisloo(m[i])
    end
    ind = sortperm([-2loo[i][1] for i in 1:length(loo)])
    mods = m[ind]
    loo = loo[ind]
    loos = loos[ind]
    pk = pk[ind]

    if length(mnames) > 0
        df.models = Symbol.(mnames[ind])
    end

    df.PSIS = round.([-2loo[i] for i in 1:length(loo)], digits=1)
    df.SE = round.([sqrt(size(m[i], 2)*var2(-2loos[i])) for i in 1:length(loos)],
        digits=2)
    
    dloo = zeros(length(m))
    for i in 2:length(m)
        dloo[i] = df[i, :PSIS] - df[1, :PSIS]
    end
    df.dPSIS = round.(dloo, digits=1)
    dse = zeros(length(m))
    for i in 2:length(m)
        diff = loos[1] .- loos[i]
        dse[i] = √(length(loos[i]) * var2(diff))
    end
    df.dSE = round.(dse, digits=2)
    df.pPSIS = round.([sum(abs.(pk[i])) for i in 1:length(loo)], digits=2)
    weights = ones(length(m))
    sumval = sum([exp(-0.5df[i, :PSIS]) for i in 1:3])
    for i in 1:length(m)
        weights[i] = exp(-0.5df[i, :PSIS])/sumval
    end
    df.weight = round.(weights, digits=2)
    df
end

compare(m::Vector{Matrix{Float64}}, type::Symbol; mnames=[]) =
    compare(m, Val(type); mnames=Symbol.(mnames))

export
    compare