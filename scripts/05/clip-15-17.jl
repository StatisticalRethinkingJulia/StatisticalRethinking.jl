# Load Julia packages (libraries) needed for clip

using StatisticalRethinking, GLM

ProjDir = @__DIR__

include(rel_path("..", "scripts", "05", "m5.3.jl"))

N = size(df, 1)

if success(rc)

  p = Particles(dfa3)

  plot(xlab="Observed divorce", ylab="Predicted divorce",
    title="Posterior predictive plot")
  v = zeros(size(df, 1), 4);
  for i in 1:N
    mu = mean(p.bM) * df[i, :Marriage_s] + mean(p.bA) * df[i, :MedianAgeMarriage_s]
    if i == 13
      annotate!([(df[i, :Divorce_s]-0.05, mu, Plots.text("ID", 6, :red, :right))])
    end
    if i == 39
      annotate!([(df[i, :Divorce_s]-0.05, mu, Plots.text("RI", 6, :red, :right))])
    end
    scatter!([df[i, :Divorce_s]], [mu], color=:red)
    local s = rand(Normal(mu, mean(p.sigma)), 1000)
    v[i, :] = [maximum(s), hpdi(s, alpha=0.11)[2], hpdi(s, alpha=0.11)[1], minimum(s)]
  end

  for i in 1:N
    plot!([df[i, :Divorce_s], df[i, :Divorce_s]], [v[i,1], v[i, 4]], color=:darkblue, leg=false)
    plot!([df[i, :Divorce_s], df[i, :Divorce_s]], [v[i,2], v[i, 3]], line=2, color=:black, leg=false)
  end

  df2 = DataFrame(
    :x => df[:, :Divorce_s],
    :y => [mean(p.bM) * df[i, :Marriage_s] + mean(p.bA) * df[i, :MedianAgeMarriage_s] for i in 1:N]
  )
  m1 = lm(@formula(y ~ x), df2)
  x = -2.1:0.1:2.2
  y = coef(m1)[2] * x
  plot!(x, x, line=(2, :dash), color=:black)
  plot!(x, y, line=:dash, color=:grey)
  
  savefig("$(ProjDir)/Fig-15-17a.png")

end


# The simulations as in R code 5.12 will be included in StructuralCausalModels.jl