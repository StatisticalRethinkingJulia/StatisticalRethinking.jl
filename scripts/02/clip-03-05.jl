# Load Julia packages (libraries) needed

using StatisticalRethinking

ProjDir = @__DIR__

# ### snippet 2.3

# Define a grid

N = 21
p_grid = range( 0 , stop=1 , length=N )

# Define the (uniform) prior

prior = ones( N );

# Compute likelihood at each value in grid

likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
likelihood[1:5]

# Compute product of likelihood and prior

unstd_posterior = likelihood .* prior;

# Standardize the posterior, so it sums to 1

posterior = unstd_posterior  ./ sum(unstd_posterior);

# ### snippet 2.4

p1 = plot( p_grid , posterior ,
    xlab="probability of water" , ylab="posterior probability",
    lab = "interpolated", title="20 points" )
p2 = scatter!( p1, p_grid , posterior, lab="computed" )

# ### snippet 2.5

prior1 = [p < 0.5 ? 0 : 1 for p in p_grid]
prior2 = [exp( -5*abs( p - 0.5 ) ) for p in p_grid]

p3 = plot( 
  xlab="probability of water" , ylab="posterior probability",
  lab = "semi_uniform", title="Other priors", legend=:bottomright )
scatter!(p3, p_grid, prior1, lab = "semi_uniform")
scatter!(p3, p_grid, prior2,  lab = "double_exponential" )
savefig("$ProjDir/Fig-03-05.pdf")

# End of `02/clip-03-05.jl`
