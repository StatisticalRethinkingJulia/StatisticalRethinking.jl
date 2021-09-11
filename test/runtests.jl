using StanSample, NamedTupleTools
using StatisticalRethinking
using Test


tests = ["srtools", "link", "simulate", "lppd"]
stan_tests = ["wd-loo-compare",]

stan_exists()::Bool = "JULIA_CMDSTAN_HOME" in keys(ENV)


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
