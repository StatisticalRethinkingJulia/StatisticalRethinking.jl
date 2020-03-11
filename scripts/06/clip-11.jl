# Load Julia packages (libraries) needed.

using StatisticalRethinking, StatsPlots

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
scale!(df, [:kcal_per_g, :perc_fat, :perc_lactose])
println()

pairsplot(df, [:kcal_per_g, :perc_fat, :perc_lactose], "$(ProjDir)/Fig-11.png")

cor(df[:, :perc_fat], df[:, :perc_lactose]) |> display
