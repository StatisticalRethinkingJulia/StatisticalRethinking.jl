using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';')
size(d) # Should be 504x8

@model m10_4(y, actors, x₁, x₂) = begin

    N_actor = length(unique(actors))

    α = TArray{Any}(undef, N_actor)

    for i ∈ 1:length(α)
        α[i] ~ Normal(0,10)
    end

    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    for i ∈ 1:length(y)
        p = logistic(α[actors[i]] + (βp + βpC * x₁[i]) * x₂[i])
        y[i] ~ Binomial(1, p)
    end
end

posterior = sample(m10_4(d[:,:pulled_left], d[:,:actor],d[:,:condition],
    d[:,:prosoc_left]),
    Turing.NUTS(2500, 500, 0.95))
describe(posterior)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

