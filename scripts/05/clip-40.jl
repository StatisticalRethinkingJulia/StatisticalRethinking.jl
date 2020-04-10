# Load Julia packages (libraries) needed.

using StatisticalRethinking
using StatsPlots

ProjDir = @__DIR__

# ### snippet 5.39

include("$(ProjDir)/m5.7.jl")

if success(rc)

  dfa7 = read_samples(m5_7s; output_format=:dataframe)
  first(dfa7, 5)

  title = "Kcal_per_g vs. neocortex_perc with M=0.0"
  plotbounds(
    df, :neocortex_perc, :kcal_per_g,
    dfa7, [:a, :bN, :sigma];
    fig="$(ProjDir)/Fig-40.png",
    title=title
  )

end
