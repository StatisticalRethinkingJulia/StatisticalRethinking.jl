using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "Kline.csv"), delim=';')
size(d) # Should be 10x5

d[:log_pop] = map((x) -> log(x), d[:population])

d[:contact_high] = map((x) -> ifelse(x=="high", 1, 0), d[:contact])

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
    d[:contact_high]), Turing.NUTS(2000, 1000, 0.95))

posterior2 = MCMCChain.Chains(posterior.value[1001:2000,:,:], names=posterior.names)

m_10_10t_c_result = "
    mean   sd  5.5% 94.5% n_eff Rhat
 a   3.31 0.09  3.17  3.45  3671    1
 bp  0.26 0.03  0.21  0.32  5052    1
 bc  0.28 0.12  0.10  0.47  3383    1
 bcp 0.07 0.17 -0.20  0.34  4683    1
";

describe(posterior2)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

