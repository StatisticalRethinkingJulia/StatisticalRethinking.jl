# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, Turing
gr(size=(600,300))

# ### snippet 4.7

howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1)

# Use only adults

df2 = filter(row -> row[:age] >= 18, df)

# Plot height density

density(df2[:height])

#=
@model heights(h) = begin
  μ ~ Uniform(100, 200) # prior on μ
  σ ~ InverseGamma(0.001, 0.001) # prior on σ
  h ~ Normal(μ, σ) # model
  return h
end

# Create (compile) the model 

model = heights(df2[:height])

# Use Turing mcmc

chn = sample(model, Turing.NUTS(1000, 0.65))

# Look at the generated draws (in chn)

println()
describe(chn)
println()
MCMCChain.hpd(chn[:h], alpha=0.945) |> display
println()
=#
