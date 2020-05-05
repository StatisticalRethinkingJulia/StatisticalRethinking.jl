using StatisticalRethinking
using Pkg.TOML
deps = TOML.parsefile("Project.toml")["deps"]
remove = String[]
for d in keys(deps)
    if !isdefined(Proj, Symbol(d))
        push!(remove, d)
    end
end
println("rm ", join(remove, " "))
