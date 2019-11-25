# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, CmdStan, LinearAlgebra

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")

# ### snippet 4.7

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

# Use data from m4.1s

# Check if the m4.1s.jls file is present. If not, run the model.

!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))

# Describe the draws

MCMCChains.describe(chn)

# Plot the density of posterior draws

density(chn, lab="All heights", xlab="height [cm]", ylab="density")

# Compute cor

mu_sigma = hcat(chn.value[:, 2, 1], chn.value[:,1, 1])
LinearAlgebra.diag(cov(mu_sigma))

# Compute cov

cor(mu_sigma)

# End of `clip_07.0s.jl`
