# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, CmdStan

ProjDir = rel_path("..", "scripts", "04")

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

#-

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

# ### Snippet 4.21

# Sample 20 random heights

n = size(df2, 1)
selected_ind = sample(1:n, 20, replace=false);
df3 = df2[selected_ind, :];

# ### Snippet 4.22

# Generate approximate probabilities

struct Post
  mu::Float64
  sigma::Float64
  ll:: Float64
  prod::Float64
  prob::Float64
end

mu_list = repeat(range(140, 170, length=200), 200);
sigma_list = repeat(range(4, 20, length=200), inner=200);

ll = zeros(40000);
for i in 1:40000
    d1 = Normal(mu_list[i], sigma_list[i])
    ll[i] = sum(log.(pdf.(d1, df3[:height])))
end
  
d2 = Normal(178.0, 20.0)
d3 = Uniform(0, 50)
prod = ll + log.(pdf.(d2, mu_list)) + log.(pdf.(d3, sigma_list))
prob = exp.(prod .- maximum(prod))
post = DataFrame(mu=mu_list, sigma=sigma_list, ll=ll, prod=prod, prob=prob)
first(post, 10)

# Sample post

samples = post[sample(1:size(post, 1), Weights(post[:prob]), 10000, replace=true), :]

# ### Snippet 4.23

# Density of sigma

density(samples[:sigma])
savefig("$ProjDir/fig-21-21.pdf")

# End of `clip-21-23.jl`
