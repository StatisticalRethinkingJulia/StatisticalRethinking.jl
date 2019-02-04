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

struct m_12_06d_model{TY <: AbstractVector, TX <: AbstractMatrix,
  TS <: AbstractVector}
    "Observations (total_tools)."
    y::TY
    "Covariates (logpop)"
    X::TX
    "Society"
    S::TS
    "Number of observations (10)"
    N::Int
    "Number of societies (also 10)"
    N_societies::Int
end

# Make the type callable with the parameters *as a single argument*.

function (problem::m_12_06d_model)(θ)
    @unpack y, X, S, N, N_societies = problem   # extract the data
    @unpack β, α, σ = θ  # β : a, bp, α : a_society
    ll = 0.0
    ll += logpdf(Cauchy(0, 1), σ)
    ll += sum(logpdf.(Normal(0, σ), α)) # α[1:10]
    ll += sum(logpdf.(Normal(0, 10), β[1])) # a
    ll += sum(logpdf.(Normal(0, 1), β[2])) # a
    ll += sum(
      [loglikelihood(Poisson(exp(α[S[i]] + dot(X[i, :], β))), [y[i]]) for i in 1:N]
    )
    ll
end

# Instantiate the model with data and inits.

N = size(df, 1)
N_societies = length(unique(df[:society]))
X = hcat(ones(Int64, N), df[:logpop]);
S = df[:society]
y = df[:total_tools]
p = m_12_06d_model(y, X, S, N, N_societies);
θ = (β = [1.0, 0.25], α = rand(Normal(0, 1), N_societies), σ = 0.2)
p(θ)

# Write a function to return properly dimensioned transformation.

problem_transformation(p::m_12_06d_model) =
    as( (β = as(Array, size(p.X, 2)), α = as(Array, p.N_societies), σ = asℝ₊) )

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = LogDensityRejectErrors(ADgradient(:ForwardDiff, P));

# Tune and sample.

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

# We use the transformation to obtain the posterior from the chain.

posterior = TransformVariables.transform.(Ref(problem_transformation(p)), get_position.(chain));
posterior[1:5]

# Extract the parameter posterior means.

posterior_β = mean(posterior[i].β for i in 1:length(posterior))
posterior_α = mean(posterior[i].α for i in 1:length(posterior))
posterior_σ = mean(posterior[i].σ for i in 1:length(posterior))

# Effective sample sizes (of untransformed draws)

ess = mapslices(effective_sample_size, get_position_matrix(chain); dims = 1)
ess

# NUTS-specific statistics

NUTS_statistics(chain)

# CmdStan result

m_12_6_result = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
                            Mean                SD               Naive SE             MCSE            ESS    
            a          1.076167468  0.7704872560 0.01218247319 0.0210530022 1000.000000
           bp         0.263056273  0.0823415805 0.00130193470 0.0022645077 1000.000000
  a_society.1   -0.191723568  0.2421382537 0.00382854195 0.0060563054 1000.000000
  a_society.2    0.054569029  0.2278506876 0.00360263570 0.0051693148 1000.000000
  a_society.3   -0.035935050  0.1926364647 0.00304584994 0.0039948433 1000.000000
  a_society.4    0.334355037  0.1929971201 0.00305155241 0.0063871707  913.029080
  a_society.5    0.049747513  0.1801287716 0.00284808595 0.0043631095 1000.000000
  a_society.6   -0.311903245  0.2096126337 0.00331426674 0.0053000536 1000.000000
  a_society.7    0.148637507  0.1744680594 0.00275858223 0.0047660246 1000.000000
  a_society.8   -0.164567976  0.1821341074 0.00287979309 0.0034297298 1000.000000
  a_society.9    0.277066965  0.1758237250 0.00278001719 0.0055844175  991.286501
 a_society.10   -0.094149204  0.2846206232 0.00450024719 0.0080735022 1000.000000
sigma_society    0.310352849  0.1374834682 0.00217380450 0.0057325226  575.187461
";
        
# Show means

[posterior_β, posterior_α, posterior_σ]

# End of m12.6d.jl
