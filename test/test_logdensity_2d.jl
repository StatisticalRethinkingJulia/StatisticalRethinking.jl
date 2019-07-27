using LogDensityProblems, Test, Distributions, TransformVariables
using LogDensityProblems: Value, ValueGradient, ValueGradientBuffer

import ForwardDiff, Flux, ReverseDiff, Zygote
using Parameters: @unpack
using TransformVariables
import Random

####
#### test setup and utilities
####

Random.seed!(1)

"""
    a ≅ b

Compare fields and types (strictly), for unit testing. For less strict comparison, use `≈`.
"""
≅(::Any, ::Any) = false
≅(a::Value{T}, b::Value{T}) where {T} = a.value == b.value
≅(a::ValueGradient{T,V}, b::ValueGradient{T,V}) where {T,V} =
    a.value == b.value && (a.value == -Inf || a.gradient == b.gradient)

_wide_tol(a, b) = max(√eps(a.value), √eps(b.value))

function Base.isapprox(a::Value, b::Value; atol = _wide_tol(a, b), rtol = atol)
    isapprox(a.value, b.value; atol = atol, rtol = rtol)
end

function Base.isapprox(a::ValueGradient, b::ValueGradient; atol = _wide_tol(a, b), rtol = atol)
    isapprox(a.value, b.value; atol = atol, rtol = rtol) &&
        (a.value == -Inf || isapprox(a.gradient, b.gradient; atol = √eps(), rtol = atol))
end

struct TestLogDensity{F}
    ℓ::F
end
d = MvNormal([1.0, 1.0])
TransformVariables.dimension(::TestLogDensity) = length(d)
test_logdensity(x) = sum(logpdf(d, x))
test_gradient(x) = gradlogpdf(d, x)
TestLogDensity() = TestLogDensity(test_logdensity)
LogDensityProblems.logdensity(::Type{Real}, ℓ::TestLogDensity, x) = ℓ.ℓ(x)

useZygote = false

@testset "AD via ForwardDiff/Zygote" begin
    ℓ = TestLogDensity(test_logdensity)
    if useZygote
      ∇ℓ = ADgradient(:Zygote, ℓ)
      @test repr(∇ℓ) == ("Zygote AD wrapper for " * repr(ℓ))
    else
      ∇ℓ = ADgradient(:ForwardDiff, ℓ)
    end
    @test dimension(∇ℓ) == length(d)
    buffer = randn(length(d))
    vb = ValueGradientBuffer(buffer)
    for _ in 1:100
        x = randn(length(d))
        @test logdensity(Real, ∇ℓ, x) ≈ test_logdensity1(x)
        @test logdensity(Value, ∇ℓ, x) ≅ Value(test_logdensity1(x))
        vg = ValueGradient(test_logdensity1(x), test_gradient(x))
        @test logdensity(ValueGradient, ∇ℓ, x) ≅ vg
        @test logdensity(vb, ∇ℓ, x) ≅ vg
    end
end

