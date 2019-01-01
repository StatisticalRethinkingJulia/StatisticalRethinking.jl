using StatisticalRethinking, Literate
using Test

DocDir = rel_path("..", "docs", "src")

for chapter in keys(script_dict)
  ProjDir = rel_path("..", "chapters", chapter)
  NotebookDir = rel_path("..", "notebooks")
  !isdir(NotebookDir) && mkdir(NotebookDir)
  
  NotebookDir = rel_path("..", "notebooks", "$(chapter)")
  
  !isdir(ProjDir) && break
  
  cd(ProjDir) do
    for script in script_dict[chapter]
      file = script.script
      if script.nb && isfile(file)
        isfile(joinpath(NotebookDir, file[1:end-3], ".ipynb")) && 
          rm(joinpath(NotebookDir, file[1:end-3], ".ipynb"))          
        Literate.notebook(file, NotebookDir, execute=script.exe)
      end
    end
    
    # Remove tmp directory used by cmdstan 
    isdir("tmp") && rm("tmp", recursive=true);
    println("\nCompleted notebook generation for chapter $chapter\n")
    
  end 
end
