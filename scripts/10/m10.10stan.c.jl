using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "Kline.csv"), delim=';')
size(d) # Should be 10x5

# New col log_pop, set log() for population data
d[:log_pop] = map((x) -> log(x), d[:population])

# New col contact_high, set binary values 1/0 if high/low contact
d[:contact_high] = map((x) -> ifelse(x=="high", 1, 0), d[:contact])

# New col where we center(!) the log_pop values
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
    d[:contact_high]), Turing.NUTS(3000, 1000, 0.95))
describe(posterior)
#              Mean           SD         Naive SE       MCSE         ESS
 #       α   3.3338647013  0.094698500 0.00172895015 0.0121434117   60.814167
 #  lf_num   0.0010000000  0.054772256 0.00100000000 0.0010000000 3000.000000
 #     βpc   0.0890018433  0.152850898 0.00279066283 0.0226016674   45.735669
 #      βc   0.2611529626  0.120796429 0.00220543096 0.0183649326   43.264283
 # elapsed   0.0191862855  0.015193775 0.00027739910 0.0006082621  623.950169
 # epsilon   0.0038850846  0.011268260 0.00020572933 0.0010340974  118.738301
 #      βp   0.2587349761  0.033836894 0.00061777433 0.0027394646  152.563131

# Rethinking
#    mean   sd  5.5% 94.5% n_eff Rhat
# a   3.31 0.09  3.17  3.45  3671    1
# bp  0.26 0.03  0.21  0.32  5052    1
# bc  0.28 0.12  0.10  0.47  3383    1
# bcp 0.07 0.17 -0.20  0.34  4683    1
