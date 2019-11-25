# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, CmdStan
#gr(size=(600,600));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")

# ### snippet 4.7

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# ### snippet 4.8

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);

# Show first 5 rows of DataFrame df

first(df2, 5)

# ### Snippet 4.14

# Generate approximate probabilities

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

# ### Snippet 4.15

# Sample post

samples = post[sample(1:size(post, 1), Weights(post[:prob]), 10000, replace=true), :]

# ### Snippet 4.19

# Density of mu

density(samples[:mu])
savefig("$ProjDir/fig-14-20.1.pdf")

# Density of sigma

density(samples[:sigma])
savefig("$ProjDir/fig-14-20.2.pdf")

# ### Snippet 4.20

# Hdp mu

#hpd(samples[:mu])

# Hdp sigma

#hpd(samples[:sigma])

# End of `clip-14-20.jl`
