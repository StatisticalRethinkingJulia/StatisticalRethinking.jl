using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';');
size(d) # Should be 504x8

@model m12_5(pulled_left, actor, block, condition, prosoc_left) = begin

    N = length(pulled_left)

    σ_actor ~ Truncated(Cauchy(0, 1), 0, Inf)
    σ_block ~ Truncated(Cauchy(0, 1), 0, Inf)

    N_actor = length(unique(actor)) #7
    N_block = length(unique(block))

    α_actor = Vector{Real}(undef, N_actor)
    α_block = Vector{Real}(undef, N_block)

    α_actor ~ [Normal(0, σ_actor)]
    α_block ~ [Normal(0, σ_block)]

    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    logitp = [α + α_actor[actor[i]] + α_block[block[i]] +
            (βp + βpC * condition[i]) * prosoc_left[i]
            for i = 1:N]

    pulled_left ~ VecBinomialLogit(ones(Int64, N), logitp)

end

posterior = sample(m12_5(
    Vector{Int64}(d[:pulled_left]),
    Vector{Int64}(d[:actor]),
    Vector{Int64}(d[:block]),
    Vector{Int64}(d[:condition]),
    Vector{Int64}(d[:prosoc_left])),
    Turing.NUTS(6000, 1000, 0.95));

describe(posterior)

m125rethinking = "
             Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
a_actor[1]  -1.19   0.98      -2.66       0.35  3451    1
a_actor[2]   4.14   1.59       1.87       6.38  5514    1
a_actor[3]  -1.49   0.99      -2.96       0.05  3493    1
a_actor[4]  -1.50   0.98      -3.00       0.01  3340    1
a_actor[5]  -1.19   0.99      -2.68       0.34  3447    1
a_actor[6]  -0.25   0.99      -1.79       1.25  3361    1
a_actor[7]   1.30   1.01      -0.21       2.89  3673    1
a_block[1]  -0.19   0.23      -0.56       0.10  3825    1
a_block[2]   0.04   0.19      -0.24       0.34  9346    1
a_block[3]   0.06   0.19      -0.22       0.37  9202    1
a_block[4]   0.00   0.18      -0.29       0.29 11314    1
a_block[5]  -0.03   0.19      -0.33       0.25 10596    1
a_block[6]   0.11   0.21      -0.16       0.45  6040    1
a            0.47   0.97      -1.01       1.99  3273    1
bp           0.83   0.26       0.40       1.24 13225    1
bpc         -0.15   0.30      -0.61       0.36  8492    1
sigma_actor  2.27   0.91       1.03       3.35  5677    1
sigma_block  0.23   0.18       0.01       0.44  2269    1
";

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

