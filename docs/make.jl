using StatisticalRethinking
using Literate
using Documenter
using Random
Random.seed!(UInt32[0x57a97f0d, 0x1a38664c, 0x0dddb228, 0x7dbba96f])

makedocs(
    modules = [StatisticalRethinking],
    format = :html,
    checkdocs = :exports,
    sitename = "StatisticalRethinking.jl",
    pages = Any["index.md"]
)

deploydocs(
    repo = "github.com/goedman/StatisticalRethinking.jl.git",
)


#=

# The idea: generate both docs and notebooks using Literate
# Again based on ideas from Tamas Papp!

const src_path = @__DIR__

"Relative path using the DynamicHMCExamples src/ directory."
rel_path(parts...) = normpath(joinpath(src_path, parts...))

DOCROOT = rel_path("../docs")
DOCSOURCE = joinpath(DOCROOT, "src")
EXAMPLES = ["independent_bernoulli", "linear_regression", "logistic_regression"]

for example in EXAMPLES
    Literate.markdown(rel_path("example_$(example).jl"), DOCSOURCE)
end


# render & deploy using Documenter

makedocs(root = DOCROOT,
         modules = Module[],
         sitename = "DynamicHMCExamples.jl",
         pages = vcat(Any["index.md"],
                      Any["example_$(example).md" for example in EXAMPLES]))

deploydocs(root = DOCROOT,
           repo = "github.com/tpapp/DynamicHMCExamples.jl.git")

=#