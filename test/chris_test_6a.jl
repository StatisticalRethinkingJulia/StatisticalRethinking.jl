# chris_test_5a.jl

using DynamicHMCModels, ReverseDiff

ProjDir = @__DIR__
cd(ProjDir)

# Define user likelihood distribution

import Distributions: logpdf, pdf
mutable struct mydist{T1,T2} <: ContinuousUnivariateDistribution
    μ::T1
    σ::T2
end

function pdf(dist::mydist, x::Float64)
  @unpack μ,σ=dist
  pdf(Normal(μ,σ), x)
end

struct ChrisProblem5a{TY <: AbstractVector}
    "Observations."
    y::TY
end;

# Very constraint prior on μ. Flat σ.

function (problem::ChrisProblem5a)(θ)
    @unpack y = problem   # extract the data
    @unpack μ, σ = θ
    loglikelihood(mydist(μ, σ), y) + logpdf(Normal(0.1), μ) + 
    logpdf(Truncated(Cauchy(0,1),0,Inf), σ)
end;

# Define problem with data and inits.
function dhmc(data::Dict, nsamples=2000)
  
  N = data["N"]
  obs = data["y"]
  p = ChrisProblem5a(obs);
  p((μ = 0, σ = 5.0))

  # Write a function to return properly dimensioned transformation.

  problem_transformation(p::ChrisProblem5a) =
      as((μ  = as(Real, -25, 25), σ = asℝ₊), )

  # Use Flux for the gradient.

  P = TransformedLogDensity(problem_transformation(p), p)
  #∇P = LogDensityRejectErrors(ADgradient(:ReverseDiff, P));
  ∇P = LogDensityRejectErrors(ADgradient(:ForwardDiff, P));

  # FSample from the posterior.

  chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, nsamples);

  # Undo the transformation to obtain the posterior from the chain.

  posterior = TransformVariables.transform.(Ref(problem_transformation(p)), get_position.(chain));
  
  # Set varable names, this will be automated using θ

  parameter_names = ["μ", "σ"]

  # Create a3d

  a3d = Array{Float64, 3}(undef, 2000, 2, 1);
  for i in 1:2000
    a3d[i, 1, 1] = values(posterior[i][1])
    a3d[i, 2, 1] = values(posterior[i][2])
  end

  chns = MCMCChains.Chains(a3d,
    parameter_names,
    Dict(
      :parameters => parameter_names,
    )
  );
  
  chns
end

# end of chris_test_5a.jl