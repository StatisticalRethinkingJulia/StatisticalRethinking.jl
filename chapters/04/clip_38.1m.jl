using StatisticalRethinking, Distributed, JLD, LinearAlgebra
using Mamba

# Data

howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);

# Input data for Mamba

data = Dict(
  :x => convert(Array{Float64,1}, df2[:weight]),
  :y => convert(Array{Float64,1}, df2[:height])
)

# Log-transformed Posterior(b0, b1, log(s2)) + Constant and Gradient Vector

logfgrad = function(x::DenseVector)
  b0 = x[1]
  b1 = x[2]
  logs2 = x[3]
  r = data[:y] .- b0 .- b1 .* data[:x]
  logf = (-0.5 * length(data[:y]) - 0.001) * logs2 -
           (0.5 * dot(r, r) + 0.001) / exp(logs2) -
           0.5 * b0^2 / 1000 - 0.5 * b1^2 / 1000
  grad = [
    sum(r) / exp(logs2) - b0 / 1000,
    sum(data[:x] .* r) / exp(logs2) - b1 / 1000,
    -0.5 * length(data[:y]) - 0.001 + (0.5 * dot(r, r) + 0.001) / exp(logs2)
  ]
  logf, grad
end

## MCMC Simulation with No-U-Turn Sampling

n = 5000
burnin = 1000
sim = Mamba.Chains(n, 3, start = (burnin + 1), names = ["b0", "b1", "s2"])
theta = NUTSVariate([0.0, 0.0, 0.0], logfgrad)
for i in 1:n
  sample!(theta, adapt = (i <= burnin))
  if i > burnin
    sim[i, :, 1] = [theta[1:2]; exp(theta[3])]
  end
end

# Summarize draws

describe(sim)