# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# ### snippet 4.14

# Use data from m4.1s

d = JLD.load(joinpath(ProjDir, "m4.1s.jld"))

chn = MCMCChain.Chains(d["a3d"], names=d["names"])

# Describe the draws

describe(chn)

# ### snippet 4.15

scatter(chn.value[:, 2, 1], chn.value[:, 1, 1])

# End of `clip-14-29s.jl`
