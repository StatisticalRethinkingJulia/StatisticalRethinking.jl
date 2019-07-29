using LogDensityProblems, Test, Distributions, TransformVariables
import LogDensityProblems: capabilities, dimension, logdensity
using LogDensityProblems: logdensity_and_gradient, LogDensityOrder

import ForwardDiff, Flux, Zygote, TransformVariables, Random
using Parameters: @unpack

using Plots
gr()

Random.seed!(3)

####
#### transformed Bayesian problem
####

ProjDir = @__DIR__
cd(ProjDir)
include("../src/HMC.jl")
include("../src/generate_n_samples.jl")

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

Random.seed!(3)

N = 100
x = rand(Normal(0, 1), N)
#=
x = [0.83975036,  0.70534183,  1.30596472, -1.38799622,  1.27291686,  0.18419277,
  0.75227990,  0.59174505, -0.98305260, -0.27606396, -0.87085102,  0.71871055,
  0.11065288, -0.07846677, -0.42049046, -0.56212588,  0.99751344, -1.10513006,
  -0.14228783,  0.31499490]
=#
y = rand(Normal(0, 1), N)
#=
y = [2.287247161, -1.196771682, -0.694292510, -0.412292951, -0.970673341, -0.947279945,
  0.748139340, -0.116955226,  0.152657626,  2.189978107,  0.356986230,  2.716751783,
  2.281451926,  0.324020540,  1.896067067,  0.467680511, -0.893800723, -0.307328300,
  -0.004822422,  0.988164149]
=#

p = clip_9_3_model(y, x)
θ = (muy = 0.0, mux=0.0)

# Write a function to return properly dimensioned transformation.

t = as((muy = asℝ, mux = asℝ))
#t1 = as((muy = asℝ₊, mux = asℝ₊))

problem_transformation(p::clip_9_3_model) = t

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);

println()
p(θ) |> display
v, g = logdensity_and_gradient(∇P, [0.0, 0.0])
println()
v  |> display
g  |> display
value_U = -v
grad_U = -g
v, g = logdensity_and_gradient(∇P, [-0.1, 0.2])
println()
v  |> display
g  |> display
value_U = -v
grad_U = -g

@testset "transformed Bayesian problem 2D" begin

    for _ in 1:100
        x = random_arg(t)
        θ, lj = transform_and_logjac(t, x)
        px = logdensity(P, x)
        px2, ∇px = logdensity_and_gradient(∇P, x)
        @test px == px2
    end

end

println()
new_q, ptraj, qtraj, accept, dH = HMC(p, ∇P, 0.03, 11, [-0.1, 0.2])

new_q |> display
println()
ptraj |> display
println()
qtraj |> display
println()
dH |> display
println()

fig = generate_n_samples(p, ∇P, q =  [-0.1, 0.2]);
savefig(fig, "fig-9-3.pdf")