using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))

describe(chn)

scatter(chn.value[:, 2, 1], chn.value[:, 1, 1])

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

