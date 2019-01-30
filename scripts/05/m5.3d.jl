# # Linear regression

using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)

# Import the dataset.

# ### snippet 5.4

wd = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
df = convert(DataFrame, wd);

mean_ma = mean(df[:Marriage])
df[:Marriage_s] = convert(Vector{Float64},
  (df[:Marriage]) .- mean_ma)/std(df[:Marriage]);

mean_mam = mean(df[:MedianAgeMarriage])
df[:MedianAgeMarriage_s] = convert(Vector{Float64},
  (df[:MedianAgeMarriage]) .- mean_mam)/std(df[:MedianAgeMarriage]);

# Show the first six rows of the dataset.

first(df[[1, 7, 14,15]], 6)

# Model ``y ∼ Xβ + ϵ``, where ``ϵ ∼ N(0, σ²)`` IID. Student prior on σ

struct m_5_3{TY <: AbstractVector, TX <: AbstractMatrix}
    "Observations."
    y::TY
    "Covariates"
    X::TX
end

# Make the type callable with the parameters *as a single argument*.

function (problem::m_5_3)(θ)
    @unpack y, X, = problem   # extract the data
    @unpack β, σ = θ            # works on the named tuple too
    ll = 0.0
    ll += logpdf(Normal(10, 10), X[1]) # a = X[1]
    ll += logpdf(Normal(0, 1), X[2]) # b1 = X[2]
    ll += logpdf(Normal(0, 1), X[3]) # b1 = X[3]
    ll += logpdf(TDist(1.0), σ)
    ll += loglikelihood(Normal(0, σ), y .- X*β)
    ll
end

# Instantiate the model with data and inits.

N = size(df, 1)
X = hcat(ones(N), df[:Marriage_s], df[:MedianAgeMarriage_s]);
y = convert(Vector{Float64}, df[:Divorce])
p = m_5_3(y, X);
p((β = [1.0, 2.0, 3.0], σ = 1.0))

# Write a function to return properly dimensioned transformation.

problem_transformation(p::m_5_3) =
    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);

# Tune and sample.

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

# cmdstan result

cmdstan_result = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
          Mean        SD       Naive SE       MCSE      ESS
    a  9.69137275 0.21507432 0.0034006235 0.0038501180 1000
   bA -1.12184710 0.29039965 0.0045916216 0.0053055477 1000
   bM -0.12106472 0.28705400 0.0045387223 0.0051444688 1000
sigma  1.52326545 0.16272599 0.0025729239 0.0034436330 1000

Quantiles:
         2.5%       25.0%      50.0%      75.0%       97.5%   
    a  9.2694878  9.5497650  9.6906850  9.83227750 10.11643500
   bA -1.6852295 -1.3167700 -1.1254650 -0.92889225 -0.53389157
   bM -0.6889247 -0.3151695 -0.1231065  0.07218513  0.45527243
sigma  1.2421182  1.4125950  1.5107700  1.61579000  1.89891925
";

# Extract the parameter posterior means: `[β, σ]`,

[posterior_β, posterior_σ]

# end of m4.5d.jl