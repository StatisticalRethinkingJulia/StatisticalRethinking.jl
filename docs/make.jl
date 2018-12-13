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

DOC_ROOT = rel_path("..", "docs")
DocDir =  rel_path("..", "docs", "src")
chapters = ["00", "02", "03", "04"]

for chapter in chapters
  ProjDir = rel_path( "..", "chapters", chapter)
  DocDir =  rel_path("..", "docs", "src", chapter)
  
  !isdir(ProjDir) && break
  
  cd(ProjDir) do
    
    filelist = readdir()
    for file in filelist
      if !isdir(file) && file[1:4] == "clip" && file[end-2:end] == ".jl"  
        
        isfile(joinpath(DocDir, file[1:end-3], ".md")) && rm(joinpath(DocDir, file[1:end-3], ".md"))
        Literate.markdown(joinpath(ProjDir, file), DocDir, documenter=true)
        
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
        "`clip_07_07`" => "04/clip_07_07.md",
        "`clip_07_07s`" => "04/clip_07_07s.md"
      ],
    ]
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StanJulia/StatisticalRethinking.jl.git",
 )
