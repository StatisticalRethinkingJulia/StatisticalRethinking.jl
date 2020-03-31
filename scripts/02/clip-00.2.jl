# Load Julia packages (libraries) needed

using StatisticalRethinking
using StatsPlots

ProjDir = @__DIR__

# Define a grid

N = 201
p_grid = range( 0 , stop=1 , length=N )

# Define thhree priors.

prior = []
append!(prior, [pdf.(Uniform(0, 1), p_grid)])
append!(prior, [[p < 0.5 ? 0 : 1 for p in p_grid]])
append!(prior, [[exp( -5*abs( p - 0.5 ) ) for p in p_grid]])

likelihood = [pdf.(Binomial(9, p), 6) for p in p_grid]

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 9)

for i in 1:3
  j = (i-1)*3 + 1
  p[j] = plot(p_grid, prior[i], leg=false, ylims=(0, 1), title="Prior")
  p[j+1] = plot(p_grid, likelihood, leg=false, title="Likelihood")
  p[j+2] = plot(p_grid, prior[i].*likelihood, leg=false, title="Posterior")
end

plot(p..., layout=(3, 3))
savefig(ProjDir*"/Fig-00.2.png")

# End of `02/clip-00.2.jl`
