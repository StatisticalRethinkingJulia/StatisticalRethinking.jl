using StatisticalRethinking
using Turing
using StatsFuns #logistic

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "Kline.csv"), delim=';')
size(d) # Should be 10x5

# New col log_pop, set log() for population data
d[:log_pop] = map((x) -> log(x), d[:population])

# New col contact_high, set binary values 1/0 if high/low contact
d[:contact_high] = map((x) -> ifelse(x=="high", 1, 0), d[:contact])

# New col where we center the log_pop values
mean_log_pop = mean(d[:log_pop])
d[:log_pop_c] = map((x) -> x - mean_log_pop, d[:log_pop])

@model m10_10stan_c(total_tools, log_pop_c, contact_high) = begin
    α ~ Normal(0, 100)
    βp ~ Normal(0, 1)
    βc ~ Normal(0, 1)
    βpc ~ Normal(0, 1)

    for i ∈ 1:length(total_tools)
        λ = exp(α + βp*log_pop_c[i] + βc*contact_high[i] +
            βpc*contact_high[i]*log_pop_c[i])
        total_tools[i] ~ Poisson(λ)
    end
end

posterior = sample(m10_10stan_c(d[:total_tools], d[:log_pop_c],
    d[:contact_high]), Turing.NUTS(1000, 1000, 0.95))
describe(posterior)
