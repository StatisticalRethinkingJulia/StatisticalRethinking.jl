using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "UCBadmit.csv"), delim=';')
size(d) # Should be 12x5

@model m11_5(admit, applications) = begin
    N=length(applications)
    θ ~ Truncated(Exponential(1), 0, Inf)
    α ~ Normal(0,2)

    for i ∈ 1:N
        prob = logistic(α)

        alpha = prob * θ
        beta = (1 - prob) * θ

        admit[i] ~ BetaBinomial(applications[i], alpha, beta)
    end
end

posterior = sample(m11_5(d[:admit],d[:applications]), Turing.NUTS(4000, 1000, 0.9))
describe(posterior)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

