using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)
#nbTuring.turnprogress(false);

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "UCBadmit.csv"), delim=';');
size(d) # Should be 12x5

# Turing model

@model m11_5(admit, applications) = begin
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

        admit[i] ~ BetaBinomial(applications[i], alpha, beta)
    end
end

# Sample

posterior = sample(m11_5(d[:admit],d[:applications]), Turing.NUTS(4000, 1000, 0.9));

# Draw summary

describe(posterior)

# Result rethinking

m115rethinking = "
         mean   sd  5.5% 94.5% n_eff Rhat
theta  2.74 0.96  1.43  4.37  3583    1
a       -0.37 0.31 -0.87  0.12  3210    1
";
