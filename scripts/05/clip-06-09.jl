# Load Julia packages (libraries) needed for clip

using StatisticalRethinking
using StatsPlots

ProjDir = @__DIR__

include("m5.2.jl")

if success(rc)

  # Describe the draws
  dfs = read_samples(m5_2s; output_format=:dataframe)
  println("\nSample Particles summary:"); p_m_5_2 = Particles(dfs); p_m_5_2 |> display
  println("\nQuap Particles estimate:"); q_m_5_2 = quap(dfs); display(q_m_5_2)

  # Rethinking results

  rethinking_results = "
          mean   sd  5.5% 94.5%
    a     0.00 0.11 -0.17  0.17
    bM    0.35 0.13  0.15  0.55
    sigma 0.91 0.09  0.77  1.05
  ";

  title = "Divorce rate vs. Marriage rate" * "\nshowing sample and hpd range"
  plotbounds(
    df, :Marriage, :Divorce,
    dfs, [:a, :bM];
    fig="$ProjDir/Fig-06-09.png",
    title=title,
    colors=[:lightgrey, :darkgrey]
  )

end

# End of `05/clip-06-10.jl`
