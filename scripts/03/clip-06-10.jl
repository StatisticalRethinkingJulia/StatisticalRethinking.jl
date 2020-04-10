# # clip-06-10.jl

# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

# ### snippet 3.2

p_grid = range(0, step=0.001, stop=1)
prior = ones(length(p_grid))
likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
posterior = likelihood .* prior
posterior = posterior / sum(posterior)

# ### snippet 3.3
# Draw 10000 samples from this posterior distribution

N = 10000
samples = sample(p_grid, Weights(posterior), N);

# In StatisticalRethinkingJulia samples will always be stored
# in an MCMCChains.Chains object. 

chn = MCMCChains.Chains(reshape(samples, N, 1, 1), ["toss"]);

# Describe the chain

MCMCChains.describe(chn)

# ### snippet 3.6

v = 0.0
for i in 1:length(p_grid)
  global v
  if p_grid[i] < 0.5
    v += posterior[i]
  end
end
v

# ### snippet 3.7

mapreduce(p -> p < 0.5 ? 1 : 0, +, samples) / N   |> display

# ### snippet 3.8

mapreduce(p -> (p > 0.5 && p < 0.75) ? 1 : 0, +, samples) / N   |> display

# ### snippet 3.9

quantile(samples, 0.8) |> display

# ### snippet 3.10

quantile(samples, [0.1, 0.9]) |> display

# End of `03/clip-06-10.jl`