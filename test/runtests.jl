using StatisticalRethinking, Literate
using Test

chapters = ["00", "02", "03", "04"]
DocDir = joinpath(@__DIR__, "..", "docs", "src")

for chapter in chapters
  ProjDir = joinpath(@__DIR__, "..", "chapters", chapter)
  SnippetDir = joinpath(@__DIR__, "..", "snippets", chapter)
  NotebookDir = joinpath(@__DIR__, "..", "notebooks", chapter)
  println("\nSwitching to directory: $ProjDir\n")
  !isdir(ProjDir) && break
  cd(ProjDir) do
  
    fname = "snippets" * chapter

    Literate.markdown(fname*".jl", DocDir, name=fname, documenter=true)
    Literate.script(fname*".jl", SnippetDir, name=fname)
    Literate.notebook(fname*".jl", NotebookDir, name=fname)
   # println()
    
    if isfile(joinpath(SnippetDir, fname, ".jl"))      
      include(joinpath(SnippetDir, fname, ".jl"))      
    end
  end
end
