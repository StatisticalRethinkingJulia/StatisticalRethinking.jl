using StatisticalRethinking, Optim
#gr(size=(600,600));

p_grid = range(0, step=0.001, stop=1);

prior = ones(length(p_grid));

likelihood = [pdf(Binomial(9, p), 6) for p in p_grid];

posterior = likelihood .* prior;

posterior = posterior / sum(posterior);

N = 10000
samples = sample(p_grid, Weights(posterior), N);

chn = MCMCChains.Chains(reshape(samples, N, 1, 1), ["toss"]);

describe(chn)

plot(chn)

x0 = [0.5]
lower = [0.0]
upper = [1.0]

function loglik(x)
  ll = 0.0
  ll += log.(pdf.(Beta(1, 1), x[1]))
  ll += sum(log.(pdf.(Binomial(9, x[1]), repeat([6], 1))))
  -ll
end

(qmap, opt) = quap(loglik, x0, lower, upper)

opt

quapfit = [qmap[1], std(samples, mean=qmap[1])]

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
p[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab="Draws")

w = 6
n = 9
x = 0:0.01:1
p[2] = plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
density!(p[2], samples, lab="Sample density")

p[3] = plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
plot!( p[3], x, pdf.(Normal( quapfit[1], quapfit[2] ) , x ), lab="Quap approximation")

w = 6; n = 9; x = 0:0.01:1
p[4] = plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
plot!(p[4], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")
plot(p..., layout=(2, 2))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

