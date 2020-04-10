# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

df = DataFrame(CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';'))
df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

# ### Snippet 4.23

# Sample 20 random heights

n = size(df2, 1)
selected_ind = sample(1:n, 20, replace=false);
df3 = df2[selected_ind, :];

# ### Snippet 4.24

# Generate approximate probabilities

mu_list = repeat(range(150, 170, length=200), 200);
sigma_list = repeat(range(4, 20, length=200), inner=200);


function grid_prob(x, y, prior_x, prior_y, obs)

	# Create an x vs. y grid (vector of vectors), e.g.
	# 10000-element Array{Array{Float64,1},1}:
 	#	[150.0, 7.0]
 	#	[150.1010101010101, 7.0]
 	#	[150.2020202020202, 7.0]
 	#   ...

 	df = DataFrame()
	grid = reshape([ [x,y]  for x=x, y=y ], length(x)*length(y))

	# Define the priors

	d2 = Normal(178.0, 20.0)
	d3 = Uniform(0, 50)

	# Compute the log(likelihood * prior)

	the_prod = []
	for i in 1:length(grid)
	    d1 = Normal(grid[i][1], grid[i][2])
	    ll = sum(log.(pdf.(d1, obs)))
	    append!(df, DataFrame(mu=grid[i][1], sigma=grid[i][2],
	    	ll=ll))
		append!(the_prod, ll + log.(pdf.(prior_x, grid[i][1])) + 
			log.(pdf.(prior_y, grid[i][2])))
	end

	# Make it a probability

	df[!, :prob] = exp.(the_prod .- maximum(the_prod))
	df
end

mu_list = range(150, 160, length=100)
sigma_list = range(7, 9, length=100)
prior_mu = Normal(178.0, 20.0)
prior_sigma = Uniform(0, 50)

post_df = grid_prob(mu_list, sigma_list, prior_mu, prior_sigma,
	df3[:, :height])

@show first(post_df, 10)

# Sample post

samples = post_df[sample(1:size(post_df, 1), Weights(post_df[:, :prob]), 
	10000, replace=true), :]

# ### Snippet 4.25

# Density of sigma

density(samples[:, :sigma],
	xlab="sigma",
	ylab="density",
	lab="posterior sigma (only 20 obs)"
)
savefig("$ProjDir/Fig-23-25.png")

# End of `04/clip-23-25.jl`
