using Distributed
using Mamba, Gadfly

globe_toss = Dict{Symbol, Any}(
  :w => [6, 7, 5, 6, 6],
  :n => [9, 9, 9, 9, 9]
)
globe_toss[:N] = length(globe_toss[:w]);

model = Model(
  w = Stochastic(1,
    (n, p, N) ->
      UnivariateDistribution[Binomial(n[i], p) for i in 1:N],
    false
  ),
  p = Stochastic(() -> Beta(1, 1))
);

inits = [
  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => 0.5),
  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => rand(Beta(1, 1)))
];

scheme = [NUTS(:p)]
setsamplers!(model, scheme);

sim = mcmc(model, globe_toss, inits, 10000, burnin=2500, thin=1, chains=2)

describe(sim)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

