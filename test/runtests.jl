using StatisticalRethinking
using Test

tests = ["srtools"]

for t ∈ tests
    @testset "$t" begin
        include("test_$t.jl")
    end
end
