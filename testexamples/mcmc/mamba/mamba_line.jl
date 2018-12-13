using Distributed, JLD
@everywhere using Mamba

## Data
line = Dict{Symbol, Any}()

line[:x] = collect(0:1:10)
line[:y] = line[:x] + rand(Normal(0.0, 0.1), length(line[:x]))
line[:xmat] = [ones(length(line[:x])) line[:x]]

## Model Specification
model = Model(
  y = Stochastic(1,
    (xmat, beta, s2) -> MvNormal(xmat * beta, sqrt(s2)),
    false
  ),
  beta = Stochastic(1, () -> MvNormal(2, sqrt(100))),
  s2 = Stochastic(() -> InverseGamma(0.01, 0.01))
)

## Initial Values
inits = [
  Dict{Symbol, Any}(
    :y => line[:y],
    :beta => rand(Normal(0, 1), 2),
    :s2 => rand(Gamma(1, 1))
  )
  for i in 1:3
]

## Tuning Parameters
scale1 = [0.5, 0.25]
summary1 = identity
eps1 = 0.5

scale2 = 0.5
summary2 = x -> [mean(x); sqrt(var(x))]
eps2 = 0.1

## User-Defined Sampling Scheme
scheme = [
  ABC(:beta, scale1, summary1, eps1, kernel=Normal, maxdraw=100, nsim=3),
  ABC(:s2,   scale2, summary2, eps2, kernel=Epanechnikov, maxdraw=100, nsim=3)
]
setsamplers!(model, scheme)

## MCMC Simulation with Approximate Bayesian Computation
sim = mcmc(model, line, inits, 10000, burnin=1000, chains=3)
describe(sim)

ProjDir = @__DIR__
cd(ProjDir) do
  
  save("sim.jld", 
    "range", sim.range, 
    "values", sim.value,
    "names", sim.names, 
    "chains", sim.chains)
    
end

d = load(joinpath(ProjDir, "sim.jld"))

