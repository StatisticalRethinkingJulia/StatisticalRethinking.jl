using Turing, MCMCChain, Flux.Tracker

data = (n = 9, k = 6)
@model globe_toss(n, k) = begin
  #prior
  theta ~ Beta(1, 1)
  #model
  k ~ Binomial(n, theta)
  #return theta
end

chn = sample(globe_toss(data.n, data.k), HMC(2000, 0.75, 5))

println()
describe(chn[:theta])
println()
MCMCChain.hpd(chn, alpha=0.945) |> display
println()
