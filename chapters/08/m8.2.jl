using StatisticalRethinking, Turing

Turing.setadbackend(:reverse_diff)
Turing.turnprogress(false) #nb

@model m8_2(y) = begin
    σ ~ Uniform(-1, 1)
    α ~ Uniform(-1, 1)

    for i ∈ 1:length(y)
        y[i] ~ Normal(α, σ)
    end
end

y = [-1,1]

posterior = sample(m8_2(y), Turing.NUTS(4000, 1000, 0.95))
describe(posterior)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

