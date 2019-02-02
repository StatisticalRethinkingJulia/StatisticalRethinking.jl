using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff, LinearAlgebra

ProjDir = rel_path("..", "scripts", "12")

df = CSV.read(rel_path( "..", "data",  "Kline.csv"), delim=';');
size(df) # Should be 10x5

# New col logpop, set log() for population data
df[:logpop] = map((x) -> log(x), df[:population]);
df[:society] = 1:10;

first(df[[:total_tools, :logpop, :society]], 5)

struct m_10_04d_model{TY <: AbstractVector, TX <: AbstractMatrix,
  TA <: AbstractVector}
    "Observations."
    y::TY
    "Covariates"
    X::TX
    "Actors"
    A::TA
    "Number of observations"
    N::Int
    "Number of unique actors"
    N_actors::Int
end

# Make the type callable with the parameters *as a single argument*.

function (problem::m_10_04d_model)(θ)
    @unpack y, X, A, N, N_actors = problem   # extract the data
    @unpack β, α = θ  # works on the named tuple too
    ll = 0.0
    ll += sum(logpdf.(Normal(0, 10), β)) # bp & bpC
    ll += sum(logpdf.(Normal(0, 10), α)) # alpha[1:7]
    ll += sum(
      [loglikelihood(Binomial(1, logistic(α[A[i]] + dot(X[i, :], β))), [y[i]]) for i in 1:N]
    )
    ll
end

# Instantiate the model with data and inits.

# Input data for cmdstan

#m12_6_1_data = Dict("total_tools" => d[:total_tools], "logpop" => #d[:logpop], "society" => d[:society]);

N = size(df, 1)
N_actors = length(unique(df[:actor]))
X = hcat(ones(Int64, N), df[:prosoc_left] .* df[:condition]);
A = df[:actor]
y = df[:pulled_left]
p = m_10_04d_model(y, X, A, N, N_actors);
θ = (β = [1.0, 0.0], α = [-1.0, 10.0, -1.0, -1.0, -1.0, 0.0, 2.0])
p(θ)

# Write a function to return properly dimensioned transformation.

problem_transformation(p::m_10_04d_model) =
    as( (β = as(Array, size(p.X, 2)), α = as(Array, p.N_actors), ) )

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

# Effective sample sizes (of untransformed draws)

ess = mapslices(effective_sample_size, get_position_matrix(chain); dims = 1)
ess

# NUTS-specific statistics

NUTS_statistics(chain)

        
# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m12_6_1_data, ProjDir, diagnostics=false, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

