
# This script looks at some of the plots shown in the first example of [Robust causal interference
# using direct acyclic graphs: the R package `dagitty`](https://academic.oup.com/ije/article/45/6/1887/2907796)
# by J Textor, B van der Zanden, M Gilthorpe, M Lisliewicz and G Ellison.
# [R Dagitty](https://doi.org/10.1093/ije/dyw341)

using StatisticalRethinking, StatsPlots

ProjDir = @__DIR__

include("m1.jl")
include("m2.jl")
include("m3.jl")
include("m4.jl")
include("m5.jl")

models=[m1s, m2s, m3s, m4s, m5s];
pars=[:bC, :bFL, :bPGP, :bTM]

df = CSV.read(joinpath(ProjDir, "sports.csv"), delim=',')

scatter(df[:, :TM], df[:, :WUE])
savefig("$(ProjDir)/sports_01.png")

r1 = plotcoef(models, pars, "$(ProjDir)/sports_02.png";
  title="Normal estimates")
display(r1)

println()
r2 = plotcoef(models, pars, "$(ProjDir)/sports_03.png"; 
  func=quap, title="Quap estimates")
display(r2)
