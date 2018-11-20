using Turing, MCMCChain, Plots
gr(size=(300,300))

ProjDir = @__DIR__
cd(ProjDir) do

  y = [1.0, 3.0, 3.0, 3.0, 5.0]
  x = [1.0, 2.0, 3.0, 4.0, 5.0]

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
  
  chn = sample(line(y, x), NUTS(1000, 0.65))

  println()
  describe(chn)
  println()

  xi = 1.0:0.01:5.0
  yi = mean(chn[:alpha]) .+ mean(chn[:beta])*xi

  plot(x, y)
  plot!(xi, yi)
  savefig("turing_line.pdf")

end