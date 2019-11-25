# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, Optim

ProjDir = rel_path("..", "scripts", "04")

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# ### snippet 4.24

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

# ### snippet 4.25

# Our first model:

m4_1 = "
  height ~ Normal(μ, σ) # likelihood
  μ ~ Normal(178,20) # prior
  σ ~ Uniform(0, 50) # prior
"

# ### snippet 4.26

# Compute MAP

obs = df2[:height]

function loglik(x)
  ll = 0.0
  ll += log(pdf(Normal(178, 20), x[1]))
  ll += log(pdf(Uniform(0, 50), x[2]))
  ll += sum(log.(pdf.(Normal(x[1], x[2]), obs)))
  -ll
end

# ### snippet 4.28

x0 = [ 178, 10.0]
lower = [0.0, 0.0]
upper = [250.0, 50.0]

# ### snippet 4.27

inner_optimizer = GradientDescent()

optimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))

# Our second model:

m4_2 = "
  height ~ Normal(μ, σ) # likelihood
  μ ~ Normal(178, 0.1) # prior
  σ ~ Uniform(0, 50) # prior
"

# ### snippet 4.29

# Compute MAP

obs = df2[:height]

function loglik2(x)
  ll = 0.0
  ll += log(pdf(Normal(178, 0.1), x[1]))
  ll += log(pdf(Uniform(0, 50), x[2]))
  ll += sum(log.(pdf.(Normal(x[1], x[2]), obs)))
  -ll
end

optimize(loglik2, lower, upper, x0, Fminbox(inner_optimizer))

# End of `clip-24-29s.jl`
