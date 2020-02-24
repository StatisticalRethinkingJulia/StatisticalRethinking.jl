# Execute this script after `scripts/03/intro_stan/intro-part-1.jl`
# `scripts/03/intro_stan/intro-part-2.jl` and 
# `scripts/03/intro_stan/intro-part-3.jl` (in that order)

using StatisticalRethinking, Optim

# This scripts shows a number of different ways to estimate
# a quadratic approximation.

# Compare with Stan, MLE & MAP

# StanSample mean and sd:

println("\nMean and std estimates, using all draws in 4 chains:\n")
@show p = Particles(dfs[:, :theta])
display([mean(p), std(p)])

# Stan_optimize mean and std (coputed in intro_part_3:

println("\nstan_optimize() estimates of mean and std:\n")
mu_stan_optimize = mean(optim_stan["theta"])
sigma_stan_optimize = std(dfs[:, :theta], mean=mu_stan_optimize)
display([mu_stan_optimize, sigma_stan_optimize])

# MLE of mean and sd (computed in intro_part_2:

println("\nMLE estimates of mean and std using chains:\n")
display([mu_mle, sigma_mle])

# MAP estimate and associated sd:

println("\nMode of samples based estimates of mean, std:\n")

# Use mode of Stan samples, determine std using mode as mean

mu_mode = mode(dfs[:, :theta])
sigma_mode = std(dfs[:, :theta], mean=mu_mode)
display([mu_mode, sigma_mode])

# Use kernel density of Stan samples

println("\nQuap estimate the mean and std:\n")

# Determine theta value with highest density (MAP)

d = quap(dfs)
mu_quap = mean(d.theta)
sigma_quap = std(d.theta)
display([mu_quap, sigma_quap])

# Using optim

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
sigma_optim = std(dfs[:, :theta], mean=mu_optim)

display([mu_optim, sigma_optim])

# Show the hpd region

bnds_hpd = hpdi(dfs[:, :theta], alpha=0.055)

# Compute the quantiles for plotting using all 4 chains

bnds_quantile = quantile(dfs[:, :theta], [0.045, 0.945])

# Show hpd region

println("\nQuantiles for all 4 chains:\n")
println("$bnds_quantile\n")

# Chain hpd region boundaries

plot( x, pdf.(Normal( mu_mle , sigma_mle) , x ),
xlim=(0.5, 0.8), lab="MLE approximation",
legend=:bottomleft, line=:dash)

plot!( x, pdf.(Normal( mean(p), std(p)), x ),
lab="Particle approximation", line=:dash)

plot!( x, pdf.(Normal( mu_quap, sigma_quap), x ),
lab="quap approximation")

density!(dfs[:, :theta], lab="StanSample chain")

vline!([bnds_hpd[1]], line=:dash, lab="hpd lower bound")
vline!([bnds_hpd[2]], line=:dash, lab="hpd upper bound")
savefig(joinpath(@__DIR__, "Fig-part-4.png"))

# In this example usually most approximations are similar.
# Other examples are less clear. In particular with
# stan_optimize() I've seen rather unstable results.

# Given that in StatisticalRethinking.jl we have the
# actual Stan samples, quap() uses this to fit a Normal
# distribution with mean equal to the sample MAP.

# End of `intro/intro-part-4.jl`
