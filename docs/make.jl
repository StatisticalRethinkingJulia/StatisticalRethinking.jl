using StatisticalRethinking
using Literate
using Documenter
using Random
Random.seed!(UInt32[0x57a97f0d, 0x1a38664c, 0x0dddb228, 0x7dbba96f])

# The idea: generate both docs and notebooks using Literate
# Again based on ideas from Tamas Papp!

const src_path = @__DIR__

"Relative path using the StatisticalRethinking src/ directory."
rel_path(parts...) = normpath(joinpath(src_path, parts...))

DOC_ROOT = rel_path("../docs/src")
chapters = ["00", "02", "03", "04"]

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

makedocs(root = DOC_ROOT,
    modules = Module[],
    sitename = "StatisticalRethinking.jl",
    authors = "Rob Goedman, Richard Torkar, and contributors.",
    pages = [
      "Home" => "index.md",
      "Chapter 0" => [
        "`Snippets_00_01_03`" => "snippets_00_01_03.md",
        "`Snippets_00_04_04`" => "snippets_00_04_05.md"
      ],
      "Chapter 2" => [
        "`Snippets_02_01_02`" => "snippets_02_01_02.md",
        "`Snippets_02_03_05`" => "snippets_02_03_05.md",
        "`Snippets_02_06_07`" => "snippets_02_06_07.md",
      ],
      "Chapter 3" => [
        "`Snippets_03_01_01`" => "snippets_03_01_01.md"
        "`Snippets_03_02_02`" => "snippets_03_02_02.md"
      ],
      "Chapter 4" => [
        "`Snippets_04_01_07`" => "snippets_04_01_07.md"
      ],
    ]
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StanJulia/StatisticalRethinking.jl.git",
 )
