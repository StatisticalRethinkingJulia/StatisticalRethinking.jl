using Turing

@model gdemo() = begin
  #prior
  theta ~ Uniform(0, 1)
  #model
  k ~ Binomial(9, theta)
  return k
end

chn = sample(gdemo(), HMC(2000, 0.75, 5))
describe(chn)
