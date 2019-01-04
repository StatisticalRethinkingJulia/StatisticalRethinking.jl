# Load Julia packages (libraries) needed

using StatisticalRethinking
gr(size=(600,300));

# ### snippet 2.3

# Define a grid

N = 20
p_grid = range( 0 , stop=1 , length=N )

# Define the (uniform) prior

prior = ones( 20 );

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

p3 = plot(p_grid, prior1, 
  xlab="probability of water" , ylab="posterior probability",
  lab = "semi_uniform", title="Other priors" )
scatter!(p3, p_grid, prior1, lab = "semi_uniform grid point")
plot!(p3, p_grid, prior2,  lab = "double_exponential" )
scatter!(p3, p_grid, prior2,  lab = "double_exponential grid point" )

# End of `clip_03_05.jl`
