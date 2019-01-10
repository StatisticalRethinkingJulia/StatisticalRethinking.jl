using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

d = JLD.load(joinpath(ProjDir, "m4.1s.jld"))

chn = MCMCChain.Chains(d["a3d"], names=d["names"])

describe(chn)

scatter(chn.value[:, 2, 1], chn.value[:, 1, 1])

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

