using StatisticalRethinking
using Turing
using StatsFuns #logistic

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "Kline.csv"), delim=';')
size(d) # Should be 10x5

# New col log_pop, set log() for population data
d[:log_pop] = map(x -> log(x), d[:population])

# New col contact_high, set binary values 1/0 if high/low contact
d[:contact_high] = map(x -> ifelse(x=="high", 1, 0), d[:contact])

@model m10_10stan(total_tools, log_pop, contact_high) = begin
    α ~ Normal(0, 100)
    βp ~ Normal(0, 1)
    βc ~ Normal(0, 1)
    βpc ~ Normal(0, 1)

    for i ∈ 1:length(total_tools)
        λ = exp(α + βp*log_pop[i] + βc*contact_high[i] +
            βpc*contact_high[i]*log_pop[i])
        total_tools[i] ~ Poisson(λ)
    end
end

posterior = sample(m10_10stan(d[:total_tools], d[:log_pop],
    d[:contact_high]), Turing.NUTS(3000, 1000, 0.95))
describe(posterior)
