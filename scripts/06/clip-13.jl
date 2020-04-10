# Load Julia packages

using StatisticalRethinking

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
scale!(df, [:kcal_per_g, :perc_fat, :perc_lactose])
println()

