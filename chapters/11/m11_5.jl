using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "UCBadmit.csv"), delim=';')
size(d) # Should be 12x5

@model m11_5(applications) = begin
    N=length(applications)
    θ ~ Truncated(Exponential(1), 0, Inf)
    α ~ Normal(0,2)

    for i ∈ 1:N
        prob = logistic(α)

        # alpha and beta for the BetaBinomial must be provided.
        # The two parameterizations are related by
        # alpha = prob * theta, and beta = (1-prob) * theta.
        # See https://github.com/rmcelreath/rethinking/blob/master/man/dbetabinom.Rd
        alpha = prob * θ
        beta = (1 - prob) * θ

        applications[i] ~ BetaBinomial(N, alpha, beta)
    end
end

# Here Turing hangs atm 2018-12-09
posterior = sample(m11_5(d[:applications]), Turing.NUTS(4000, 1000, 0.95))
describe(posterior)

# Rethinking
#        mean   sd  5.5% 94.5% n_eff Rhat
# theta  2.74 0.96  1.43  4.37  3583    1
# a     -0.37 0.31 -0.87  0.12  3210    1
