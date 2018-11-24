using Turing

@model gdemo() = begin
  #prior
  theta ~ Uniform(0, 1)
  #model
  k ~ Binomial(9, theta)
  return k
end

g = gdemo()
g() |> display
println()

chn = sample(gdemo(), SMC(1000))
describe(chn)
