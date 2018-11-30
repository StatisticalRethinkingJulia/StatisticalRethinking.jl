using StatisticalRethinking

@model globe_toss2(n, k) = begin
  theta ~ Beta(1, 1) # prior
  for i in 1:length(k)
    k[i] ~ Binomial(n[i], theta) # model
  end
  return k, theta
end

n2 = [9, 9, 9, 9, 9, 9]
k2 = [6, 5, 7, 6, 6, 6]

model2 = globe_toss2(n2, k2)

chn = sample(model2, NUTS(1000, 0.5))
describe(chn[:theta])

MCMCChain.hpd(chn[:theta], alpha=0.945) |> display

