using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

d = CSV.read(rel_path("..", "data", "rugged.csv"), delim=';');
df = convert(DataFrame, d);

dcc = filter(row -> !(ismissing(row[:rgdppc_2000])), df)
dcc[:log_gdp] = log.(dcc[:rgdppc_2000])
dcc[:cont_africa] = Array{Float64}(convert(Array{Int}, dcc[:cont_africa]))

first(dcc[[:rugged, :cont_africa, :log_gdp]], 5)

struct m_8_1_model{TY <: AbstractVector, TX <: AbstractMatrix}
    "Observations."
    y::TY
    "Covariates"
    X::TX
end

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

N = size(dcc, 1)
X = hcat(ones(N), dcc[:rugged], dcc[:cont_africa], dcc[:rugged].*dcc[:cont_africa]);
y = convert(Vector{Float64}, dcc[:log_gdp])
p = m_8_1_model(y, X);
p((β = [1.0, 2.0, 1.0, 2.0], σ = 1.0))

problem_transformation(p::m_8_1_model) =
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

rethinking = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.22 0.14  9.00  9.46   282    1
bR    -0.21 0.08 -0.33 -0.08   275    1
bA    -1.94 0.24 -2.33 -1.59   268    1
bAR    0.40 0.14  0.18  0.62   271    1
sigma  0.96 0.05  0.87  1.04   339    1
"

[posterior_β, posterior_σ]

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

