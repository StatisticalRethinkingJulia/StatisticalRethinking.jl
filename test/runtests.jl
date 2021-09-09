using StanSample, NamedTupleTools
using StatisticalRethinking
using Test


tests = ["srtools", "link"]
stan_tests = ["wd-loo-compare", "wd-loo-compare2"]

stan_exists()::Bool = "CMDSTAN_HOME" in keys(ENV)


@testset "StatisticalRethinking.jl" begin
    for t ∈ tests
        @testset "$t" begin
            include("test_$t.jl")
        end
    end
end

if stan_exists()
    @testset "StanTests" begin
        for t ∈ stan_tests
            @testset "$t" begin
                include("test_$t.jl")
            end
        end
    end
end
