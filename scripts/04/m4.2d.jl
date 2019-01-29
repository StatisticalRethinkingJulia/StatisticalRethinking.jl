# # Heights problem with restricted prior on mu.

# Result is not conform cmdstan result

using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# Import the dataset.

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults and standardize

df2 = filter(row -> row[:age] >= 18, df);

# Show the first six rows of the dataset.

first(df2, 6)

# No covariates, just height observations.

struct ConstraintHeightsProblem{TY <: AbstractVector}
    "Observations."
    y::TY
end;

# Very constraint prior on μ. Flat σ.

function (problem::ConstraintHeightsProblem)(θ)
    @unpack y = problem   # extract the data
    @unpack μ, σ = θ
    loglikelihood(Normal(μ, σ), y) + logpdf(Normal(178, 0.1), μ) + 
    logpdf(Uniform(0, 50), σ)
end;

# Define problem with data and inits.

obs = convert(Vector{Float64}, df2[:height])
p = ConstraintHeightsProblem(obs);
p((μ = 178, σ = 5.0))

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(as((μ  = as(Real, 100, 250), σ = asℝ₊)), p)
∇P = ADgradient(:ForwardDiff, P);

# FSample from the posterior.

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

# Undo the transformation to obtain the posterior from the chain.

posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));

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