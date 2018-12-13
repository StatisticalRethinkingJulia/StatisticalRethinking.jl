using Mamba
 
## Model Specification

model = Model(

  x = Stochastic(1,
    mu -> Normal(mu, 2.0),
    false
  ),

  mu = Stochastic(
    () -> Normal(0.0, 1000.0),
    true
  )

)

## Data
data = Dict{Symbol, Any}(
  :x => randn(30) .* 2 .+ 13
)

## Initial Values
inits = [
  Dict{Symbol, Any}(
    :x => data[:x],
    :mu => randn()*1
  )
]

## Sampling Scheme Assignment
scheme1 = NUTS([:mu])
setsamplers!(model, [scheme1])

sim1 = mcmc(model, data, inits, 10000, burnin=250, thin=2, chains=1);
describe(sim1)
