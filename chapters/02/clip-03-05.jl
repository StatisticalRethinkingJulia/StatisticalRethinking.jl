using StatisticalRethinking
gr(size=(600,600));

N = 20
p_grid = range( 0 , stop=1 , length=N )

prior = ones( 20 );

likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]
likelihood[1:5]

unstd_posterior = likelihood .* prior;

posterior = unstd_posterior  ./ sum(unstd_posterior);

p1 = plot( p_grid , posterior ,
    xlab="probability of water" , ylab="posterior probability",
    lab = "interpolated", title="20 points" )
p2 = scatter!( p1, p_grid , posterior, lab="computed" )

prior1 = [p < 0.5 ? 0 : 1 for p in p_grid]
prior2 = [exp( -5*abs( p - 0.5 ) ) for p in p_grid]

p3 = plot(p_grid, prior1,
  xlab="probability of water" , ylab="posterior probability",
  lab = "semi_uniform", title="Other priors" )
scatter!(p3, p_grid, prior1, lab = "semi_uniform grid point")
plot!(p3, p_grid, prior2,  lab = "double_exponential" )
scatter!(p3, p_grid, prior2,  lab = "double_exponential grid point" )

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

