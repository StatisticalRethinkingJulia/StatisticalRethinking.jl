using Test

"""
# extract(chns::Array{Float64,3}, cnames::Vector{String})
RStan/PyStan style extract
chns: Array: [draws, vars, chains], cnames: ["lp__", "accept_stat__", "f.1", ...]
Output: name -> [size..., draws, chains]
"""
function extract(chns::Array{Float64,3}, cnames::Vector{String})
    draws, vars, chains = size(chns)

    ex_dict = Dict{String, Array}()

    group_map = Dict{String, Array}()
    for (i, cname) in enumerate(cnames)
        sp_arr = split(cname, ".")
        name = sp_arr[1]
        if length(sp_arr) == 1
            ex_dict[name] = chns[:,i,:]
        else
            if length(sp_arr) > 0 && !(name in keys(group_map))
                group_map[name] = Any[]
            end
            push!(group_map[name], (i, [Meta.parse(i) for i in sp_arr[2:end]]))
        end
    end

    for (name, group) in group_map
        max_idx = maximum(hcat([idx for (i, idx) in group]...), dims=2)[:,1]
        ex_dict[name] = similar(chns, max_idx..., draws, chains)
    end

    for (name, group) in group_map
        for (i, idx) in group
            ex_dict[name][idx..., :, :] = chns[:,i,:]
        end
    end

    return ex_dict
end

cnames = ["x", "y.1", "y.2", "z.1.1", "z.2.1", "z.3.1", "z.1.2", "z.2.2", "z.3.2", "k.1.1.1.1.1"]

key_to_idx = Dict(name => idx for (idx, name) in enumerate(cnames))

draws = 100
vars = length(cnames)
chains = 2
chns = randn(draws, vars, chains);
ex_dict = extract(chns, cnames)
nt = (x = ex_dict["x"], y = ex_dict["y"], z = ex_dict["z"])

@testset "extract" begin
    # Write your tests here.
    
    @test size(ex_dict["x"]) == (draws, chains)
    @test size(ex_dict["y"]) == (2, draws, chains)
    @test size(ex_dict["z"]) == (3, 2, draws, chains)
    @test size(ex_dict["k"]) == (1, 1, 1, 1, 1, draws, chains)

    @test ex_dict["x"][2,1] == chns[2, key_to_idx["x"], 1]
    @test ex_dict["y"][2,3,2] == chns[3, key_to_idx["y.2"], 2]
    @test ex_dict["z"][3, 1, 10, 1] == chns[10, key_to_idx["z.3.1"], 1]
    @test ex_dict["k"][1,1,1,1,1,draws,2] == chns[draws, key_to_idx["k.1.1.1.1.1"], 2]

    @test size(values(nt.z)) == (3, 2, 100, 2)
    @test size(nt.z) == (3, 2, 100, 2)

end
