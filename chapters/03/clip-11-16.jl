using StatisticalRethinking, Optim
gr(size=(600,600));

p_grid = range(0, step=0.001, stop=1)
prior = ones(length(p_grid))
likelihood = [pdf(Binomial(3, p), 3) for p in p_grid]
posterior = likelihood .* prior
posterior = posterior / sum(posterior)

N = 10000
samples = sample(p_grid, Weights(posterior), N);

chn = MCMCChains.Chains(reshape(samples, N, 1, 1), ["toss"]);

describe(chn)

MCMCChains.hpd(chn, alpha=0.5)

mode(samples)

mean(samples)

median(samples)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

