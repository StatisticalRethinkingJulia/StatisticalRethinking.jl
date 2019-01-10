using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';')
size(d) # Should be 504x8

@model m12_5(pulled_left, actor, block, condition, prosoc_left) = begin

    N = length(pulled_left)

    σ_actor ~ Truncated(Cauchy(0, 1), 0, Inf)
    σ_block ~ Truncated(Cauchy(0, 1), 0, Inf)

    N_actor = length(unique(actor)) #7
    N_block = length(unique(block))

    α_actor = Vector{Real}(undef, N_actor)
    α_block = Vector{Real}(undef, N_block)

    α_actor ~ [Normal(0, σ_actor)]
    α_block ~ [Normal(0, σ_block)]

    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    logitp = [α + α_actor[actor[i]] + α_block[block[i]] +
            (βp + βpC * condition[i]) * prosoc_left[i]
            for i = 1:N]

    pulled_left ~ VecBinomialLogit(ones(Int64, N), logitp)

end

posterior = sample(m12_5(
    Vector{Int64}(d[:pulled_left]),
    Vector{Int64}(d[:actor]),
    Vector{Int64}(d[:block]),
    Vector{Int64}(d[:condition]),
    Vector{Int64}(d[:prosoc_left])),
    Turing.NUTS(6000, 1000, 0.95))
describe(posterior)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

