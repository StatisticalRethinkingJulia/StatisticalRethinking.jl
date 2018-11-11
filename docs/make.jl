using Documenter, StatisticalRethinking

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
