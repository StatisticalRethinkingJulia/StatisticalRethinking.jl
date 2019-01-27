using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df)

first(df2, 6)

"""
Half-T for `σ`.
"""
struct ConstraintHeightsProblem{TY <: AbstractVector}
    "Observations."
    y::TY
end

function (problem::ConstraintHeightsProblem)(θ)
    @unpack y = problem   # extract the data
    @unpack μ = θ
    loglikelihood(Normal(μ, 0.15), y)
end

obs = convert(Vector{Float64}, df2[:height])
p = ConstraintHeightsProblem(obs);
p((μ = 178,))

P = TransformedLogDensity(as((μ  = as(Real, 0, 250),)), p)
∇P = ADgradient(:ForwardDiff, P);

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));

posterior_μ = mean(first, posterior)

ess = mapslices(effective_sample_size,
                get_position_matrix(chain); dims = 1)

NUTS_statistics(chain)

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

posterior_μ

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

