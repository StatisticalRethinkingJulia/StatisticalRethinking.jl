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

DOC_ROOT = rel_path("../docs")

chapters = ["00", "02", "03", "04"]

filelist = readdir(joinpath(DOC_ROOT, "src"))
pagelist = String[]
for file in filelist
  if !isdir(file) && file[1:8] == "snippets" && file[end-2:end] == ".md"  
    push!(pagelist, file)
  end
end

makedocs(root = DOC_ROOT,
    modules = Module[],
    clean = false,
    sitename = "StatisticalRethinking.jl",
    authors = "Rob Goedman, Richard Torkar, and contributors.",
    linkcheck = !("skiplinks" in ARGS),
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
