using StanSample, NamedTupleTools
using StatisticalRethinking
using Test


tests = ["srtools", "link", "simulate"]
stan_tests = ["wd-loo-compare", "wd-loo-compare2"]

stan_exists()::Bool = "CMDSTAN_HOME" in keys(ENV)


for t ∈ tests
    @testset "$t" begin
        include("test_$t.jl")
    end
end

if stan_exists()
    for t ∈ stan_tests
        @testset "$t" begin
            include("test_$t.jl")
        end
    end
end
