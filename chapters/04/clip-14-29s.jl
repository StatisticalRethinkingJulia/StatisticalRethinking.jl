using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

!isfile("m4.1s.jls") && include("m4.1s.jl")

chn = deserialize("m4.1s.jls")

describe(chn)

scatter(chn.value[:, 2, 1], chn.value[:, 1, 1])

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

