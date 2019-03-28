using StatisticalRethinking, Optim
gr(size=(600,300));

p_grid = range(0, step=0.001, stop=1)
prior = ones(length(p_grid))
likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
posterior = likelihood .* prior
posterior = posterior / sum(posterior)
samples = sample(p_grid, Weights(posterior), length(p_grid));
samples[1:5]

N = 10000
samples = sample(p_grid, Weights(posterior), N);

chn = MCMCChains.Chains(reshape(samples, N, 1, 1), ["toss"]);

describe(chn)

plot(chn)

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)
p[1] = scatter(1:N, samples, markersize = 2, ylim=(0.0, 1.3), lab="Draws")

w = 6
n = 9
x = 0:0.01:1
p[2] = density(samples, ylim=(0.0, 5.0), lab="Sample density")
p[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")

plot(p..., layout=(1, 2))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

