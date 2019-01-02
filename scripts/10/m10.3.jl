using StatisticalRethinking
using Turing

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';')
size(d) # Should be 504x8

# pulled_left, condition, prosoc_left
@model m10_3(y, x₁, x₂) = begin
    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    for i ∈ 1:length(y)
        p = logistic(α + (βp + βpC * x₁[i]) * x₂[i])
        y[i] ~ Binomial(1, p)
    end
end

posterior = sample(m10_3(d[:,:pulled_left], d[:,:condition], d[:,:prosoc_left]),
    Turing.NUTS(10000, 1000, 0.95))
describe(posterior)
#     Empirical Posterior Estimates:
#              Mean           SD        Naive SE       MCSE         ESS
# α           0.053228176  0.148432403 0.0033190494 0.0072162528  423.091170
# βp          0.604297351  0.241527734 0.0054007243 0.0212696753  128.947312
# βpC        -0.074156932  0.278219321 0.0062211731 0.0279932431   98.779800

#StatisticalRethinking
#      Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
# a    0.05   0.13      -0.15       0.25  3284    1
# bp   0.62   0.22       0.28       0.98  3032    1
# bpC -0.11   0.26      -0.53       0.29  3184    1
