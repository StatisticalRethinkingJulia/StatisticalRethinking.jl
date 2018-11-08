# # Chapter 4 snippets

# ### snippet 4.0

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
gr(size=(600,300))

ProjDir = @__DIR__ #src
cd(ProjDir) #src

# snippet 4.1

noofsteps = 33;
noofwalks = 50;
pos = Array{Float64, 2}(rand(Uniform(-1, 1), noofsteps, noofwalks));
pos[1, :] = zeros(noofwalks);
csum = cumsum(pos, dims=1);

p1 = plot(csum, leg=false, title="Random walks ($(noofwalks))")
p2 = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
plt = 1
for step in [5, 9, 17, 33]
  global plt
  fit = fit_mle(Normal, csum[step, :])
  x = (fit.μ-4*fit.σ):0.01:(fit.μ+4*fit.σ)
  p2[plt] = density(csum[step, :], legend=false, title="$(step-1) steps")
  plot!( p2[plt], x, pdf.(Normal( fit.μ , fit.σ ) , x ))
  plt += 1
end
p3 = plot(p2..., layout=(1,4))
plot(p1, p3, layout=(2,1))
savefig("fig4_2.pdf")
# snippet 4.6

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
savefig("s4_6.pdf")

# snippet 4.7

howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1)
