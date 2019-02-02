# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff, LinearAlgebra

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "10")
cd(ProjDir)

# ### snippet 10.4

d = CSV.read(rel_path("..", "data", "chimpanzees.csv"), delim=';');
df = convert(DataFrame, d);
df[:pulled_left] = convert(Array{Int64}, df[:pulled_left])
df[:prosoc_left] = convert(Array{Int64}, df[:prosoc_left])
df[:condition] = convert(Array{Int64}, df[:condition])
df[:actor] = convert(Array{Int64}, df[:actor])
first(df, 5)

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

#m_10_04_data = Dict("N" => size(df, 1), "actor" => df[:actor],
#"pulled_left" => df[:pulled_left], "prosoc_left" => df[:prosoc_left],
#"N_actors" => 7, "condition" => df[:condition]);

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

# Extract the parameter posterior means: `β`,

posterior_α = mean(last, posterior)

# Effective sample sizes (of untransformed draws)

ess = mapslices(effective_sample_size, get_position_matrix(chain); dims = 1)
ess

# NUTS-specific statistics

NUTS_statistics(chain)

# Result rethinking

rethinking = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
        Mean        SD       Naive SE       MCSE      ESS
a.1 -0.74503184 0.26613979 0.0042080396 0.0060183398 1000
a.2 10.77955494 5.32538998 0.0842018089 0.1269148045 1000
a.3 -1.04982353 0.28535997 0.0045119373 0.0049074219 1000
a.4 -1.04898135 0.28129307 0.0044476339 0.0056325117 1000
a.5 -0.74390933 0.26949936 0.0042611590 0.0052178124 1000
a.6  0.21599365 0.26307574 0.0041595927 0.0045153523 1000
a.7  1.81090866 0.39318577 0.0062168129 0.0071483527 1000
 bp  0.83979926 0.26284676 0.0041559722 0.0059795826 1000
bpC -0.12913322 0.29935741 0.0047332562 0.0049519863 1000
";

# Means of draws

[posterior_β, posterior_α]

# End of `10/m10.04d.jl`
