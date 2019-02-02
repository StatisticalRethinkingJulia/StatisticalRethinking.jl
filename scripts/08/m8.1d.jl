# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

# ### snippet 5.1

d = CSV.read(rel_path("..", "data", "rugged.csv"), delim=';');
df = convert(DataFrame, d);

dcc = filter(row -> !(ismissing(row[:rgdppc_2000])), df)
dcc[:log_gdp] = log.(dcc[:rgdppc_2000])
dcc[:cont_africa] = Array{Float64}(convert(Array{Int}, dcc[:cont_africa]))

# First 5 rows with data

first(dcc[[:rugged, :cont_africa, :log_gdp]], 5)

struct m_8_1_model{TY <: AbstractVector, TX <: AbstractMatrix}
    "Observations."
    y::TY
    "Covariates"
    X::TX
end

# Make the type callable with the parameters *as a single argument*.

function (problem::m_8_1_model)(θ)
    @unpack y, X, = problem   # extract the data
    @unpack β, σ = θ            # works on the named tuple too
    ll = 0.0
    ll += logpdf(Normal(0, 100), X[1]) # a = X[1]
    ll += logpdf(Normal(0, 10), X[2]) # bR = X[2]
    ll += logpdf(Normal(0, 10), X[3]) # bA = X[3]
    ll += logpdf(Normal(0, 10), X[4]) # bAR = X[4]
    ll += logpdf(TDist(1.0), σ)
    ll += loglikelihood(Normal(0, σ), y .- X*β)
    ll
end

# Instantiate the model with data and inits.

N = size(dcc, 1)
X = hcat(ones(N), dcc[:rugged], dcc[:cont_africa], dcc[:rugged].*dcc[:cont_africa]);
y = convert(Vector{Float64}, dcc[:log_gdp])
p = m_8_1_model(y, X);
p((β = [1.0, 2.0, 1.0, 2.0], σ = 1.0))

# Write a function to return properly dimensioned transformation.

problem_transformation(p::m_8_1_model) =
    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = LogDensityRejectErrors(ADgradient(:ForwardDiff, P));

# Tune and sample.

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

# We use the transformation to obtain the posterior from the chain.

posterior = TransformVariables.transform.(Ref(problem_transformation(p)), get_position.(chain));
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

# Result rethinking

rethinking = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.22 0.14  9.00  9.46   282    1
bR    -0.21 0.08 -0.33 -0.08   275    1
bA    -1.94 0.24 -2.33 -1.59   268    1
bAR    0.40 0.14  0.18  0.62   271    1
sigma  0.96 0.05  0.87  1.04   339    1
"

# Summary

[posterior_β, posterior_σ]

# End of `08/m8.1s.jl`
