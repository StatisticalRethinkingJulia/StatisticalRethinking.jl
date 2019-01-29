using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)

wd = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
df = convert(DataFrame, wd);
mean_ma = mean(df[:MedianAgeMarriage])
df[:MedianAgeMarriage_s] = convert(Vector{Float64},
  (df[:MedianAgeMarriage]) .- mean_ma)/std(df[:MedianAgeMarriage]);

first(df, 6)

"""
Linear regression model ``y ∼ Xβ + ϵ``, where ``ϵ ∼ N(0, σ²)`` IID.
Flat prior for `β`, half-T for `σ`.
"""
struct WaffleDivorceProblem{TY <: AbstractVector, TX <: AbstractMatrix}
    "Observations."
    y::TY
    "Covariates"
    X::TX
end

function (problem::WaffleDivorceProblem)(θ)
    @unpack y, X, = problem   # extract the data
    @unpack β, σ = θ            # works on the named tuple too
    ll = 0.0
    ll += logpdf(Normal(10, 10), X[1]) # a = X[1]
    ll += logpdf(Normal(0, 1), X[2]) # b1 = X[2]
    ll += logpdf(TDist(1.0), σ)
    ll += loglikelihood(Normal(0, σ), y .- X*β)
    ll
end

N = size(df, 1)
X = hcat(ones(N), df[:MedianAgeMarriage_s]);
y = convert(Vector{Float64}, df[:Divorce])
p = WaffleDivorceProblem(y, X);
p((β = [1.0, 2.0], σ = 1.0))

problem_transformation(p::WaffleDivorceProblem) =
    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));
posterior[1:5]

posterior_β = mean(first, posterior)

posterior_σ = mean(last, posterior)

ess = mapslices(effective_sample_size,
                get_position_matrix(chain); dims = 1)

NUTS_statistics(chain)

cmdstan_result = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
         Mean        SD       Naive SE       MCSE      ESS
    a  9.6882466 0.22179190 0.0035068378 0.0031243061 1000
   bA -1.0361742 0.21650514 0.0034232469 0.0034433245 1000
sigma  1.5180337 0.15992781 0.0025286807 0.0026279593 1000

Quantiles:
         2.5%      25.0%     50.0%      75.0%       97.5%
    a  9.253141  9.5393175  9.689585  9.84221500 10.11121000
   bA -1.454571 -1.1821025 -1.033065 -0.89366925 -0.61711705
sigma  1.241496  1.4079225  1.504790  1.61630750  1.86642750
";

[posterior_β, posterior_σ]

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

