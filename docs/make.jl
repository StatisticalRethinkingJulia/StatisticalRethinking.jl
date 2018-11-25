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

CHAPTERS_ROOT = rel_path("../chapters") # Source directory

# Target directories for Literate
DOC_ROOT = rel_path("../docs/md")
SN_ROOT = rel_path("../snippets")
NB_ROOT = rel_path("../notebooks")

chapters = ["00", "02", "03", "04", "05"]

for chapter in chapters
  ProjDir = joinpath(@__DIR__, "..", "chapters", chapter)
  println("\nSwitching to directory: $ProjDir\n")
  !isdir(ProjDir) && break
  cd(ProjDir) do
  
    mdname = "snippets" * chapter

    Literate.markdown(fname*".jl", joinpath(DOC_ROOT, chapter), name=fname, documenter=true)
    Literate.script(fname*".jl", joinpath(SN_ROOT, chapter), name=fname)
    Literate.notebook(fname*".jl", joinpath(NB_ROOT, chapter), name=fname)
   # println()
    
    if isfile(joinpath(SN_ROOT, chapter, fname, ".jl")      
      include(joinpath(SN_ROOT, chapter, fname, ".jl"))      
    end
  end
end


makedocs(root = DOC_ROOT,
    modules = Module[],
    sitename = "StatisticalRethinking.jl",
    pages = vcat(Any["index.md"],
      Any["snippet_$(chapter).md" for chapter in chapter])
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StanJulia/StatisticalRethinking.jl.git"
 )
