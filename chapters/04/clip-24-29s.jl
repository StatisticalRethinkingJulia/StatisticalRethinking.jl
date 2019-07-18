using StatisticalRethinking, Optim
gr(size=(600,600));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

m4_1 = "
  height ~ Normal(μ, σ) # likelihood
  μ ~ Normal(178,20) # prior
  σ ~ Uniform(0, 50) # prior
"

obs = df2[:height]

function loglik(x)
  ll = 0.0
  ll += log(pdf(Normal(178, 20), x[1]))
  ll += log(pdf(Uniform(0, 50), x[2]))
  ll += sum(log.(pdf.(Normal(x[1], x[2]), obs)))
  -ll
end

x0 = [ 178, 10.0]
lower = [0.0, 0.0]
upper = [250.0, 50.0]

inner_optimizer = GradientDescent()

optimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))

m4_2 = "
  height ~ Normal(μ, σ) # likelihood
  μ ~ Normal(178, 0.1) # prior
  σ ~ Uniform(0, 50) # prior
"

obs = df2[:height]

function loglik2(x)
  ll = 0.0
  ll += log(pdf(Normal(178, 0.1), x[1]))
  ll += log(pdf(Uniform(0, 50), x[2]))
  ll += sum(log.(pdf.(Normal(x[1], x[2]), obs)))
  -ll
end

optimize(loglik2, lower, upper, x0, Fminbox(inner_optimizer))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

