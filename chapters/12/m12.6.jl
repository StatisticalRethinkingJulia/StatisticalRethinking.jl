using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "Kline.csv"), delim=';')
size(d) # Should be 10x5

d[:log_pop] = map((x) -> log(x), d[:population])
d[:society] = 1:10

@model m12_6(total_tools, log_pop, society) = begin

    N = length(total_tools)

    α ~ Normal(0, 10)
    βp ~ Normal(0, 1)

    σ_society ~ Truncated(Cauchy(0, 1), 0, Inf)

    N_society = length(unique(society)) #10

    α_society = Vector{Real}(undef, N_society)

    α_society ~ [Normal(0, σ_society)]

    for i ∈ 1:N
        λ = exp(α + α_society[society[i]] + βp*log_pop[i])
        total_tools[i] ~ Poisson(λ)
    end
end

posterior = sample(m12_6(d[:total_tools], d[:log_pop],
    d[:society]), Turing.NUTS(4000, 1000, 0.95))
describe(posterior)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

