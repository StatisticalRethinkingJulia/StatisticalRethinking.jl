# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, CmdStan

ProjDir = rel_path("..", "scripts", "04")

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# ### snippet 4.7

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# ### snippet 4.8

# Show first 5 rows of DataFrame df

first(df, 5)

# ### snippet 4.9

# Show first 5 heigth values in df

first(df, 5)

# ### snippet 4.10

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);

# Our model:

m4_1 = "
  height ~ Normal(μ, σ) # likelihood
  μ ~ Normal(178,20) # prior
  σ ~ Uniform(0, 50) # prior
";

# Plot the densities.

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 3)
p[1] = density(df2[:height], xlim=(100,250), lab="All heights", xlab="height [cm]", ylab="density")

# ### snippet 4.10

# Show  μ prior

d1 = Normal(178, 20)
p[2] = plot(100:250, [pdf(d1, μ) for μ in 100:250], lab="Prior on mu")

# ### snippet 4.11

# Show σ  prior

d2 = Uniform(0, 50)
p[3] = plot(0:0.1:50, [pdf(d2, σ) for σ in 0:0.1:50], lab="Prior on sigma")

plot(p..., layout=(3,1))
savefig("$ProjDir/fig-07-13.1.pdf")

# ### snippet 4.13

sample_mu = rand(d1, 10000)
sample_sigma = rand(d2, 10000)
prior_height = [rand(Normal(sample_mu[i], sample_sigma[i]), 1)[1] for i in 1:10000]
df2 = DataFrame(mu = sample_mu, sigma=sample_sigma, prior_height=prior_height);
first(df2, 5)

# Show density of prior_height

density(prior_height, lab="prior_height")
savefig("$ProjDir/fig-07-13.2.pdf")

# Use data from m4.1s to show CmdStan results

# Check if the m4.1s.jls file is present. If not, run the model.

!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))

# Describe the draws

MCMCChains.describe(chn)

# Plot the density of posterior draws

density(chn)
savefig("$ProjDir/fig-07-13.3.pdf")

# End of `clip-07-13s.jl`
