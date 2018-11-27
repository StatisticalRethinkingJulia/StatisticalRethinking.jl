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
    sitename = "StatisticalRethinking.jl",
    pages = vcat(Any["index.md"],
      Any[file for file in pagelist])
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StanJulia/StatisticalRethinking.jl.git",
 )
