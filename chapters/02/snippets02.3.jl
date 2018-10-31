using Distributions, RDatasets, DataFrames, Plots

ways  = [0  , 3 , 8 , 9 , 0 ];
ways/sum(ways)

d = Binomial(9, 0.5)
pdf(d, 6)

p_grid = range( 0 , stop=1 , length=20 )

prior = ones( 20 )

likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]

unstd_posterior = likelihood .* prior

posterior = unstd_posterior  ./ sum(unstd_posterior)

p1 = plot( p_grid , posterior ,
    xlab="probability of water" , ylab="posterior probability",
    lab = "interpolated", title="20 points" )
p2 = scatter!( p1, p_grid , posterior, lab="computed" )

savefig("Chapter02snippet24.pdf")

prior1 = [p < 0.5 ? 0 : 1 for p in p_grid]
prior2 = [exp( -5*abs( p - 0.5 ) ) for p in p_grid]

p3 = plot(p_grid, prior1,
  xlab="probability of water" , ylab="posterior probability",
  lab = "semi_uniform", title="Other priors" )
p4 = plot!(p3, p_grid, prior2,  lab = "double_exponential" )

savefig("Chapter02snippet25.pdf")

#=

library(rethinking)
globe.qa <- map(
    alist(
        w ~ dbinom(9,p) ,  # binomial likelihood
        p ~ dunif(0,1)     # uniform prior
    ) ,
    data=list(w=6) )

precis( globe.qa )

w <- 6
n <- 9
curve( dbeta( x , w+1 , n-w+1 ) , from=0 , to=1 )

curve( dnorm( x , 0.67 , 0.16 ) , lty=2 , add=TRUE )

=#

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

