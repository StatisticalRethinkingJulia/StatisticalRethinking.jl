# This scrpt shows clip-26-29 using Optim and a loglik function.

using StatisticalRethinking
using Optim

ProjDir = @__DIR__
cd(ProjDir)

# ### snippet 4.26

df = DataFrame(CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';'))
df2 = filter(row -> row[:age] >= 18, df);
@show first(df2, 5)

# ### snippet 4.27

# Our first model:

m4_1 = "
  μ ~ Normal(178,20) # prior
  σ ~ Uniform(0, 50) # prior
  height ~ Normal(μ, σ) # likelihood
"

# ### snippet 4.28

# Compute MAP

obs = df2[:, :height]

function loglik(x)
  ll = 0.0
  ll += log(pdf(Normal(178, 20), x[1]))
  ll += log(pdf(Uniform(0, 50), x[2]))
  ll += sum(log.(pdf.(Normal(x[1], x[2]), obs)))
  -ll
end

# ### snippet 4.29

# Start values

lower = [0.0, 0.0]
upper = [250.0, 50.0]
x0 = [170.0, 10.0]

inner_optimizer = GradientDescent()

@show res = optimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))

@show Optim.minimizer(res)
println()

# Our second model:

m4_2 = "
  μ ~ Normal(178, 0.1) # prior
  σ ~ Uniform(0, 50) # prior
  height ~ Normal(μ, σ) # likelihood
"

# ### snippet 4.29

# Compute MAP

obs = df2[:, :height]

function loglik2(x)
  ll = 0.0
  ll += log(pdf(Normal(178, 0.1), x[1]))
  ll += log(pdf(Uniform(0, 50), x[2]))
  ll += sum(log.(pdf.(Normal(x[1], x[2]), obs)))
  -ll
end

x0 = [178.0, 50.0] # Inital values can't be outside the the box.

inner_optimizer = GradientDescent()
@show optimize(loglik2, lower, upper, x0, Fminbox(inner_optimizer))

# Notice the increase of σ

# End of `clip-24-29.jl`
