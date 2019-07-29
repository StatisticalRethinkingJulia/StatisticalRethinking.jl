# # clip-11-16.jl

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, Optim
#gr(size=(600,600));

# ### snippet 3.11

p_grid = range(0, step=0.001, stop=1)
prior = ones(length(p_grid))
likelihood = [pdf(Binomial(3, p), 3) for p in p_grid]
posterior = likelihood .* prior
posterior = posterior / sum(posterior)

# Draw 10000 samples from this posterior distribution

N = 10000
samples = sample(p_grid, Weights(posterior), N);

# In StatisticalRethinkingJulia samples will always be stored
# in an MCMCChains.Chains object. 

chn = MCMCChains.Chains(reshape(samples, N, 1, 1), ["toss"]);

# ### snippet 3.12

MCMCChains.describe(chn)

# ### snippet 3.13

MCMCChains.hpd(chn, alpha=0.5)

# ### snippet 3.14

mode(samples)

# ### snippet 3.15

mean(samples)

# ### snippet 3.16

median(samples)

# End of `03/clip-11-16.jl`