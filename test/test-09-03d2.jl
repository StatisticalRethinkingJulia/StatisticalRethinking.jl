using LogDensityProblems, TransformVariables
using Distributions, Parameters, Random, ForwardDiff, Flux, Zygote
import LogDensityProblems: ValueGradient

# Construct the logdensity problem

struct clip_9_3d2_model{TY <: AbstractVector, TX <: AbstractVector}
    "Observations."
    y::TY
    "Covariate"
    x::TX
end

# Make the type callable with the parameters *as a single argument*.

function (problem:: clip_9_3d2_model)(θ)
    @unpack y, x, = problem    # extract the data
    @unpack muy, mux = θ     # works on the named tuple too
    ll = 0.0
    ll += loglikelihood(Normal(mux, 1), x)
    ll += loglikelihood(Normal(muy, 1), y)
    ll += logpdf(Normal(0, 1), mux) 
    ll += logpdf(Normal(0, 1), muy)
    ll
end

# Instantiate the model with data and inits.

Random.seed!(1)

N = 10
x = rand(Normal(0, 1), N)
y = rand(Normal(0, 1), N)
 
p = clip_9_3d2_model(y, x)
mu = [-0.3, 0.2]
θ = (muy = mu[1], mux=mu[2])
p(θ)

# Hand=computed derivative/gradient
function value_and_gradient(problem::clip_9_3d2_model, θ::NamedTuple)
  @unpack y, x = problem
  @unpack muy, mux = θ
  g1 = sum(y .- muy) + (0 - muy)/1^2
  g2 = sum(x .- mux) + (0 - mux)/1^2
  (problem(θ), [-g1, -g2])
end

val, grad = value_and_gradient(p, θ)
println("Hand computed derivative:\nValue: $(val), Gradient: $(grad)")

# Write a function to return properly dimensioned transformation.

problem_transformation(p::clip_9_3d2_model) =
    as((muy = asℝ, mux = asℝ))

# Wrap the problem with a transformation

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);
∇P1 = ADgradient(:Flux, P)
∇P2 = ADgradient(:Zygote, P)

function value_and_gradient(model, grad, q::AbstractArray)
  val = logdensity(ValueGradient, grad, q).value
  grad = -logdensity(ValueGradient, grad, q).gradient
  (val, grad)
end

val, grad = value_and_gradient(p, ∇P, mu)
println("ForwardDiff:\nValue: $(val), Gradient: $(grad)")
val, grad = value_and_gradient(p, ∇P1, mu)
println("Flux:\nValue: $(val), Gradient: $(grad)")
val, grad = value_and_gradient(p, ∇P2, mu)
println("Zygote:\nValue: $(val), Gradient: $(grad)")
