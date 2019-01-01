using StatisticalRethinking
using Literate
using Documenter

# The idea: generate both docs and notebooks using Literate
# Based on ideas and work from Tamas Papp!

DOC_ROOT = rel_path("..", "docs")
DocDir =  rel_path("..", "docs", "src")

for chapter in keys(script_dict)
  ProjDir = rel_path( "..", "chapters", chapter)
  DocDir =  rel_path("..", "docs", "src", chapter)
  
  !isdir(ProjDir) && break
  
  cd(ProjDir) do
    
    for script in script_dict[chapter]
      file = script.script
      if script.doc && script.exe && isfile(file)
        isfile(joinpath(DocDir, file[1:end-3], ".md")) &&
          rm(joinpath(DocDir, file[1:end-3], ".md"))
        Literate.markdown(joinpath(ProjDir, file), DocDir, documenter=true)        
      end
    end
    
    # Remove tmp directory used by cmdstan 
    isdir("tmp") && rm("tmp", recursive=true);
    println("\nCompleted documentation generation for chapter $chapter\n")
    
  end # cd
end # for chapter

makedocs(root = DOC_ROOT,
    modules = Module[],
    sitename = "StatisticalRethinking.jl",
    authors = "Rob Goedman, Richard Torkar, and contributors.",
    pages = [
      "Home" => "intro.md",
      "Layout" => "layout.md",
      "Acknowledgements" => "acknowledgements.md",
      "References" => "references.md",
      "Chapter 0" => [
        "`clip_01_03`" => "00/clip_01_03.md",
        "`clip_04_04`" => "00/clip_04_05.md"
      ],
      "Chapter 2" => [
        "`clip_01_02`" => "02/clip_01_02.md",
        "`clip_03_05`" => "02/clip_03_05.md",
        "`clip_06_07`" => "02/clip_06_07.md",
        "`clip_08s`" => "02/clip_08s.md"
      ],
      "Functions" => "index.md"
      ]
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StanJulia/StatisticalRethinking.jl.git",
 )
