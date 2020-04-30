# Load Julia packages

using StatisticalRethinking
gr(size=(600,500))

ProjDir = @__DIR__

N = 1000
df = DataFrame(
  :h0 => rand(Normal(10,2 ), N),
  :treatment => vcat(zeros(Int, Int(N/2)), ones(Int, Int(N/2))),
  :M => rand(Bernoulli(), N)
);

d(i) = Binomial(1, 0.5 - 0.4 * df[i, :treatment] + 0.4 * df[i, :M])
df[!, :fungus] = [rand(d(i), 1)[1] for i in 1:N]
df[!, :h1] = [df[i, :h0] + rand(Normal(5 + 3 * df[i, :M]), 1)[1] for i in 1:N]

# Execute m6.7 & m6.8
include("$(ProjDir)/m6.7.jl")
include("$(ProjDir)/m6.8.jl")

plotcoef([m6_7, m6_8], [:bt, :bf], "$(ProjDir)/Fig-20.png")
