using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff

ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)

wd = CSV.read(rel_path("..", "data", "milk.csv"), delim=';')
df = convert(DataFrame, wd);
dcc = filter(row -> !(row[:neocortex_perc] == "NA"), df)
dcc[:kcal_per_g] = convert(Vector{Float64}, dcc[:kcal_per_g])
dcc[:log_mass] = log.(convert(Vector{Float64}, dcc[:mass]))

first(dcc[[3, 7, 9]], 5)

struct m_5_6{TY <: AbstractVector, TX <: AbstractMatrix}
    "Observations."
    y::TY
    "Covariates"
    X::TX
end

function (problem::m_5_6)(θ)
    @unpack y, X, = problem   # extract the data
    @unpack β, σ = θ            # works on the named tuple too
    ll = 0.0
    ll += logpdf(Normal(0, 100), X[1]) # a = X[1]
    ll += logpdf(Normal(0, 1), X[2]) # b1 = X[2]
    ll += logpdf(TDist(1.0), σ)
    ll += loglikelihood(Normal(0, σ), y .- X*β)
    ll
end

N = size(dcc, 1)
X = hcat(ones(N), dcc[:log_mass]);
y = dcc[:kcal_per_g]
p = m_5_6(y, X);
p((β = [1.0, 2.0], σ = 1.0))

problem_transformation(p::m_5_6) =
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
          Mean         SD        Naive SE       MCSE      ESS
    a  0.70472876 0.057040655 0.00090189195 0.0011398893 1000
   bm -0.03150330 0.023642759 0.00037382484 0.0004712342 1000
sigma  0.18378372 0.039212805 0.00062000888 0.0011395979 1000

Quantiles:
          2.5%       25.0%       50.0%        75.0%       97.5%
    a  0.59112968  0.66848775  0.70444950  0.741410500 0.81915225
   bm -0.07729257 -0.04708425 -0.03104865 -0.015942925 0.01424901
sigma  0.12638780  0.15605950  0.17800600  0.204319250 0.27993590
";

[posterior_β, posterior_σ]

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

