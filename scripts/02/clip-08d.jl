# # Estimate Bernoulli draws probabilility

using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

# Then define a structure to hold the data.
# For this model, the number of draws equal to `1` is a sufficient statistic.

"""
`n` independent draws from a ``Bernoulli(α)`` distribution.
"""
struct BernoulliProblem
    "Total number of draws in the data."
    n::Int
    "Number of draws `==1` in the data"
    s::Vector{Int}
end

# Then make the type callable with the parameters *as a single argument*.  We
# use decomposition in the arguments, but it could be done inside the function,
# too.

function (problem::BernoulliProblem)((α, )::NamedTuple{(:α, )})
    @unpack n, s = problem        # extract the data
    # log likelihood: the constant log(combinations(n, s)) term
    # has been dropped since it is irrelevant to sampling.
    #sum([s1 * log(α) + (n-s1) * log(1-α) for s1 in s])
    loglikelihood(Binomial(n, α), s)
end

# We should test this, also, this would be a good place to benchmark and
# optimize more complicated problems.

obs = rand(Binomial(9, 2/3), 1)
p = BernoulliProblem(9, obs)
p((α = 0.5, ))

# Recall that we need to
#
# 1. transform from ``ℝ`` to the valid parameter domain `(0,1)` for more efficient sampling, and
#
# 2. calculate the derivatives for this transformed mapping.
#
# The helper packages `TransformVariables` and `LogDensityProblems` take care of
# this. We use a flat prior (the default, omitted)

P = TransformedLogDensity(as((α = as𝕀,)), p)
∇P = ADgradient(:ForwardDiff, P);

# Finally, we sample from the posterior. `chain` holds the chain (positions and
# diagnostic information), while the second returned value is the tuned sampler
# which would allow continuation of sampling.

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000)

# To get the posterior for ``α``, we need to use `get_position` and
# then transform

posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));

# Extract the parameter.

posterior_α = first.(posterior);

# check the effective sample size

ess_α = effective_sample_size(posterior_α)

# NUTS-specific statistics

NUTS_statistics(chain)
# check the mean

mean(posterior_α)

