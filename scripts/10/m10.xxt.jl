using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

# outcome and predictor almost perfectly associated

x = repeat([-1], 9); append!(x, repeat([1],11))
y = repeat([0], 10); append!(y, repeat([1],10))

@model m_good_stan(x,y) = begin
    α ~ Normal(0,10)
    β ~ Normal(0,10)

    for i ∈ 1:length(y)
        p = logistic(α + β * x[i])
        y[i] ~ Binomial(1, p)
    end
end

posterior = sample(m_good_stan(x,y), Turing.NUTS(2000, 1000, 0.95))

# Fix the inclusion of adaptation samples

posterior2 = MCMCChain.Chains(posterior.value[1001:2000,:,:], names=posterior.names)

# Stan results

m_10_x,_results = "
    mean   sd   5.5% 94.5% n_eff Rhat
 a -5.09 4.08 -12.62 -0.25   100 1.00
 b  7.86 4.09   2.96 15.75   104 1.01
";

# Look at the proper draws (in corrected chn2)

describe(posterior2)

# End of 10/m_10_xxt.jl
