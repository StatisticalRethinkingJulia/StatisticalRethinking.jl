using Turing, MCMCChain, Plots
gr(size=(400, 400))

ProjDir = rel_path("..", "testexamples", "mcmc", "turing")
cd(ProjDir)

x = collect(0.0:1:10)
y = x + rand(Normal(0.0, 0.1), length(x))

@model line(y, x) = begin
    #priors
    alpha ~ Normal(0.0, 10.0)
    beta ~ Normal(0.0, 10.0)
    s ~ InverseGamma(0.001, 0.001)
    #model
    mu = alpha .+ beta*x
    for i in 1:length(y)
      y[i] ~ Normal(mu[i], s)
    end
end
  
chn = sample(line(y, x), Turing.HMC(1000, 0.01, 10))

println()
describe(chn)
println()

xi = 0.0:0.01:10.0
yi = mean(chn[:alpha]) .+ mean(chn[:beta])*xi

plot(x, y)
plot!(xi, yi)
savefig("line2.pdf")
