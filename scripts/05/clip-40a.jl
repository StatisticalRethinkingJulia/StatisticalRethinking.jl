# Load Julia packages (libraries) needed.

using StatisticalRethinking
using StatsPlots
gr(size=(800,600))

ProjDir = @__DIR__

# ### snippet 5.39

for i in 5:7
  include("$(ProjDir)/m5.$i.jl")
end

if success(rc)

  dfa5 = read_samples(m5_5s; output_format=:dataframe)
  title = "Kcal_per_g vs. neocortex_perc" * "\n89% predicted and mean range"
  p1 = plotbounds(
    df, :neocortex_perc, :kcal_per_g,
    dfa5, [:a, :bN, :sigma];
    title=title,
    rescale_axis=false
  )

  dfa6 = read_samples(m5_6s; output_format=:dataframe)
  title = "Kcal_per_g vs. log mass" * "\nshowing 89% predicted and mean range"
  p2 = plotbounds(
    df, :lmass, :kcal_per_g,
    dfa6, [:a, :bM, :sigma];
    title=title,
    rescale_axis=false
  )

  dfa7 = read_samples(m5_7s; output_format=:dataframe)
  title = "Counterfactual,\nholding M=0.0"
  p3 = plotbounds(
    df, :neocortex_perc, :kcal_per_g,
    dfa7, [:a, :bN, :sigma];
    title=title,
    rescale_axis=false
  )

  title = "Counterfactual,\nholding N=0.0"
  p4 = plotbounds(
    df, :lmass, :kcal_per_g,
    dfa7, [:a, :bM, :sigma];
    title=title,
    xlab="log(mass)",
    rescale_axis=false
  )

  plot(p1, p2, p3, p4, layout=(2, 2))
  savefig("$(ProjDir)/Fig-40a.png")
  savefig("$(ProjDir)/Fig-40a.pdf")
end
