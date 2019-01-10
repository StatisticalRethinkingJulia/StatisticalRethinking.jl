# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# Use data from m4.1s

# Check if the m4.1s.jls file is present. If not, run the model.

!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))

# Describe the draws

describe(chn)

# ### snippet 4.15

scatter(chn.value[:, 2, 1], chn.value[:, 1, 1])

# End of `clip-14-29s.jl`
