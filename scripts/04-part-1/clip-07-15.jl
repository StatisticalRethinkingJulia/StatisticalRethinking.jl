# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, StanSample, CSV
using Distributions, DataFrames
using MCMCChains,StatsPlots

ProjDir = @__DIR__

# ### snippet 4.7

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')

# ### snippet 4.8

# Show a summary of the  DataFrame

printl()
Particles(df) |> display

# ### snippet 4.9

# Show some statistics

describe(df, :all)

# ### snippet 4.10

df.height

# ### snippet 4.11

# Use only adults

df = filter(row -> row[:age] >= 18, df);

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
savefig("$ProjDir/Fig-07-15.1.png")

# Store in a DataFrame

df2 = DataFrame(
	mu_20 = sample_mu_20,
	mu_100 = sample_mu_100,
	sigma=sample_sigma,
	prior_height_20=prior_height_20,
	prior_height_100=prior_height_100);

describe(df2, :all)


# On to Stan.

# Recall our model:

m4_1 = "
  # Priors
  μ ~ Normal(178,20)
  σ ~ Uniform(0, 50)

  # Likelihood of data
  height ~ Normal(μ, σ)
";

heightsmodel = "
// Inferring the mean and std
data {
  int N;
  real<lower=0> h[N];
}
parameters {
  real<lower=0> sigma;
  real<lower=0,upper=250> mu;
}
model {
  // Priors for mu and sigma
  mu ~ normal(178, 20);
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}
";

# Create a StanSample SampleModel:

sm = SampleModel("heights", heightsmodel);

# Package the data:

heightsdata = Dict("N" => length(df[:, :height]), "h" => df[:, :height]);

# Run Stan's cmdstan:

rc = stan_sample(sm, data=heightsdata);

# Check if sampling went ok:

if success(rc)
 	
 	# Read in the samples and show a chain summary
 
 	chn = read_samples(sm; output_format=:mcmcchains)
 	show(chn)

 	# Plot the sampling

 	plot(chn)
 	savefig("$ProjDir/Fig-07-15.2.png")

	# Plot the density of posterior draws

	density(chn)
	savefig("$ProjDir/Fig-07-15.3.png")

end

# End of `clip-07-15.jl`
