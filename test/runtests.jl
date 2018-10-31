using StatisticalRethinking, Literate
using Test

ProjDir = joinpath(@__DIR__, "..", "chapters", "00")
cd(ProjDir) do
  
println(ProjDir)

Literate.markdown("snippets00.0.jl", ProjDir, name="snippets00.1", documenter=true)
Literate.markdown("snippets00.0.jl", ProjDir, name="snippets00.2", documenter=false)
Literate.script("snippets00.0.jl", ProjDir, name="snippets00.3")
Literate.notebook("snippets00.0.jl", ProjDir, name="snippets00.4")

@test 1 == 1

end