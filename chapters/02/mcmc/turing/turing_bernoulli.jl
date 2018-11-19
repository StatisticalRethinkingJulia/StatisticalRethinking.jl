using Turing, MCMCChain, Random, Distributions

# Draw data from a Bernoulli distribution, i.e. draw heads or tails.

p_true = 0.65
#Random.seed!(12)
data = rand(Bernoulli(p_true), 1000)

@model coinflip(y) = begin
    
    # Our prior belief about the probability of heads in a coin.
    p ~ Beta(1, 1)
    
    # The number of observations.
    N = length(y)
    for n in 1:N
        # Heads or tails of a coin are drawn from a Bernoulli distribution.
        y[n] ~ Bernoulli(p)
    end
end;

# Settings of the Hamiltonian Monte Carlo (HMC) sampler.
iterations = 1000
ϵ = 0.05
τ = 10

# Start sampling.
chain = sample(coinflip(data), HMC(iterations, ϵ, τ));

println()
describe(chain[:p])
