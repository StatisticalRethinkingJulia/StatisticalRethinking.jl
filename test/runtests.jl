using StatisticalRethinking, Literate
using Test

#=
chapters = ["00", "02", "03", "04"]
DocDir = joinpath(@__DIR__, "..", "docs", "src")

for chapter in chapters
  ProjDir = joinpath(@__DIR__, "..", "chapters", chapter)
  NotebookDir = joinpath(@__DIR__, "..", "notebooks", chapter)
  !isdir(NotebookDir) && mkdir(NotebookDir)
  println("\nSwitching to directory: $ProjDir\n")
  !isdir(ProjDir) && break
  cd(ProjDir) do
    
    filelist = readdir()
    for file in filelist
      if !isdir(file) && file[1:4] == "clip" && file[end-2:end] == ".jl"  
        
        fname = "snippets" * file[5:end-3]
        
        isfile(joinpath(DocDir, fname, ".md")) && rm(joinpath(DocDir, fname, ".md"))
        Literate.markdown(joinpath(ProjDir, file), DocDir, name=fname, documenter=true)
            
        isfile(joinpath(NotebookDir, fname, ".ipynb")) && rm(joinpath(NotebookDir, fname, ".ipynb"))
        Literate.notebook(file, NotebookDir, name=fname)
        
      end
    end
  end
  println()
end
=#
