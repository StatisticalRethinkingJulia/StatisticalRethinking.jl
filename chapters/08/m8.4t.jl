using StatisticalRethinking, Turing

Turing.setadbackend(:reverse_diff);

@model m8_4(y) = begin
    α₁ ~ Uniform(-3000, 1000)
    α₂ ~ Uniform(-1000, 3000)
    σ ~ Truncated(Cauchy(0,1), 0, Inf)

    for i ∈ 1:length(y)
        y[i] ~ Normal(α₁ + α₂, σ)
    end
end

y = rand(Normal(0,1), 100);

posterior = sample(m8_4(y), Turing.NUTS(4000, 1000, 0.95));

posterior2 = MCMCChain.Chains(posterior.value[1001:4000,:,:], names=posterior.names)

describe(posterior2)

m84rethinking = "
         mean      sd     5.5%   94.5% n_eff Rhat
 a1    -861.15 558.17 -1841.89  -31.04     7 1.43
 a2     861.26 558.17    31.31 1842.00     7 1.43
 sigma    0.97   0.07     0.89    1.09     9 1.17
";

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

