using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df);
df2[:weight] = convert(Vector{Float64}, df2[:weight]);
df2[:weight_s] = (df2[:weight] .- mean(df2[:weight])) / std(df2[:weight]);
df2[:weight_s2] = df2[:weight_s] .^ 2;

first(df2, 6)

struct ConstraintHeightProblem{TY <: AbstractVector, TX <: AbstractMatrix}
    "Observations."
    y::TY
    "Covariates"
    X::TX
end;

function (problem::ConstraintHeightProblem)(θ)
    @unpack y, X, = problem   # extract the data
    @unpack β, σ = θ            # works on the named tuple too
    ll = 0.0
    ll += logpdf(Normal(178, 100), X[1]) # a = X[1]
    ll += logpdf(Normal(0, 10), X[2]) # b1 = X[2]
    ll += logpdf(Normal(0, 10), X[3]) # b2 = X[3]
    ll += logpdf(TDist(1.0), σ)
    ll += loglikelihood(Normal(0, σ), y .- X*β)
    ll
end

N = size(df2, 1)
X = hcat(ones(N), hcat(df2[:weight_s], df2[:weight_s2]));
y = convert(Vector{Float64}, df2[:height])
p = ConstraintHeightProblem(y, X);
p((β = [1.0, 2.0, 3.0], σ = 1.0))

problem_transformation(p::ConstraintHeightProblem) =
    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))

P = TransformedLogDensity(problem_transformation(p), p)
∇P = LogDensityRejectErrors(ADgradient(:ForwardDiff, P));

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

posterior = TransformVariables.transform.(Ref(problem_transformation(p)), get_position.(chain));
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

[posterior_β, posterior_σ]

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

