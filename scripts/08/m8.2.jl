using StatisticalRethinking, Turing

Turing.setadbackend(:reverse_diff);
#nb Turing.turnprogress(false);

# In Rethinking the model actually has priors that are Uniform[-Inf, Inf], or as the Stan manual (2.17.0, pp. 127) tells us:

# "A parameter declared without constraints is thus given a uniform prior
# on (−∞, ∞) ..."

# Setting -Inf and Inf in Turing doesn't work. So the below works of
# course better since we've restrained it to [-1,1]

@model m8_2(y) = begin
    σ ~ Uniform(0, Inf)
    α ~ Uniform(-Inf, Inf)

    for i ∈ 1:length(y)
        y[i] ~ Normal(α, σ)
    end
end

y = [-1,1];

# Sample

posterior = sample(m8_2(y), Turing.NUTS(100, 500, 0.95));

# Fix the inclusion of adaptation samples

posterior2 = MCMCChain.Chains(posterior.value[501:1000,:,:], names=posterior.names)

# Describe the posterior samples

describe(posterior2)

# Results rethinking

m82rethinking = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.22 0.15  9.00  9.46   205    1
bR    -0.20 0.08 -0.34 -0.07   192    1
bA    -1.95 0.24 -2.36 -1.59   203    1
bAR    0.40 0.14  0.19  0.63   186    1
sigma  0.95 0.05  0.88  1.04   361    1
";