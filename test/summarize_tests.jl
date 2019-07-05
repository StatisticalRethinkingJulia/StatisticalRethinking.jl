using StatisticalRethinking, StatsBase, Test
#using Query

ProjDir = @__DIR__
cd(ProjDir)

@testset "Summarize to DataFrame tests" begin
  
  !isfile(joinpath(ProjDir, "samplechains.jls")) && include(joinpath(ProjDir, "samplechains.jl"))
  chns = deserialize(joinpath(ProjDir, "samplechains.jls"))

  parm_df = summarize(chns, sections=[:parameters])
  display(parm_df)
  println()

  @test 154.0 < parm_df[ :alpha, :mean][1] < 156.0
  println()

  parm_df[:alpha, :mean] |> display
  println()

  display(summarize(chns))
  println()

  parm_df = summarize(chns, sections=[:parameters])

  @test 154 < parm_df[:alpha, :mean][1] < 155
  @test names(parm_df) == [:parameters, :mean, :std, :naive_se, :mcse, :ess, :r_hat]
  
  all_sections_df = summarize(chns, sections=[:parameters, :internals])
  @test all_sections_df[:parameters] == 
    [:accept_stat__, :divergent__, :energy__, :lp__,
    :n_leapfrog__, :stepsize__, :treedepth__, :alpha, :beta, :sigma, ]
  @test size(all_sections_df) == (10, 6)

  two_parms_two_funs_df = summarize(chns[[:alpha, :beta]], mean, std)
  @test two_parms_two_funs_df[:parameters] == [:alpha, :beta]
  @test size(two_parms_two_funs_df) == (2, 3)
  @test 154 < two_parms_two_funs_df[:alpha, :mean][1] < 155

  three_parms_df = summarize(chns[[:alpha, :sigma, :lp__]], mean, std, sections=[:parameters, :internals])
  @test three_parms_df[:parameters] == [:lp__, :alpha, :sigma]
  @test size(three_parms_df) == (3, 3)
  @test 154 < three_parms_df[:alpha, :mean][1] < 155

  three_parms_df_2 = summarize(chns[[:alpha, :sigma, :lp__]], mean, std,
    sections=[:parameters, :internals], func_names=["mean", "sd"])
  @test three_parms_df_2[:parameters] == [:lp__, :alpha, :sigma]
  @test size(three_parms_df_2) == (3, 3)
 
end