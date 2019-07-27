using LogDensityProblems, Test, Distributions, TransformVariables
using LogDensityProblems: Value, ValueGradient, ValueGradientBuffer

import ForwardDiff, Flux, ReverseDiff, Zygote
using Parameters: @unpack
using TransformVariables
import Random

#Random.seed!(1)

struct clip_9_3d3_model{TY <: AbstractVector, TX <: AbstractVector, TZ <: Real}
    "Observations"
    y::TY
    "Covariate"
    x::TX
    "Mean muy"
    a::TZ
    "Std muy"
    b::TZ
    "Mean mux"
    k::TZ
    "Std mux"
    d::TZ
end

# Make the type callable with the parameters *as a single argument*.

function (problem:: clip_9_3d3_model)(θ)
    @unpack y, x, a, b, k, d = problem    # extract the data
    @unpack muy, mux = θ     # works on the named tuple too
    ll = 0.0
    ll += loglikelihood(Normal(mux, 1), x)
    ll += loglikelihood(Normal(muy, 1), y)
    ll += logpdf(Normal(a, b), mux) 
    ll += logpdf(Normal(k, d), muy)
    ll
end

# Instantiate the model with data and inits.

Random.seed!(1)

N = 10
a, b, k, d = (2.0, 4.0, 5.0, 8.0)
y = rand(Normal(a, b), N)
x = rand(Normal(k, d), N)
 
p = clip_9_3d3_model(y, x, a, b, k, d)
mu = [-0.3, 0.2]
θ = (muy = mu[1], mux=mu[2])
p(θ)

function value_and_gradient(problem::clip_9_3d3_model, θ::NamedTuple)
  @unpack y, x, a, b, k, d = problem
  @unpack muy, mux = θ
  g1 = sum(y .- muy) + (a - muy)/b^2
  g2 = sum(x .- mux) + (k - mux)/d^2
  (problem(θ), [-g1, -g2])
end

problem_transformation(p::clip_9_3d3_model) =
    as((muy = asℝ, mux = asℝ))

# Wrap the problem with a transformation, then use Zygote for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P)
∇P1 = ADgradient(:Flux, P)
∇P2 = ADgradient(:Zygote, P)

function value_and_gradient(model, grad, q::AbstractArray)
  val = logdensity(ValueGradient, grad, q).value
  grad = -logdensity(ValueGradient, grad, q).gradient
  (val, grad)
end

@testset "AD via ForwardDiff" begin
  for _ in 1:1000
    @test value_and_gradient(p, ∇P, mu)[1] ≈ value_and_gradient(p, θ)[1] atol=0.2
    @test value_and_gradient(p, ∇P, mu)[2][1] ≈ value_and_gradient(p, θ)[2][1] atol=0.2
    @test value_and_gradient(p, ∇P, mu)[2][2] ≈ value_and_gradient(p, θ)[2][2] atol=0.2
  end
end

@testset "AD via Flux" begin
  for _ in 1:1000
    @test value_and_gradient(p, ∇P1, mu)[1] ≈ value_and_gradient(p, θ)[1] atol=0.2
    @test value_and_gradient(p, ∇P1, mu)[2][1] ≈ value_and_gradient(p, θ)[2][1] atol=0.2
    @test value_and_gradient(p, ∇P1, mu)[2][2] ≈ value_and_gradient(p, θ)[2][2] atol=0.2
  end
end

@testset "AD via Zygote" begin
  for _ in 1:1
    @test value_and_gradient(p, ∇P2, mu)[1] ≈ value_and_gradient(p, θ)[1] atol=0.2
    @test value_and_gradient(p, ∇P2, mu)[2][1] ≈ value_and_gradient(p, θ)[2][1] atol=0.2
    @test value_and_gradient(p, ∇P2, mu)[2][2] ≈ value_and_gradient(p, θ)[2][2] atol=0.2
  end
end
