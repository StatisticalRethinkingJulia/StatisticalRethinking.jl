using StatisticalRethinking, Literate

"""

# generate

Generate notebooks and scripts

### Method
```julia
generate(sd = script_dict)
```

### Required arguments

None, all notebooks and scripts are regenerated.

"""
function generate(sd::DataStructures.OrderedDict{AbstractString, Vector{ScriptEntry}} = script_dict)
  DocDir = rel_path("..", "docs", "src")

  for chapter in keys(sd)
    ProjDir = rel_path("..", "scripts", chapter)

    ChapterDir = rel_path("..", "chapters")
    !isdir(ChapterDir) && mkdir(ChapterDir)  
    ChapterDir = rel_path("..", "chapters", "$(chapter)")
    ScriptsDir = rel_path("..", "scripts", "$(chapter)")

    NotebookDir = rel_path("..", "notebooks")
    !isdir(NotebookDir) && mkdir(NotebookDir)  
    NotebookDir = rel_path("..", "notebooks", "$(chapter)")
  
    !isdir(ProjDir) && break
  
    cd(ProjDir) do
      for script in sd[chapter]
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
      isdir(joinpath(ScriptsDir, "tmp")) &&
        rm(joinpath(ScriptsDir, "tmp"), recursive=true);
    
      println("\nCompleted script and notebook generation for chapter $chapter\n")
    
    end 
  end
end

"""

# generate

Generate notebooks and scripts

### Method
```julia
generate(chapter::AbstractString)
```

### Required arguments

Generate notebooks and scripts in chapter.

"""
function generate(chapter::AbstractString; sd=script_dict)
  DocDir = rel_path("..", "docs", "src")
  ProjDir = rel_path("..", "scripts", chapter)

  ChapterDir = rel_path("..", "chapters")
  !isdir(ChapterDir) && mkdir(ChapterDir)  
  ChapterDir = rel_path("..", "chapters", "$(chapter)")
  ScriptsDir = rel_path("..", "scripts", "$(chapter)")

  NotebookDir = rel_path("..", "notebooks")
  !isdir(NotebookDir) && mkdir(NotebookDir)  
  NotebookDir = rel_path("..", "notebooks", "$(chapter)")

  if isdir(ProjDir)

    cd(ProjDir) do
      for script in sd[chapter]
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
      isdir(joinpath(ScriptsDir, "tmp")) &&
        rm(joinpath(ScriptsDir, "tmp"), recursive=true);
  
      println("\nCompleted script and notebook generation for chapter $chapter\n")
  
    end 
  end
end

"""

# generate

Generate a single notebook and script

### Method
```julia
generate(chapter::AbstractString, file::AbstractString)
```

### Required arguments

Generate notebook and script `file` in `chapter`.

"""
function generate(chapter::AbstractString, scriptfile::AbstractString; sd=script_dict)
  DocDir = rel_path("..", "docs", "src")
  ProjDir = rel_path("..", "scripts", chapter)

  ChapterDir = rel_path("..", "chapters")
  !isdir(ChapterDir) && mkdir(ChapterDir)  
  ChapterDir = rel_path("..", "chapters", "$(chapter)")
  ScriptsDir = rel_path("..", "scripts", "$(chapter)")

  NotebookDir = rel_path("..", "notebooks")
  !isdir(NotebookDir) && mkdir(NotebookDir)  
  NotebookDir = rel_path("..", "notebooks", "$(chapter)")

  if isdir(ProjDir)

    cd(ProjDir) do
      for script in sd[chapter]
        !(script.scriptfile == scriptfile) && continue
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
      isdir(joinpath(ScriptsDir, "tmp")) &&
        rm(joinpath(ScriptsDir, "tmp"), recursive=true);
  
      println("\nCompleted script and notebook generation for chapter $chapter\n")
  
    end 
  end
end
