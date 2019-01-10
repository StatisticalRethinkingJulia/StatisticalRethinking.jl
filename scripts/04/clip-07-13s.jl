# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# ### snippet 4.7

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# ### snippet 4.8

# Show first 5 rows of DataFrame df

first(df, 5)

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);

# Plot the densities.

density(df2[:height], lab="All heights", xlab="height [cm]", ylab="density")

# Filter on sex to see if it is bi-modal

female_df = filter(row -> row[:male] == 0, df2);
male_df = filter(row -> row[:male] == 1, df2);
first(male_df, 5)

# Is it bi-modal?

density!(female_df[:height], lab="Female heights")
density!(male_df[:height], lab="Male heights")

# Use data from m4.1s

# Check if the m4.1s.jls file is present. If not, run the model.

!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize("m4.1s.jls")

# Describe the draws

describe(chn)

# ### snippet 4.13

# Plot the density of posterior draws

density(chn, lab="All heights", xlab="height [cm]", ylab="density")

# End of `clip-07-13s.jl`
