using StatisticalRethinking

@model m8_3(y) = begin
    α ~ Normal(1, 10)
    σ ~ Truncated(Cauchy(0, 1), 0, Inf)

    for i ∈ 1:length(y)
        y[i] ~ Normal(α, σ)
    end
end

y = [-1,1]

posterior = sample(m8_3(y), Turing.NUTS(4000, 1000, 0.95))
describe(posterior)
#             Mean          SD         Naive SE        MCSE         ESS
# α       -1.075811343  1.334041836 0.02109305348 0.19866042331   45.093733
# σ        2.137823169  1.466095174 0.02318100009 0.18324552293   64.011438
#
# According to Rethinking
#        Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
# alpha -0.01   1.60      -1.98       2.37  1121    1
# sigma  1.98   1.91       0.47       3.45  1077    1
