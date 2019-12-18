# Execute this script after `scripts/03/intro_stan/intro-part-1.jl`
# `scripts/03/intro_stan/intro-part-2.jl` and 
# `scripts/03/intro_stan/intro-part-3.jl` (in that order)

# This scripts shows a number of different ways to estimate
# a quadratic approximation.

# Compare with Stan, MLE & MAP

# StanSample mean and sd:

println("\nMean and std estimates, using all draws in 4 chains:\n")
@show p = Particles(dfsa[:, :theta])
display([mean(p), std(p)])

# Stan_optimize mean and std (coputed in intro_part_3:

println("\nstan_optimize() estimates of mean and std:\n")
mu_stan_optimize = mean(optim_stan["theta"])
sigma_stan_optimize = std(dfsa[:, :theta], mean=mu_stan_optimize)
display([mu_stan_optimize, sigma_stan_optimize])

# MLE of mean and sd (computed in intro_part_2:

println("\nMLE estimates of mean and std using chains:\n")
display([mu_mle, sigma_mle])

# MAP estimate and associated sd:

println("\nMode of samples based estimates of mean, std:\n")

# Use mode of Stan samples, determine std using mode as mean

mu_map = mode(dfsa[:, :theta])
sigma_map = std(dfsa[:, :theta], mean=mu_map)
display([mu_map, sigma_map])

# Use kernel density of Stan samples

println("\nKernel density of samples to estimate the mean and std:\n")

# Determine theta value with highest density

dens = kde(dfsa[:, :theta])
mu_kde = collect(dens.x)[findmax(dens.density)[2]]
sigma_kde = std(dfsa[:, :theta], mean=mu_kde)
display([mu_kde, sigma_kde])

# Using optim

using Optim

x0 = [0.5]
lower = [0.2]
upper = [1.0]

inner_optimizer = GradientDescent()

function loglik(x)
  ll = 0.0
  ll += log.(pdf.(Beta(1, 1), x[1]))
  ll += sum(log.(pdf.(Binomial(9, x[1]), k)))
  -ll
end

res = optimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))

println("\nOptim estimates of mean and std:\n")
mu_optim = Optim.minimizer(res)[1]
sigma_optim = std(dfsa[:, :theta], mean=mu_optim)

display([mu_optim, sigma_optim])

# Show the hpd region

hpd(chn, alpha=0.055)

# Compute the hpd bounds for plotting using all 4 chains

bnds = quantile(dfsa[:, :theta], [0.045, 0.945])

# Show hpd region

println("\nHPD region for all 4 chains:\n")
println("$bnds\n")

# Chain hpd region boundaries

plot( x, pdf.(Normal( mu_mle , sigma_mle) , x ),
xlim=(0.5, 0.8), lab="MLE approximation",
legend=:bottomleft)

plot!( x, pdf.(Normal( mu_map, sigma_map), x ),
lab="Particle approximation", line=:dash)

plot!( x, pdf.(Normal( mean(p), std(p)), x ),
lab="Particle approximation", line=:dash)

density!(dfsa[:, :theta], lab="StanSample chain")

vline!([bnds[1]], line=:dash, lab="hpd lower bound")
vline!([bnds[2]], line=:dash, lab="hpd upper bound")
savefig("$ProjDir/Fig-part-4.png")

# In this example most approximations are similar.
# Other examples are less clear. In particular with
# stan_optimize() I've seen rather unstable results.

# End of `intro/intro_part_4.jl`
