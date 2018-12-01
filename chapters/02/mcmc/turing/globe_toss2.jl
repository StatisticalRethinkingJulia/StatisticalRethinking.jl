using StatisticalRethinking

@model globe_toss2(n, k) = begin
  theta ~ Beta(1, 1) # prior
  for i in 1:length(k)
    k[i] ~ Binomial(n[i], theta) # model
  end
  return k, theta
end

N2 = 5
d = Binomial(9, 0.66)
n2 = Int.(9 * ones(Int, N2))
k2 = rand(d, N2)
println("\nN = $N2, k = $k2\n")

model2 = globe_toss2(n2, k2)

chn = sample(model2, NUTS(1000, 0.5))
describe(chn[:theta])
println() #src

MCMCChain.hpd(chn[:theta], alpha=0.945) |> display
println() #src

w = 6
n = 9
x = 0:0.01:1
plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab="Conjugate solution")

# quadratic approximation

plot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")

# Turing Chain

density!(chn[:theta], lab="Turing chain")

# Set search bounds
lb = [0.0]; ub = [1.0]

result = maximum_a_posteriori(model2, lb, ub)
