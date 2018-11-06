using StatisticalRethinking, Literate
using Test

chapters = ["00", "02", "03"]

for chapter in chapters
  ProjDir = joinpath(@__DIR__, "..", "chapters", chapter)
  cd(ProjDir) do
  
    println("\nIn directory: $ProjDir\n")
    fname = "snippets" * chapter

    Literate.markdown(fname*".0.jl", ProjDir, name=fname*".1", documenter=true)
    Literate.markdown(fname*".0.jl", ProjDir, name=fname*".2", documenter=false)
    Literate.script(fname*".0.jl", ProjDir, name=fname*".3")
    Literate.notebook(fname*".0.jl", ProjDir, name=fname*".4")
    
    if isfile(fname * ".3.jl")      
      include(joinpath("..", "chapters", chapter,  fname*".3.jl"))      
    end
    
    @test 1 == 1
  end
end