using StatisticalRethinking

@model globe_toss(n, k) = begin
  theta ~ Beta(1, 1) # prior
  k ~ Binomial(n, theta) # model
  return k, theta
end

# data
k = 6; n = 9

# Set search bounds
lb = [0.0]; ub = [1.0]

model = globe_toss(n, k)

result = maximum_a_posteriori(model, lb, ub)
display(result)
display(result.minimizer)

chn = sample(model, NUTS(1000, 0.65))
describe(chn[:theta])
MCMCChain.hpd(chn[:theta], alpha=0.945) |> display
