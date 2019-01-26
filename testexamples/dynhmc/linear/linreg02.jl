# # Linear regression

# We estimate simple linear regression model with a half-T prior.
# First, we load the packages we use.

using TransformVariables, LogDensityProblems, DynamicHMC, MCMCDiagnostics,
    Parameters, Statistics, Distributions, ForwardDiff

# Then define a structure to hold the data: observables, covariates, and the degrees of freedom for the prior.

"""
Linear regression model ``y ∼ Xβ + ϵ``, where ``ϵ ∼ N(0, σ²)`` IID.
Flat prior for `β`, half-T for `σ`.
"""
struct LinearRegressionProblem{TY <: AbstractVector, TX <: AbstractMatrix,
                               Tν <: Real}
    "Observations."
    y::TY
    "Covariates"
    X::TX
    "Degrees of freedom for prior."
    ν::Tν
end

# Then make the type callable with the parameters *as a single argument*.

function (problem::LinearRegressionProblem)(θ)
    @unpack y, X, ν = problem   # extract the data
    @unpack β, σ = θ            # works on the named tuple too
    loglikelihood(Normal(0, σ), y .- X*β) + logpdf(TDist(ν), σ)
end

# We should test this, also, this would be a good place to benchmark and
# optimize more complicated problems.

N = 1000
X = hcat(ones(N), randn(N, 4));
β = [1.0, 2.0, -3.0, 4.0, -1.0]
σ = 0.5
y = X*β .+ randn(N) .* σ;
p = LinearRegressionProblem(y, X, 1.0);
p((β = β, σ = σ))

# For this problem, we write a function to return the transformation (as it varies with the number of covariates).

problem_transformation(p::LinearRegressionProblem) =
    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);

# Finally, we sample from the posterior. `chain` holds the chain (positions and
# diagnostic information), while the second returned value is the tuned sampler
# which would allow continuation of sampling.

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

# We use the transformation to obtain the posterior from the chain.

posterior = transform.(Ref(∇P.transformation), get_position.(chain));

# Extract the parameter posterior means: `β`,

posterior_β = mean(first, posterior)

# then `σ`:

posterior_σ = mean(last, posterior)

# Effective sample sizes (of untransformed draws)

ess = mapslices(effective_sample_size,
                get_position_matrix(chain); dims = 1)

# NUTS-specific statistics

NUTS_statistics(chain)