using StatisticalRethinking
using Turing

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';')
size(d) # Should be 504x8

@model m10_3(y, x₁, x₂) = begin
    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    for i ∈ 1:length(y)
        p = logistic(α + (βp + βpC * x₁[i]) * x₂[i])
        y[i] ~ Binomial(1, p)
    end
end

posterior = sample(m10_3(d[:,:pulled_left], d[:,:condition], d[:,:prosoc_left]),
    Turing.NUTS(10000, 1000, 0.95))
describe(posterior)

#StatisticalRethinking

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

