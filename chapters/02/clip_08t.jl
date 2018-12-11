# Load Julia packages (libraries) needed

using StatisticalRethinking
#using StatsFuns, Optim, Turing, Flux.Tracker
gr(size=(600,300)) #src

# ### snippet 2.6t

# Define the data

k = 6
n = 9

# Define the model

@model globe_toss(n, k) = begin
  theta ~ Beta(1, 1) # prior
  k ~ Binomial(n, theta) # model
  return k, theta
end

# Compute the "maximum_a_posteriori" value

# Set search bounds

lb = [0.0]
ub = [1.0]

# Create (compile) the model 

model = globe_toss(n, k)

# Compute the maximum_a_posteriori

result = maximum_a_posteriori(model, lb, ub)
println("\nMaximum_a_posteriori = $(result.minimizer)\n") #src

# Use Turing mcmc

chn = sample(model, NUTS(1000, 0.65))

# Look at the generated draws (in chn)

println()
describe(chn[:theta])
println()
MCMCChain.hpd(chn[:theta], alpha=0.945) |> display
println()

p_grid = range(0, step=0.001, stop=1)
prior = ones(length(p_grid))
likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
posterior = likelihood .* prior
posterior = posterior / sum(posterior)
samples = sample(p_grid, Weights(posterior), length(p_grid))

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)
p[1] = plot(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab="Draws")

# Analytical calculation

w = 6
n = 9
x = 0:0.01:1
p[2] = density(samples, ylim=(0.0, 5.0), lab="Sample density")
plot!(p[2], x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")

# Quadratic approximation

plot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")

# Show plots

plot(p..., layout=(1, 2))

# ### snippet 2.7

# analytical calculation

w = 6
n = 9
x = 0:0.01:1
plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab="Conjugate solution")

# quadratic approximation

plot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")

# Turing Chain

density!(chn[:theta], lab="Turing chain")

# ### snippet 2.8 

# The example is in `stan_globe_toss.jl`. It will be in `clips_02_08_08s.jl`.
