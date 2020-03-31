
# This script looks at the coefficient plot shown in the first example of [Robust causal interference
# using direct acyclic graphs: the R package `dagitty`](https://academic.oup.com/ije/article/45/6/1887/2907796)
# by J Textor, B van der Zanden, M Gilthorpe, M Lisliewicz and G Ellison.
# [R Dagitty](https://doi.org/10.1093/ije/dyw341)

using StatisticalRethinking, StatsPlots

ProjDir = @__DIR__

for i in 1:5
  include(rel_path("..", "scripts", "05", "dagitty-ex01", "m$i.jl"))
end

models=[m1s, m2s, m3s, m4s, m5s];
pars=[:bC, :bFL, :bPGP, :bTM]

df = CSV.read(rel_path("..", "scripts", "05", "dagitty-ex01", "sports.csv"), delim=',')

scatter(df[:, :TM], df[:, :WUE])
savefig("$(ProjDir)/sports_01.png")

r1 = plotcoef(models, pars, "$(ProjDir)/sports_02.png", "Normal (Particles) estimates")
display(r1)

println()
r2 = plotcoef(models, pars, "$(ProjDir)/sports_03.png", "Quap estimates", quap)
display(r2)
