# Load Julia packages (libraries) needed

using StatisticalRethinking, Optim

ProjDir = rel_path("..", "scripts", "02")


# ### snippet 2.6

# Grid of 1001 steps

p_grid = range(0, step=0.001, stop=1);

# all priors = 1.0

prior = ones(length(p_grid));

# Binomial pdf

likelihood = [pdf(Binomial(9, p), 6) for p in p_grid];

# As Uniform prior has been used, unstandardized posterior is equal to likelihood

posterior = likelihood .* prior;

# Scale posterior such that they become probabilities

posterior = posterior / sum(posterior);

# ### snippet 3.3

# Sample using the computed posterior values as weights

N = 10000
samples = sample(p_grid, Weights(posterior), N);

# In StatisticalRethinkingJulia samples will always be stored
# in an MCMCChains.Chains object. 

chn = MCMCChains.Chains(reshape(samples, N, 1, 1), ["toss"]);

# Describe the chain

MCMCChains.describe(chn)

# Plot the chain

plot(chn)
savefig("$ProjDir/fig-06-07.1.pdf")

# Compute the MAP (maximum_a_posteriori) estimate

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

# Show optimization results

opt

# Fit quadratic approcimation

quapfit = [qmap[1], std(samples, mean=qmap[1])]

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
p[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab="Draws")

# analytical calculation

w = 6
n = 9
x = 0:0.01:1
p[2] = plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
density!(p[2], samples, lab="Sample density")

# quadratic approximation

p[3] = plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
plot!( p[3], x, pdf.(Normal( quapfit[1], quapfit[2] ) , x ), lab="Quap approximation")

# ### snippet 2.7

w = 6; n = 9; x = 0:0.01:1
p[4] = plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
plot!(p[4], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")
plot(p..., layout=(2, 2))
savefig("$ProjDir/fig-06-07.2.pdf")

# End of `02/clip-06-07.jl`
