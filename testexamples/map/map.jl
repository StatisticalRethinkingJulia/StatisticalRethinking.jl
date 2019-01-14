using Distributions, Optim

ll(p) = -pdf(Binomial(9, p[1]), 6)

optimize(x->ll(first(x)), 0.0, 1.0)

#=
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

# Density of sigma

density(samples[:sigma])
=#
