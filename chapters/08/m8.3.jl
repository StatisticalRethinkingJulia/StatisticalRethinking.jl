using StatisticalRethinking, Turing

Turing.setadbackend(:reverse_diff)
Turing.turnprogress(false) #nb

@model m8_3(y) = begin
    α ~ Normal(1, 10)
    σ ~ Truncated(Cauchy(0, 1), 0, Inf)

    for i ∈ 1:length(y)
        y[i] ~ Normal(α, σ)
    end
end

y = [-1,1]

posterior = sample(m8_3(y), Turing.NUTS(4000, 1000, 0.95))
describe(posterior)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

