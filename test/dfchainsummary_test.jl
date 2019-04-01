using StatisticalRethinking, StatsBase, Test, Query

ProjDir = @__DIR__
cd(ProjDir)

include("samplechain.jl")

parm_df = MCMCChains.dfchainsummary(chns, [:parameters])
display(parm_df)
println()

@test 154.0 < parm_df[parm_df.parameters .== :alpha, :mean][1] < 156.0
println()

parm_df[parm_df.parameters .== :alpha, :] |> display
println()

display(MCMCChains.dfchainsummary(chns))
println()

x = parm_df |>
  @filter(_.parameters in [:alpha, :beta, :sigma]) |>
  @map({_.mean, _.std}) |>
  DataFrame

println(x)
