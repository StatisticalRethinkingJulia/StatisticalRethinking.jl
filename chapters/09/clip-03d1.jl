using StatisticalRethinking
import LogDensityProblems: logdensity, logdensity_and_gradient
import StatisticalRethinking: HMC2, generate_n_samples

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

chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);

posterior = TransformVariables.transform.(Ref(problem_transformation(p)), get_position.(chain));

[mean(first, posterior), mean(last, posterior)]

function draw_n_samples(model, grad;
  epsilon = 0.03, # Step size
  L = 11, # No of leapfrog steps
  n_samples = 1000, # No of samples
  q = [-0.1, 0.2]) # Initial position

  samples = zeros(n_samples, 2)
  for i in 1:n_samples
    q, ptraj, qtraj, accept, dH = HMC(model, grad, 0.03, 11, q)
    samples[i, :] = q
  end

  samples

end

samples = draw_n_samples(p, ∇P; n_samples=200);
mean(samples, dims=1)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

