# Load Julia packages (libraries) needed

using StatisticalRethinking
using StatsFuns, Optim, Turing, Flux.Tracker
gr(size=(600,300)) #src

Turing.setadbackend(:reverse_diff)

# ### snippet 2.8t

# Define the data

k = 6; n = 9;

# Define the model

@model globe_toss(n, k) = begin
  theta ~ Beta(1, 1) # prior
  k ~ Binomial(n, theta) # model
  return k, theta
end;

# Compute the "maximum_a_posteriori" value

# Set search bounds

lb = [0.0]; ub = [1.0];

# Create (compile) the model 

model = globe_toss(n, k);

# Compute the maximum_a_posteriori

result = maximum_a_posteriori(model, lb, ub)
println("\nMaximum_a_posteriori = $(result.minimizer)\n") #src

# Use Turing mcmc

chn = sample(model, NUTS(1000, 0.65));

# Look at the generated draws (in chn)

println() #src
describe(chn[:theta])

# Compute at hpd region
println()#src
bnds = MCMCChain.hpd(chn[:theta], alpha=0.05);

# analytical calculation

w = 6
n = 9
x = 0:0.01:1
plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab="Conjugate solution")

# quadratic approximation

plot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")

# Turing Chain &  89%hpd region boundaries

density!(chn[:theta], lab="Turing chain")
vline!([bnds[1]], line=:dash, lab="hpd lower bound")
vline!([bnds[2]], line=:dash, lab="hpd upper bound")

# Show hpd region

println("hpd bounds = $bnds\n")
