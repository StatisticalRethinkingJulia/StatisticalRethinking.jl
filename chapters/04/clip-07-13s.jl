using StatisticalRethinking, CmdStan
#gr(size=(700,700));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

first(df, 5)

first(df, 5)

df2 = filter(row -> row[:age] >= 18, df);

m4_1 = "
  height ~ Normal(μ, σ) # likelihood
  μ ~ Normal(178,20) # prior
  σ ~ Uniform(0, 50) # prior
";

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 3)
p[1] = density(df2[:height], xlim=(100,250), lab="All heights", xlab="height [cm]", ylab="density")

d1 = Normal(178, 20)
p[2] = plot(100:250, [pdf(d1, μ) for μ in 100:250], lab="Prior on mu")

d2 = Uniform(0, 50)
p[3] = plot(0:0.1:50, [pdf(d2, σ) for σ in 0:0.1:50], lab="Prior on sigma")

plot(p..., layout=(3,1))

sample_mu = rand(d1, 10000)
sample_sigma = rand(d2, 10000)
prior_height = [rand(Normal(sample_mu[i], sample_sigma[i]), 1)[1] for i in 1:10000]
df2 = DataFrame(mu = sample_mu, sigma=sample_sigma, prior_height=prior_height);
first(df2, 5)

density(prior_height, lab="prior_height")

!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))

MCMCChains.describe(chn)

density(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

