# # Linear regression

# We estimate simple linear regression model with a half-T prior.
# First, we load the packages we use.

using TransformVariables, LogDensityProblems, DynamicHMC, MCMCDiagnostics,
    Parameters, Statistics, Distributions, ForwardDiff, CSV, DataFrames

ProjDir = @__DIR__
cd(ProjDir)

# Import the dataset.

howell1 = CSV.read(joinpath("..", "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults and standardize

df2 = filter(row -> row[:age] >= 18, df)
df2[:weight] = convert(Vector{Float64}, df2[:weight]);
df2[:weight_s] = (df2[:weight] .- mean(df2[:weight])) / std(df2[:weight]);
df2[:weight_s2] = df2[:weight_s] .^ 2;

# Show the first six rows of the dataset.

first(df2, 6)

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

N = size(df2, 1)
X = hcat(ones(N), hcat(df2[:weight_s], df2[:weight_s2]));
y = convert(Vector{Float64}, df2[:height])
p = LinearRegressionProblem(y, X, 1.0);
p((β = [1.0, 2.0, 3.0], σ = 1.0))

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

posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));

# Extract the parameter posterior means: `β`,

posterior_β = mean(first, posterior)
display(posterior_β)
println()

# then `σ`:

posterior_σ = mean(last, posterior)
display(posterior_σ)
println()

# Effective sample sizes (of untransformed draws)

ess = mapslices(effective_sample_size,
                get_position_matrix(chain); dims = 1)
display(ess)
println()

# NUTS-specific statistics

NUTS_statistics(chain)