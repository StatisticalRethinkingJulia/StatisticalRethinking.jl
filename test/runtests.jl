using StatisticalRethinking, Literate
using Test

chapters = ["00", "02"]

for chapter in chapters
  ProjDir = joinpath(@__DIR__, "..", "chapters", chapter)
  cd(ProjDir) do
  
    println(ProjDir)
    fname = "snippets" * chapter

    if isfile(fname * ".3.jl")
      
      include(joinpath("..", "chapters", chapter,  fname*".3.jl"))
      
      #=
      Literate.markdown(fname*".0.jl", ProjDir, name=fname*".1", documenter=true)
      Literate.markdown(fname*".0.jl", ProjDir, name=fname*".2", documenter=false)
      Literate.script(fname*".0.jl", ProjDir, name=fname*".3")
      Literate.notebook(fname*".0.jl", ProjDir, name=fname*".4")
      =#
    end
    
    @test 1 == 1
  end
end