# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff, LinearAlgebra

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

# ### snippet 5.1

d = CSV.read(rel_path("..", "data", "chimpanzees.csv"), delim=';');
df = convert(DataFrame, d);
df[:pulled_left] = convert(Array{Int64}, df[:pulled_left])
df[:prosoc_left] = convert(Array{Int64}, df[:prosoc_left])
first(df, 5)

struct m_10_02d_model{TY <: AbstractVector, TX <: AbstractMatrix}
    "Observations."
    y::TY
    "Covariates"
    X::TX
end

# Make the type callable with the parameters *as a single argument*.

function (problem::m_10_02d_model)(θ)
    @unpack y, X, = problem   # extract the data
    @unpack pr, β = θ            # works on the named tuple too
    ll = 0.0
    ll += logpdf(Normal(0, 10), β[1]) # a = X[1]
    ll += logpdf(Normal(0, 10), β[2]) # bp = X[2]
    ll += sum([loglikelihood(Binomial(1, logistic(dot(X[i, :], β))), [y[i]]) for i in 1:N])
    ll
end

# Instantiate the model with data and inits.

N = size(df, 1)
X = hcat(ones(Int64, N), df[:prosoc_left]);
y = df[:pulled_left]
p = m_10_02d_model(y, X);
θ = (β = [1.0, 2.0], pr = ones(N),)
p(θ)

# Write a function to return properly dimensioned transformation.

problem_transformation(p::m_10_02d_model) =
    as((β = as(Array, size(p.X, 2)), pr = as(Array, size(p.X, 2))))

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

# Effective sample sizes (of untransformed draws)

ess = mapslices(effective_sample_size,
                get_position_matrix(chain); dims = 1)

# NUTS-specific statistics

NUTS_statistics(chain)

# Result rethinking

rethinking = "
   mean   sd  5.5% 94.5% n_eff Rhat
a  0.04 0.12 -0.16  0.21   180 1.00
bp 0.57 0.19  0.30  0.87   183 1.01
";

# Extract the parameter posterior means: `β`,

posterior_β = mean(first, posterior)

# End of `08/m8.1s.jl`
