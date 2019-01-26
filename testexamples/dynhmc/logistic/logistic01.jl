# # Logistic regression

using TransformVariables, LogDensityProblems, DynamicHMC, MCMCDiagnostics, Parameters,
    Distributions, Statistics, StatsFuns, ForwardDiff

"""
Logistic regression.
For each draw, ``logit(Pr(yᵢ == 1)) ∼ Xᵢ β``. Uses a `β ∼ Normal(0, σ)` prior.
`X` is supposed to include the `1`s for the intercept.
"""
struct LogisticRegression{Ty, TX, Tσ}
    y::Ty
    X::TX
    σ::Tσ
end

function (problem::LogisticRegression)(θ)
    @unpack y, X, σ = problem
    @unpack β = θ
    loglik = sum(logpdf.(Bernoulli.(logistic.(X*β)), y))
    logpri = sum(logpdf.(Ref(Normal(0, σ)), β))
    #logpri = sum(logpdf.(Normal(0, σ), β))
    loglik + logpri
end

# Make up parameters, generate data using random draws.

N = 1000
β = [1.0, 2.0]
X = hcat(ones(N), randn(N))
y = rand.(Bernoulli.(logistic.(X*β)));

# Create a problem, apply a transformation, then use automatic differentiation.

p = LogisticRegression(y, X, 10.0)   # data and (vague) priors
t = as((β = as(Array, length(β)), )) # identity transformation, just to get the dimension
P = TransformedLogDensity(t, p)      # transformed
∇P = ADgradient(:ForwardDiff, P)

# Sample using NUTS, random starting point.

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

# Extract the posterior. Here the transformation was not really necessary.

β_posterior = first.(TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain)));

# Check that we recover the parameters.

mean(β_posterior) |> display

# Quantiles

qs = [0.05, 0.25, 0.5, 0.75, 0.95]
quantile(first.(β_posterior), qs)

quantile(last.(β_posterior), qs)

# Check that mixing is good.

ess = vec(mapslices(effective_sample_size, reduce(hcat, β_posterior); dims = 2))