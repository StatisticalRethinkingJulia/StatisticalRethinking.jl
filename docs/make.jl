using Documenter, StatisticalRethinking

makedocs(
    modules = [StatisticalRethinking],
    format = :html,
    sitename = "StatisticalRethinking.jl",
    pages = Any["index.md"]
)

deploydocs(
    repo = "github.com/goedman/StatisticalRethinking.jl.git",
    target = "build",
    julia = "1.0",
    deps = nothing,
    make = nothing,
)
