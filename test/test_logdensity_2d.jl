using LogDensityProblems, Test, Distributions, TransformVariables
import LogDensityProblems: capabilities, dimension, logdensity
using LogDensityProblems: logdensity_and_gradient, LogDensityOrder

import ForwardDiff, Flux, Zygote, ReverseDiff, TransformVariables, Random
using Parameters: @unpack

using Plots
pyplot()

Random.seed!(1)

####
#### transformed Bayesian problem
####

ProjDir = @__DIR__
cd(ProjDir)

# ### snippet 9.3

# Construct the logdensity problem

struct clip_9_3_model{TY <: AbstractVector, TX <: AbstractVector}
    "Observations."
    y::TY
    "Covariate"
    x::TX
end

# Make the type callable with the parameters *as a single argument*.

function (problem:: clip_9_3_model)(θ)
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

Random.seed!(1234591)

N = 100
x = rand(Normal(0, 1), N)
y = rand(Normal(0, 1), N)

p = clip_9_3_model(y, x)
θ = (muy = 0.0, mux=0.0)
p(θ)

# Write a function to return properly dimensioned transformation.

t = as((muy = asℝ, mux = asℝ))
t1 = as((muy = asℝ₊, mux = asℝ₊))

problem_transformation(p::clip_9_3_model) = t

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);

@testset "transformed Bayesian problem 2D" begin

    for _ in 1:100
        x = random_arg(t)
        θ, lj = transform_and_logjac(t, x)
        px = logdensity(P, x)
        px2, ∇px = logdensity_and_gradient(∇P, x)
        @test px == px2
    end

end

generate_n_samples_2(p, ∇P)