```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

```@example m_good_stan
using StatisticalRethinking
using Turing
using StatsFuns #logistic


Turing.setadbackend(:reverse_diff)
```

outcome and predictor almost perfectly associated

```@example m_good_stan
x = repeat([-1], 9); append!(x, repeat([1],11))
y = repeat([0], 10); append!(y, repeat([1],10))

@model m_good_stan(x,y) = begin
    α ~ Normal(0,10)
    β ~ Normal(0,10)

    for i ∈ 1:length(y)
        p = logistic(α + β * x[i])
        y[i] ~ Binomial(1, p)
    end
end

posterior = sample(m_good_stan(x,y), Turing.NUTS(2000, 1000, 0.95))
describe(posterior)
```

       Mean          SD        Naive SE       MCSE         ESS
α  -8.716748466  4.226359431 0.0945042699 0.8913931285   22.479896
β  11.240259899  3.945816136 0.0882311311 0.8199224835   23.159442

Rethinking
   mean   sd   5.5% 94.5% n_eff Rhat
a -5.09 4.08 -12.62 -0.25   100 1.00
b  7.86 4.09   2.96 15.75   104 1.01

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

