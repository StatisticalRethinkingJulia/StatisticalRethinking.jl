using StatisticalRethinking, Turing

Turing.setadbackend(:reverse_diff)
Turing.turnprogress(false) #nb

# In Rethinking the model actually has priors that are U[-Inf, Inf], or as the Stan manual
# (2.17.0, pp. 127) tells us:
#
# "A parameter declared without constraints is thus given a uniform prior on (−∞, ∞) ..."
#
# But setting -Inf and Inf in Turing doesn't work. So the below works of course better since
# we've restrained it to [-1,1]

@model m8_2(y) = begin
    σ ~ Uniform(-1, 1)
    α ~ Uniform(-1, 1)

    for i ∈ 1:length(y)
        y[i] ~ Normal(α, σ)
    end
end

y = [-1,1]

posterior = sample(m8_2(y), Turing.NUTS(4000, 1000, 0.95))
describe(posterior)
