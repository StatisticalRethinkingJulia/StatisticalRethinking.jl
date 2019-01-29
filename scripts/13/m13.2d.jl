# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics
using Parameters, ForwardDiff
gr(size=(500,500));

# Switch to a local directory

ProjDir = rel_path("..", "scripts", "13")
cd(ProjDir)

# ### snippet 13.1

wd = CSV.read(rel_path("..", "data", "UCBadmit.csv"), delim=';');
df = convert(DataFrame, wd);

# Preprocess data

df[:admit] = convert(Vector{Int}, df[:admit])
df[:applications] = convert(Vector{Int}, df[:applications])
df[:male] = [(df[:gender][i] == "male" ? 1 : 0) for i in 1:size(df, 1)];
df[:dept_id] = [Int(df[:dept][i][1])-64 for i in 1:size(df, 1)];

# Show the first six rows of the updated dataset.

first(df, 6)

# Then define a structure to hold the data: observables, covariates, and the degrees of freedom for the prior.

"""
Linear regression model ``y ∼ Xβ + ϵ``, where ``ϵ ∼ N(0, σ²)`` IID.
Flat prior for `β`, half-T for `σ`.
"""
struct UCBadmitProblem{TY <: AbstractVector, TX <: AbstractMatrix,
Tν <: Real}
    "Observations."
    y::TY
    "Covariates"
    X::TX
    "Degrees of freedom for prior."
    v::Tν
end

# Then make the type callable with the parameters *as a single argument*.

function (problem::UCBadmitProblem)(θ)
    @unpack y, X, v = problem                        # extract the data
    @unpack β, σ, p, applications, admit = θ  # works on the named tuple too
    ll = 0.0
    ll += logpdf(Normal(0, 10), β[1]) # a = X[1]   # a
    ll += logpdf(Normal(0, 1), β[2]) # bm = X[2]  # bm
    ll += logpdf(TDist(v), σ) # sigma_dept
    for i in 1:12 # apply gender?
      p[i] = logistic(β[1] + β[2]*X[i, 2])
    end
    ll += sum([logpdf.(Binomial(applications[i], p[i]), admit[i]) for i in 1:12]) # admits
    ll
end

# Define data.

N = size(df, 1)
X = hcat(ones(N), hcat(df[:male]));
y = df[:admit]

p = UCBadmitProblem(y, X, 1.0);
θ = (β=[1.0, 2.0], σ=1.0, p=zeros(N), applications=df[:applications], admit=df[:admit],)
p(θ)

# Function to return the transformation (as it varies with the number of covariates).

problem_transformation(p::UCBadmitProblem) =
    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);

# Sample.

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

# We use the transformation to obtain the posterior from the chain.

posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));
posterior[1:5]

# Extract the parameter posterior means: `β`,

posterior_β = mean(first, posterior)

# then `σ`:

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
                         Mean            SD             Naive SE          MCSE         ESS
  a_dept.1     0.67464325 0.09859691 0.0015589540 0.0019306626 1000
  a_dept.2     0.63025840 0.11648373 0.0018417695 0.0024909421 1000
  a_dept.3    -0.58216808 0.07461294 0.0011797341 0.0014592677 1000
  a_dept.4    -0.61684932 0.08472722 0.0013396549 0.0015784160 1000
  a_dept.5    -1.05918871 0.09945114 0.0015724606 0.0014025786 1000
  a_dept.6    -2.60967201 0.15465651 0.0024453342 0.0029560871 1000
         a         -0.58417475 0.65187565 0.0103070590 0.0148029970 1000
        bm       -0.09517272 0.08046985 0.0012723400 0.0020114236 1000
sigma_dept  1.47678303 0.57295189 0.0090591648 0.0136701348 1000
";

# Extract the parameter posterior means: `β`,

[posterior_β, posterior_σ]

# end of m4.5d.jl