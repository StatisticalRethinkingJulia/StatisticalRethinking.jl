# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

include("m5.3.jl")

if success(rc)

  # Describe the draws
  dfs = read_samples(m5_3s; output_format=:dataframe)
  println("\nSample Particles summary:"); p_m_5_3 = Particles(dfs); p_m_5_3 |> display
  println("\nQuap Particles estimate:"); q_m_5_3 = quap(dfs); display(q_m_5_3)

  # Rethinking results

  rethinking_results = "
           mean   sd  5.5% 94.5%
    a      0.00 0.10 -0.16  0.16
    bM    -0.07 0.15 -0.31  0.18
    bA    -0.61 0.15 -0.85 -0.37
    sigma  0.79 0.08  0.66  0.91
  ";

  title = "Divorce rate vs. Marriage rate" * "\nshowing predicted and hpd range"
  plotbounds(
    df, :Marriage, :Divorce,
    dfs, [:a, :bM, :sigma];
    fig="$ProjDir/Fig-10-11.png",
    title=title,
    colors=[:lightgrey, :darkgrey],
    bounds=[:predicted, :hpdi]

  )

end

# End of `05/clip-10-12.jl`
