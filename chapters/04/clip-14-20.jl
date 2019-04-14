using StatisticalRethinking, CmdStan
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df);

first(df2, 5)

struct Post
  mu::Float64
  sigma::Float64
  ll:: Float64
  prod::Float64
  prob::Float64
end

mu_list = repeat(range(140, 160, length=200), 200);
sigma_list = repeat(range(4, 9, length=200), inner=200);

ll = zeros(40000);
for i in 1:40000
    d1 = Normal(mu_list[i], sigma_list[i])
    ll[i] = sum(log.(pdf.(d1, df2[:height])))
end

d2 = Normal(178.0, 20.0)
d3 = Uniform(0, 50)
prod = ll + log.(pdf.(d2, mu_list)) + log.(pdf.(d3, sigma_list))
prob = exp.(prod .- maximum(prod))
post = DataFrame(mu=mu_list, sigma=sigma_list, ll=ll, prod=prod, prob=prob)
first(post, 10)

samples = post[sample(1:size(post, 1), Weights(post[:prob]), 10000, replace=true), :]

density(samples[:mu])

density(samples[:sigma])

#hpd(samples[:mu])

#hpd(samples[:sigma])

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

