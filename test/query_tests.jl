using StatisticalRethinking, StatsBase, Test
using Query

ProjDir = @__DIR__
cd(ProjDir)

@testset "Query tests" begin
  
  !isfile(joinpath(ProjDir, "samplechains.jls")) && include(joinpath(ProjDir, "samplechains.jl"))
  chns = deserialize(joinpath(ProjDir, "samplechains.jls"))

  parm_df = summarize(chns, sections=[:parameters])
 
  display(summarize(chns))
  println()

  x = parm_df.df |>
    @filter(_.parameters in [:alpha, :beta, :sigma]) |>
    @map({_.mean, _.std}) |>
    DataFrame

  println(x)
  println()

  y = @from i in parm_df.df begin
      @where i.parameters in [:alpha, :beta, :sigma]
      @select {i.mean, i.std}
      @collect DataFrame
  end

  println(y)
  println()
end