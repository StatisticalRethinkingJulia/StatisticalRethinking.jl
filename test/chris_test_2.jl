using StatisticalRethinking, CmdStan

theme(:ggplot2);

ProjDir = @__DIR__

!isfile(joinpath(ProjDir, "samplechains.jls")) && include(joinpath(ProjDir, "samplechains.jl"))
chns = deserialize(joinpath(ProjDir, "samplechains.jls"))

df = DataFrame(chns, [:parameters])

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, size(df, 2))

for (i, par) in enumerate(names(df))
  p[i] = density(df[par], title="$par", xlab="Sample value", ylab="Density", leg=false)
end

plt = plot(p..., layout=(size(df, 2),1))

savefig(plt, ProjDir*"/chris_test_2.pdf")
