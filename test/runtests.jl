using StatisticalRethinking, Literate
using Test

chapters = ["00", "02", "03", "04", "08", "10", "11", "12"]
DocDir = joinpath(@__DIR__, "..", "docs", "src")

for chapter in chapters
  ProjDir = joinpath(@__DIR__, "..", "chapters", chapter)
  NotebookDir = joinpath(@__DIR__, "..", "notebooks", chapter)
  !isdir(NotebookDir) && mkdir(NotebookDir)
  !isdir(ProjDir) && break
  cd(ProjDir) do
    
    filelist = readdir()
    for file in filelist
      if !isdir(file) && file[1:4] == "clip" && file[end-2:end] == ".jl"        
        isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
          rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
        if file[end-3:end] == "m.jl"
          isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
            rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
          Literate.notebook(file, NotebookDir, execute=true)
       elseif file[end-3:end] == "s.jl"
          isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
            rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
          Literate.notebook(file, NotebookDir, execute=true)
        else
          isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
            rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
          # Execution will fail for Turing notebooks
          Literate.notebook(file, NotebookDir, execute=false)
        end        
      elseif !isdir(file) && file[1] == 'm' && file[end-2:end] == ".jl"        
        isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
          rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
         Literate.notebook(file, NotebookDir, execute=false)
      end
    end
  end
  println()
end
