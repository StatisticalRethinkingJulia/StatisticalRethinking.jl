# ### `09/clip-02.jl`

# ### Snippet 9.2

using StatisticalRethinking, LinearAlgebra

ProjDir = rel_path("..", "scripts", "09")

# Number of samples

T = 1000

# Compute radial distance

rad_dist(x) = sqrt(sum(x .^ 2))

# Plot densities

p = density(xlabel="Radial distance from mode", ylabel="Density")

for d in [1, 10, 100, 1000]
  m = MvNormal(zeros(d), Diagonal(ones(d)))
  y = rand(m, T)
  rd = [rad_dist( y[:, i] ) for i in 1:T] 
  density!(p, rd, lab="d=$d")
end

plot(p)
savefig("$ProjDir/fig-02.pdf")


# End of `09/clip-02.jl 