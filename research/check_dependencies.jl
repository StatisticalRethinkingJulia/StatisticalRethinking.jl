using StatisticalRethinkingStan
using Pkg.TOML

cd(rel_path(".."))

deps = TOML.parsefile("Project.toml")["deps"]
remove = String[]
for d in keys(deps)
    if !isdefined(StatisticalRethinkingStan, Symbol(d))
        push!(remove, d)
    end
end
println("rm ", join(remove, " "))
