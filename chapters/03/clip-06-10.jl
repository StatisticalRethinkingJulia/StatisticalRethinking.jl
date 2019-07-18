using StatisticalRethinking, Optim
gr(size=(600,600));

p_grid = range(0, step=0.001, stop=1)
prior = ones(length(p_grid))
likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
posterior = likelihood .* prior
posterior = posterior / sum(posterior)

N = 10000
samples = sample(p_grid, Weights(posterior), N);

chn = MCMCChains.Chains(reshape(samples, N, 1, 1), ["toss"]);

describe(chn)

v = 0.0
for i in 1:length(p_grid)
  global v
  if p_grid[i] < 0.5
    v += posterior[i]
  end
end
v

mapreduce(p -> p < 0.5 ? 1 : 0, +, samples) / N   |> display

mapreduce(p -> (p > 0.5 && p < 0.75) ? 1 : 0, +, samples) / N   |> display

quantile(samples, 0.8)

quantile(samples, [0.1, 0.9])

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

