using StatisticalRethinking, Literate
using Test

DocDir = rel_path("..", "docs", "src")

for chapter in keys(script_dict)
  ProjDir = rel_path("..", "scripts", chapter)

  ChapterDir = rel_path("..", "chapters")
  !isdir(ChapterDir) && mkdir(ChapterDir)  
  ChapterDir = rel_path("..", "chapters", "$(chapter)")

  NotebookDir = rel_path("..", "notebooks")
  !isdir(NotebookDir) && mkdir(NotebookDir)  
  NotebookDir = rel_path("..", "notebooks", "$(chapter)")
  
  !isdir(ProjDir) && break
  
  cd(ProjDir) do
    for script in script_dict[chapter]
      file = script.scriptfile
      
      # Generate chapters
      
      isfile(joinpath(ChapterDir, file[1:end-3], ".jl")) && 
        rm(joinpath(ChapterDir, file[1:end-3], ".jl"))          
      Literate.script(file, ChapterDir)
      
      # Generate notebooks
      
      if script.nb && isfile(file)
        isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
          rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
        Literate.notebook(file, NotebookDir, execute=script.exe)
      end
    end
    
    # Remove tmp directory used by cmdstan 
    isdir(joinpath(ChapterDir, "tmp")) &&
      rm(joinpath(ChapterDir, "tmp"), recursive=true);
    
    println("\nCompleted script and notebook generation for chapter $chapter\n")
    
  end 
end
