# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, StanSample

ProjDir = @__DIR__

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = @__DIR__
cd(ProjDir)

# ### snippet 4.7

df = CSV.read(joinpath(ProjDir, "..", "..", "data", "Howell1.csv"), delim=';')

# ### snippet 4.8

# Show first 5 rows of DataFrame df

first(df, 5)

# ### snippet 4.9

# Show some statistics

describe(df, :all)

# ### snippet 4.10

df.height

# ### snippet 4.11

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);

# Our model:

m4_1 = "
  height ~ Normal(μ, σ) # likelihood
  μ ~ Normal(178,20) # prior
  σ ~ Uniform(0, 50) # prior
";

# Plot the prior densities.

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)

# ### snippet 4.12

# μ prior

d1 = Normal(178, 20)
p[1] = plot(100:250, [pdf(d1, μ) for μ in 100:250],
	xlab="mu",
	ylab="density",
	lab="Prior on mu")

# ### snippet 4.13

# Show σ  prior

d2 = Uniform(0, 50)
p[2] = plot(-5:0.1:55, [pdf(d2, σ) for σ in 0-5:0.1:55],
	xlab="sigma",
	ylab="density",
	lab="Prior on sigma")

# ### snippet 4.14

sample_mu_20 = rand(d1, 10000)
sample_sigma = rand(d2, 10000)

d3 = Normal(178, 100)
sample_mu_100 = rand(d3, 10000)

prior_height_20 = [rand(Normal(sample_mu_20[i], sample_sigma[i]), 1)[1] for i in 1:10000]
p[3] = density(prior_height_20,
	xlab="height",
	ylab="density",
	lab="Prior predictive height")

prior_height_100 = [rand(Normal(sample_mu_100[i], sample_sigma[i]), 1)[1] for i in 1:10000]
p[4] = density(prior_height_100,
	xlab="height",
	ylab="density",
	lab="Prior predictive mu")

plot(p..., layout=(2,2))
savefig("$ProjDir/Fig-07-15s.1.png")

# Store in a DataFrame

df2 = DataFrame(
	mu_20 = sample_mu_20,
	mu_100 = sample_mu_100,
	sigma=sample_sigma,
	prior_height_20=prior_height_20,
	prior_height_100=prior_height_100);

describe(df2, :all)

# Use data from m4.1s to show cmdstan results

# Check if the m4.1s.jls file is present. If not, run the model.

!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))

# Describe the draws

MCMCChains.describe(chn)

# Plot the density of posterior draws

density(chn)
savefig("$ProjDir/Fig-07-15s.2.png")

# End of `clip-07-14s.jl`
