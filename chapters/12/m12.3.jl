using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

μ = 1.4
σ = 1.5
nponds = 60
ni = repeat([5,10,25,35], inner=15)

a_pond = rand(Normal(μ, σ), nponds)

dsim = DataFrame(pond = 1:nponds, ni = ni, true_a = a_pond)

prob = logistic.(Vector{Real}(dsim[:true_a]))

dsim[:si] = [rand(Binomial(ni[i], prob[i])) for i = 1:nponds]

dsim[:p_nopool] = dsim[:si] ./ dsim[:ni]

@model m12_3(pond, si, ni) = begin

    σ ~ Truncated(Cauchy(0, 1), 0, Inf)
    μ ~ Normal(0, 1)

    N_ponds = length(pond)

    a_pond = Vector{Real}(undef, N_ponds)

    a_pond ~ [Normal(μ, σ)]

    logitp = [a_pond[pond[i]] for i = 1:N_ponds]
    si ~ VecBinomialLogit(ni, logitp)

end

posterior = sample(m12_3(Vector{Int64}(dsim[:pond]), Vector{Int64}(dsim[:si]),
    Vector{Int64}(dsim[:ni])), Turing.NUTS(10000, 1000, 0.8))
describe(posterior)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

