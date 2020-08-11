using StatisticalRethinking, GLM

ProjDir = @__DIR__

df1 = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
df1 = filter(row -> !(row[:neocortex_perc] == "NA"), df1);

df = DataFrame()
df[!, :NC] = parse.(Float64, df1[:, :neocortex_perc])
df[!, :M] = log.(df1[:, :mass])
df[!, :K] = df1[:, :kcal_per_g]
first(df, 5) |> display
scale!(df, [:K, :NC, :M])
println()

include("$(ProjDir)/m5.7_A.jl")

first(dfa, 5) |> display
println()

p = Particles(dfa)
display(p)



