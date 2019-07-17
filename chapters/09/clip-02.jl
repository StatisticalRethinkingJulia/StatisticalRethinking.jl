using StatisticalRethinking, LinearAlgebra
gr(size=(300, 300))

ProjDir = @__DIR__

T = 1000

rad_dist(x) = sqrt(sum(x .^ 2))

p = density(xlabel="Radial distance from mode", ylabel="Density")

for d in [1, 10, 100, 1000]
  m = MvNormal(zeros(d), Diagonal(ones(d)))
  y = rand(m, T)
  rd = [rad_dist( y[:, i] ) for i in 1:T]
  density!(p, rd, lab="d=$d")
end

plot(p)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

