using LogDensityProblems, Test, Distributions, TransformVariables
import LogDensityProblems: capabilities, dimension, logdensity
using LogDensityProblems: logdensity_and_gradient, LogDensityOrder

import ForwardDiff, Flux, Zygote, TransformVariables, Random
using Parameters: @unpack

Random.seed!(1)

####
#### transformed Bayesian problem
####

@testset "transformed Bayesian problem" begin
    t = as((y = asℝ₊, ))
    #d = LogNormal(1.0, 2.0)
    d = Normal(1.0, 2.0)
    logposterior = ((x, ), ) -> logpdf(d, x)

    # a Bayesian problem
    p = TransformedLogDensity(t, logposterior)
    @test repr(p) == "TransformedLogDensity of dimension 1"
    @test dimension(p) == 1
    @test p.transformation ≡ t
    @test capabilities(p) == LogDensityOrder(0)

    # gradient of a problem
    ∇p = ADgradient(:ForwardDiff, p)
    @test dimension(∇p) == 1
    @test parent(∇p).transformation ≡ t

    for _ in 1:100
        x = random_arg(t)
        θ, lj = transform_and_logjac(t, x)
        px = logdensity(p, x)
        @test logpdf(d, θ.y) + lj ≈ (px::Real)
        px2, ∇px = logdensity_and_gradient(∇p, x)
        @test px2 == px
        @test ∇px ≈ [ForwardDiff.derivative(x -> logpdf(d, exp(x)) + x, x[1])]
    end
end

