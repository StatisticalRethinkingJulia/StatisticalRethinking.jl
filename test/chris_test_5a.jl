# # Heights problem with restricted prior on mu.

# Result is not conform cmdstan result

using DynamicHMCModels

ProjDir = @__DIR__
cd(ProjDir)

# Define user likelihood distribution

import Distributions: logpdf, pdf
mutable struct mydist{T1,T2} <: ContinuousUnivariateDistribution
    μ::T1
    σ::T2
end

function pdf(dist::mydist, x::Float64)
  @unpack μ,σ=dist
  pdf(Normal(μ,σ), x)
end

function logpdf(dist::mydist,data::Array{Float64,1})
    @unpack μ,σ=dist
    LL = 0.0
    for d in data
        LL += logpdf(Normal(μ,σ),d)
    end
    isnan(LL) ? (return Inf) : (return LL) #not as robust as I thought
end

#Function barrier in mydist
@model model(y) = begin
    μ ~ Normal(0,1)
    σ ~ Truncated(Cauchy(0,1),0,Inf)
    y ~ mydist(μ,σ)
end
# No covariates, just height observations.

struct ConstraintHeightsProblem{TY <: AbstractVector}
    "Observations."
    y::TY
end;

# Very constraint prior on μ. Flat σ.

function (problem::ConstraintHeightsProblem)(θ)
    @unpack y = problem   # extract the data
    @unpack μ, σ = θ
    loglikelihood(mydist(μ, σ), y) + logpdf(Normal(0.1), μ) + 
    logpdf(Truncated(Cauchy(0,1),0,Inf), σ)
end;

# Define problem with data and inits.

N = 30
obs = rand(Normal(0,1),N)
p = ConstraintHeightsProblem(obs);
p((μ = 0, σ = 5.0))

# Write a function to return properly dimensioned transformation.

problem_transformation(p::ConstraintHeightsProblem) =
    as((μ  = as(Real, 0, 250), σ = asℝ₊), )

# Use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = LogDensityRejectErrors(ADgradient(:ForwardDiff, P));

# FSample from the posterior.

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

# Undo the transformation to obtain the posterior from the chain.

posterior = TransformVariables.transform.(Ref(problem_transformation(p)), get_position.(chain));

# Extract the parameter posterior means: `μ`,

posterior_μ = mean(first, posterior)

# Extract the parameter posterior means: `μ`,

posterior_σ = mean(last, posterior)

# Effective sample sizes (of untransformed draws)

ess = mapslices(effective_sample_size,
                get_position_matrix(chain); dims = 1)

# NUTS-specific statistics

NUTS_statistics(chain)

# cmdstan result

cmdstan_result = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
         Mean         SD       Naive SE       MCSE      ESS
sigma  24.604616 0.946911707 0.0149719887 0.0162406632 1000
   mu 177.864069 0.102284043 0.0016172527 0.0013514459 1000

Quantiles:
         2.5%       25.0%     50.0%     75.0%     97.5%  
sigma  22.826377  23.942275  24.56935  25.2294  26.528368
   mu 177.665000 177.797000 177.86400 177.9310 178.066000
";

# Extract the parameter posterior means: `β`,

[posterior_μ, posterior_σ]

# end of m4.5d.jl