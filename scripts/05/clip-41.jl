# Load Julia packages (libraries) needed.

using StatisticalRethinking

ProjDir = @__DIR__

# ### snippet 5.39

include("$(ProjDir)/m5.7.jl")

if success(rc)

  dfa7 = read_samples(m5_7s; output_format=:dataframe)
  first(dfa7, 5)

  title = "Kcal_per_g vs. log mass with N=0.0"
  plotbounds(
    df, :lmass, :kcal_per_g,
    dfa7, [:a, :bM, :sigma];
    fig="$(ProjDir)/Fig-41.png",
    title=title
  )

end
