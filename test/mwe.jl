# Load Julia packages (libraries) needed  for the snippets in chapter 0

@time using StatisticalRethinking, CSV, DataFrames

@time ProjDir = @__DIR__
println(ProjDir)

@time df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
@time first(df, 5) |> display

@time using StanSample
@time println()

@time using MCMCChains
@time println()

@time using StatsPlots
@time println()
