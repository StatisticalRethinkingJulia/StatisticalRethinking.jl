# Load Julia packages (libraries) needed for clip

using StatisticalRethinking
using StatsPlots

ProjDir = @__DIR__

include("m5.1.jl")
if success(rc)
  dfs = read_samples(m5_1s; output_format=:dataframe)
  p_m5_1 = Particles(dfs);
  q_m5_1 = quap(dfs);
end

include("m5.2.jl")
if success(rc)
  dfs = read_samples(m5_2s; output_format=:dataframe)
  p_m5_2 = Particles(dfs);
  q_m5_2 = quap(dfs);
end

include("m5.3.jl")
if success(rc)
  # Describe the draws
  dfs = read_samples(m5_3s; output_format=:dataframe)
  p_m5_3 = Particles(dfs);
  q_m5_3 = quap(dfs);
end

if success(rc)

  r1 = plotcoef([m5_1s, m5_2s, m5_3s], [:bA, :bM], "$(ProjDir)/Fig-13a.png";
    title="Particles (Normal) estimates")
  display(r1)

  println()
  r2 = plotcoef([m5_1s, m5_2s, m5_3s], [:bA, :bM], "$(ProjDir)/Fig-13b.png"; 
    func=quap, title="Quap estimates")
  display(r2)


end