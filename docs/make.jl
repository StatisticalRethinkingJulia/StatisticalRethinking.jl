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
        isfile(joinpath(DocDir, file[1:end-4], "s.md")) &&
          rm(joinpath(DocDir, file[1:end-4], "s.md"))
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
      "Home" => "index.md",
      "Chapter 0" => [
        "`clip_01_03`" => "00/clip_01_03.md",
        "`clip_04_04`" => "00/clip_04_05.md"
      ],
      "Chapter 2" => [
        "`clip_01_02`" => "02/clip_01_02.md",
        "`clip_03_05`" => "02/clip_03_05.md",
        "`clip_06_07`" => "02/clip_06_07.md",
        "`clip_08t`" => "02/clip_08t.md",
        "`clip_08m`" => "02/clip_08m.md",
        "`clip_08s`" => "02/clip_08s.md"
      ],
      "Chapter 3" => [
        "`clip_01`" => "03/clip_01.md",
        "`clip_02_05`" => "03/clip_02_05.md",
        "`clip_05s`" => "03/clip_05s.md",
        "`clip_06_16s`" => "03/clip_06_16s.md"
      ],
      "Chapter 4" => [
        "`clip_01_06`" => "04/clip_01_06.md",
        "`clip_07.0s`" => "04/clip_07.0s.md",
        "`clip_07.1s`" => "04/clip_07.1s.md",
        "`clip_38.0s`" => "04/clip_38.0s.md",
        "`clip_38.7s`" => "04/clip_38.7s.md",
        "`clip_38.0m`" => "04/clip_38.0m.md",
        "`clip_38.1m`" => "04/clip_38.1m.md",
        "`clip_43s`" => "04/clip_43s.md",
        "`clip_43t`" => "04/clip_43t.md",
        "`clip_45_47s`" => "04/clip_45_47s.md",
        "`clip_48_54s`" => "04/clip_48_54s.md"
      ],
      "Chapter 5" => [
        "`clip_01s`" => "05/clip_01s.md"
      ],
      "Chapter 8" => [
        "`m8.1t.jl`" => "08/m8.1t.md"
      ]
    ]
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StanJulia/StatisticalRethinking.jl.git",
 )
