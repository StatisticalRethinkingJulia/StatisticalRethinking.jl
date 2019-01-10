using StatisticalRethinking, Mamba

## Data
line = Dict{Symbol, Any}()

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);
line[:x] = convert(Array{Float64,1}, df2[:weight]);
line[:y] = convert(Array{Float64,1}, df2[:height]);
line[:xmat] = convert(Array{Float64,2}, [ones(length(line[:x])) line[:x]])

# Model Specification

model = Model(
  y = Stochastic(1,
    (xmat, beta, s2) -> MvNormal(xmat * beta, sqrt(s2)),
    false
  ),
  beta = Stochastic(1, () -> MvNormal([178, 0], [sqrt(10000), sqrt(100)])),
  s2 = Stochastic(() -> Uniform(0, 50))
)

# Initial Values

inits = [
  Dict{Symbol, Any}(
    :y => line[:y],
    :beta => [rand(Normal(178, 100)), rand(Normal(0, 10))],
    :s2 => rand(Uniform(0, 50))
  )
  for i in 1:3
]

# Tuning Parameters

scale1 = [0.5, 0.25]
summary1 = identity
eps1 = 0.5

scale2 = 0.5
summary2 = x -> [mean(x); sqrt(var(x))]
eps2 = 0.1

# Define sampling scheme

scheme = [
  Mamba.NUTS([:beta]), 
  Mamba.Slice([:s2], 10)
]

setsamplers!(model, scheme)

# MCMC Simulation

chn = mcmc(model, line, inits, 10000, burnin=1000, chains=3)

# Show draws summary

describe(chn)

# Save, restore and check

serialize("m4.1m.jls", chn)
chn1 = deserialize("m4.1m.jls")
describe(chn1)

# End of `m4.1m.jl`
