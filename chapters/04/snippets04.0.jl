# # Chapter 4 snippets

# ### snippet 4.0

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
gr(size=(600,300))

ProjDir = @__DIR__ #src
cd(ProjDir) #src

# snippet 4.1

# Grid of 1001 steps
p_grid = range(0, step=0.001, stop=1)

# all priors = 1.0
prior = ones(length(p_grid))

# Binomial pdf
likelihood = [pdf(Binomial(9, p), 6) for p in p_grid]

# As Uniform priar has been used, unstandardized posterior is equal to likelihood
posterior = likelihood .* prior

# Scale posterior such that they become probabilities
posterior = posterior / sum(posterior)

# Sample using the computed posterior values as weights
# In this example we keep the number of samples equal to the length of p_grid,
# but that is not required.
samples = sample(p_grid, Weights(posterior), length(p_grid))

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)

p[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab="Draws")

# analytical calculation
w = 6
n = 9
x = 0:0.01:1
p[2] = density(samples, ylim=(0.0, 5.0), lab="Sample density")
p[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
# quadratic approximation
plot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")
plot(p..., layout=(1, 2))
savefig("s4_1.pdf")

# snippet 4.7

howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1)
