using StatisticalRethinking, CmdStan, StanMCMCChain, LinearAlgebra
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))

describe(chn)

density(chn, lab="All heights", xlab="height [cm]", ylab="density")

mu_sigma = hcat(chn.value[:, 2, 1], chn.value[:,1, 1])
LinearAlgebra.diag(cov(mu_sigma))

cor(mu_sigma)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

