using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff);

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';');
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
end;

posterior = sample(m10_4(d[:,:pulled_left], d[:,:actor],d[:,:condition],
d[:,:prosoc_left]), Turing.NUTS(2000, 1000, 0.95));

posterior2 = MCMCChain.Chains(posterior.value[1001:2000,:,:], names=posterior.names);

m_10_04s_result = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
        Mean        SD       Naive SE       MCSE      ESS
a.1 -0.74503184 0.26613979 0.0042080396 0.0060183398 1000
a.2 10.77955494 5.32538998 0.0842018089 0.1269148045 1000
a.3 -1.04982353 0.28535997 0.0045119373 0.0049074219 1000
a.4 -1.04898135 0.28129307 0.0044476339 0.0056325117 1000
a.5 -0.74390933 0.26949936 0.0042611590 0.0052178124 1000
a.6  0.21599365 0.26307574 0.0041595927 0.0045153523 1000
a.7  1.81090866 0.39318577 0.0062168129 0.0071483527 1000
 bp  0.83979926 0.26284676 0.0041559722 0.0059795826 1000
bpC -0.12913322 0.29935741 0.0047332562 0.0049519863 1000
 bpC  -0.13 0.30 -0.63  0.34  3508    1
";

describe(posterior2)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

