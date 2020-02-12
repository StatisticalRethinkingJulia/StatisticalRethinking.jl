# # clip-11-16.jl

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, Distributions, Optim, StanSample, MCMCChains, StatsPlots, StatsBase

ProjDir = @__DIR__

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

MCMCChains.show(chn)

# ### snippet 3.13

MCMCChains.hpd(chn, alpha=0.5) |> display

# ### snippet 3.14

println("\nMode: $(mode(samples))\n")

# ### snippet 3.15

println("Mean: $(mean(samples))\n")

# ### snippet 3.16

println("Median: $(median(samples))\n")

density(samples, lab="density")
vline!(hpdi(samples, alpha=0.5), line=:dash, lab="hpdi")
vline!(quantile(samples, [0.25, 0.75]), line=:dash, lab="quantile (pi)")
savefig("$(ProjDir)/Fig-11-16.png")

# End of `03/clip-11-16.jl`

