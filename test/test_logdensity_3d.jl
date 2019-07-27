using LogDensityProblems, Test, Distributions, TransformVariables
using LogDensityProblems: Value, ValueGradient, ValueGradientBuffer

import ForwardDiff, Flux, ReverseDiff
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
TransformVariables.dimension(::TestLogDensity) = 3
test_logdensity1(x) = -2*abs2(x[1]) - 3*abs2(x[2]) - 5*abs2(x[3])
test_logdensity(x) = any(x .< 0) ? -Inf : test_logdensity1(x)
test_gradient(x) = x .* [-4, -6, -10]
TestLogDensity() = TestLogDensity(test_logdensity) # default: -Inf for negative input
LogDensityProblems.logdensity(::Type{Real}, ℓ::TestLogDensity, x) = ℓ.ℓ(x)

if VERSION ≥ v"1.1.0"
    # cf https://github.com/FluxML/Zygote.jl/issues/104
    import Zygote

    @testset "AD via Zygote" begin
        # cf https://github.com/FluxML/Zygote.jl/issues/271
        ℓ = TestLogDensity(test_logdensity1)
        ∇ℓ = ADgradient(:Zygote, ℓ)
        @test repr(∇ℓ) == ("Zygote AD wrapper for " * repr(ℓ))
        @test dimension(∇ℓ) == 3
        buffer = randn(3)
        vb = ValueGradientBuffer(buffer)
        for _ in 1:100
            x = randn(3)
            @test logdensity(Real, ∇ℓ, x) ≈ test_logdensity1(x)
            @test logdensity(Value, ∇ℓ, x) ≅ Value(test_logdensity1(x))
            vg = ValueGradient(test_logdensity1(x), test_gradient(x))
            @test logdensity(ValueGradient, ∇ℓ, x) ≅ vg
            # NOTE don't test buffer ≡, as that is not implemented for Zygote
            @test logdensity(vb, ∇ℓ, x) ≅ vg
        end
    end
end

