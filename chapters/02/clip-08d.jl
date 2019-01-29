using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

struct BernoulliProblem
    "Total number of draws in the data."
    n::Int
    "Number of draws `==1` in the data"
    s::Vector{Int}
end;

function (problem::BernoulliProblem)((α, )::NamedTuple{(:α, )})
    @unpack n, s = problem        # extract the data
    loglikelihood(Binomial(n, α), s)
end

obs = rand(Binomial(9, 2/3), 1)
p = BernoulliProblem(9, obs)
p((α = 0.5, ))

P = TransformedLogDensity(as((α = as𝕀,)), p)
∇P = ADgradient(:ForwardDiff, P);

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000)

posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));

posterior_α = first.(posterior);

ess_α = effective_sample_size(posterior_α)

NUTS_statistics(chain)

mean(posterior_α)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

