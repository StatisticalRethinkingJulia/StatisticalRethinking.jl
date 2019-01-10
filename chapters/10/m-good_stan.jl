using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

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

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

