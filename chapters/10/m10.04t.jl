using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';')
size(d) # Should be 504x8

@model m10_4(y, actors, x₁, x₂) = begin

    N_actor = length(unique(actors))

    α = TArray{Any}(undef, N_actor)

    for i ∈ 1:length(α)
        α[i] ~ Normal(0,10)
    end

    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    for i ∈ 1:length(y)
        p = logistic(α[actors[i]] + (βp + βpC * x₁[i]) * x₂[i])
        y[i] ~ Binomial(1, p)
    end
end

posterior = sample(m10_4(d[:,:pulled_left], d[:,:actor],d[:,:condition],
d[:,:prosoc_left]), Turing.NUTS(2000, 1000, 0.95))

posterior2 = MCMCChain.Chains(posterior.value[1001:2000,:,:], names=posterior.names)

m_10_04t_result = "
       mean   sd  5.5% 94.5% n_eff Rhat
 a[1] -0.74 0.27 -1.17 -0.31  3838    1
 a[2] 11.02 5.53  4.46 21.27  1759    1
 a[3] -1.05 0.28 -1.50 -0.61  3784    1
 a[4] -1.05 0.27 -1.48 -0.62  3761    1
 a[5] -0.74 0.27 -1.18 -0.32  4347    1
 a[6]  0.21 0.27 -0.23  0.66  3932    1
 a[7]  1.81 0.39  1.19  2.46  4791    1
 bp    0.84 0.26  0.42  1.26  2586    1
 bpC  -0.13 0.30 -0.63  0.34  3508    1
";

describe(posterior2)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

