# Snippet 09/clip-03.jl

using StatisticalRethinking

ProjDir = rel_path("..", "scripts", "09")

# ### snippet 9.3

# Construct the logdensity problem

struct clip_9_3_model{TY <: AbstractVector, TX <: AbstractVector}
    "Observations."
    y::TY
    "Covariate"
    x::TX
end

# Make the type callable with the parameters *as a single argument*.

function (problem:: clip_9_3_model)(θ)
    @unpack y, x, = problem    # extract the data
    @unpack muy, mux = θ     # works on the named tuple too
    ll = 0.0
    ll += loglikelihood(Normal(mux, 1), x)
    ll += loglikelihood(Normal(muy, 1), y)
    ll += logpdf(Normal(0, 1), mux) 
    ll += logpdf(Normal(0, 1), muy)
    ll
end

# Instantiate the model with data and inits.

Random.seed!(1234591)

N = 100
x = rand(Normal(0, 1), N)
y = rand(Normal(0, 1), N)
 
p = clip_9_3_model(y, x)
θ = (muy = 0.0, mux=0.0)
p(θ)

# Write a function to return properly dimensioned transformation.

problem_transformation(p::clip_9_3_model) =
    as((muy = asℝ, mux = asℝ))

# Wrap the problem with a transformation, then use Flux for the gradient.

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);

# Generate and show fig 9.3

fig = StatisticalRethinking.generate_n_samples(p, ∇P; pr=0.5);
savefig("$ProjDir/fig-03.pdf")

# End of `09/clip-03d.jl`
