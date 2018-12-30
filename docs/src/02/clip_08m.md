```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

```@example clip_08m
using Distributed, Gadfly
using Mamba
```

Data

```@example clip_08m
globe_toss = Dict{Symbol, Any}(
  :w => [6, 7, 5, 6, 6],
  :n => [9, 9, 9, 9, 9]
)
globe_toss[:N] = length(globe_toss[:w]);
```

Model Specification

```@example clip_08m
model = Model(
  w = Stochastic(1,
    (n, p, N) ->
      UnivariateDistribution[Binomial(n[i], p) for i in 1:N],
    false
  ),
  p = Stochastic(() -> Beta(1, 1))
);
```

Initial Values

```@example clip_08m
inits = [
  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => 0.5),
  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => rand(Beta(1, 1)))
];
```

Sampling Scheme

```@example clip_08m
scheme = [NUTS(:p)]
setsamplers!(model, scheme);
```

MCMC Simulations

```@example clip_08m
sim = mcmc(model, globe_toss, inits, 10000, burnin=2500, thin=1, chains=2)
```

Describe draws

```@example clip_08m
describe(sim)
```

End of `clip_08m.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

