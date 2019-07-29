using StatisticalRethinking

ProjDir = @__DIR__
cd(ProjDir)

struct clip_9_3_model{TY <: AbstractVector, TX <: AbstractVector}
    "Observations."
    y::TY
    "Covariate"
    x::TX
end

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

Random.seed!(1234591)

N = 100
x = rand(Normal(0, 1), N)
y = rand(Normal(0, 1), N)

p = clip_9_3_model(y, x)
θ = (muy = 0.0, mux=0.0)
p(θ)

problem_transformation(p::clip_9_3_model) =
    as((muy = asℝ, mux = asℝ))

P = TransformedLogDensity(problem_transformation(p), p)
∇P = ADgradient(:ForwardDiff, P);

fig = StatisticalRethinking.generate_n_samples(p, ∇P);

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

