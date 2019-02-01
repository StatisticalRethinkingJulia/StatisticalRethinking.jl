using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff);

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';');
size(d) # Should be 504x8

@model m10_3(y, x₁, x₂) = begin
    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    for i ∈ 1:length(y)
        p = logistic(α + (βp + βpC * x₁[i]) * x₂[i])
        y[i] ~ Binomial(1, p)
    end
end;

posterior = sample(m10_3(d[:,:pulled_left], d[:,:condition], d[:,:prosoc_left]),
Turing.NUTS(2000, 1000, 0.95));

posterior2 = MCMCChain.Chains(posterior.value[1001:2000,:,:], names=posterior.names);

m_10_03t_result = "
      Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
 a    0.05   0.13      -0.15       0.25  3284    1
 bp   0.62   0.22       0.28       0.98  3032    1
 bpC -0.11   0.26      -0.53       0.29  3184    1
";

describe(posterior2)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

