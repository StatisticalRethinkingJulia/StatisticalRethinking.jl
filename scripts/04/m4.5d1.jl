# # Linear regression

# We estimate simple linear regression model with a half-T prior.
# First, we load the packages we use.

using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# Import the dataset.

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
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
posterior[1:5]

# Extract the parameter posterior means: `β`,

posterior_β = mean(first, posterior)

# then `σ`:

posterior_σ = mean(last, posterior)

# Effective sample sizes (of untransformed draws)

ess = mapslices(effective_sample_size,
                get_position_matrix(chain); dims = 1)

# NUTS-specific statistics

NUTS_statistics(chain)

cmdstan_result = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
           Mean         SD       Naive SE       MCSE      ESS
    a 154.609019750 0.36158389 0.0057171433 0.0071845548 1000
   b1   5.838431778 0.27920926 0.0044146860 0.0048693502 1000
   b2  -0.009985954 0.22897191 0.0036203637 0.0047224478 1000
sigma   5.110136300 0.19096315 0.0030193925 0.0030728192 1000

Quantiles:
          2.5%        25.0%        50.0%       75.0%        97.5%   
    a 153.92392500 154.3567500 154.60700000 154.8502500 155.32100000
   b1   5.27846200   5.6493250   5.83991000   6.0276275   6.39728200
   b2  -0.45954687  -0.1668285  -0.01382935   0.1423620   0.43600905
sigma   4.76114350   4.9816850   5.10326000   5.2300450   5.51500975
";

# Extract the parameter posterior means: `β`,

[posterior_β, posterior_σ]

# end of m4.5d.jl