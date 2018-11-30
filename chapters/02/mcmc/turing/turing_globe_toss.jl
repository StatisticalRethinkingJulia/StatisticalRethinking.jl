using Turing, MCMCChain, Flux.Tracker

k = 6
n = 9

@model globe_toss(n, k) = begin
  #prior
  theta ~ Beta(1, 1)
  #model
  k ~ Binomial(n, theta)
  return k, theta
end

chn = sample(globe_toss(n, k), SMC(1000))

println()
describe(chn[:theta])
println()
MCMCChain.hpd(chn, alpha=0.945) |> display
println()


# Set search bounds
lb = [0.0, 0.0]
ub = [9.0, 1.0]

model = globe_toss(n, k)

result = maximum_a_posteriori(model, lb, ub)
println()

result.minimizer
