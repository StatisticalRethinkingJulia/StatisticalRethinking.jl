# Load Julia packages (libraries) needed for clip

using StatisticalRethinking
using CSV, StanSample, DataFrames, Statistics
using KernelDensity, MonteCarloMeasurements
using StatsPlots

ProjDir = @__DIR__

#=
include("m5.1.jl")
if success(rc)
  dfs = read_samples(m_5_1; output_format=:dataframe)
  p_m_5_1 = Particles(dfs);
  q_m_5_1 = quap(dfs);
end

include("m5.2.jl")
if success(rc)
  dfs = read_samples(m_5_2; output_format=:dataframe)
  p_m_5_2 = Particles(dfs);
  q_m_5_2 = quap(dfs);
end

include("m5.3.jl")
if success(rc)
  # Describe the draws
  dfs = read_samples(m_5_3; output_format=:dataframe)
  p_m_5_3 = Particles(dfs);
  q_m_5_3 = quap(dfs);
end
=#

if success(rc)

  models = ["m5.1", "m5.2", "m5.3"]
  pars = ["bA", "bM"]
  ylabs = ["m5.1: bA", "m5.1: bM", "m5.2: bA", "m5.2: bM", "m5.3: bA", "m5.3: bM"]
  mods = [q_m_5_1, q_m_5_2, q_m_5_3]

  levels = length(models) * (length(pars) + 1)

  ys = [string(ylabs[i]) for i = 1:length(ylabs)]
  plot(xlims=(-1, 0.5), ys, leg=false, size=(400,100))
  #scatter!([0.0, 0.7, -0.5], [0.5, 1.5, 3.5])
  #plot!([0.6, 0.8], [1.5, 1.5])

  colors = [:blue, :red, :green, :yellow, :black]
  local line = 0
  for (mindx, model) in enumerate(mods)
    for (pindx, par) in enumerate(pars)
      line += 1
      syms = Symbol.(keys(mods[mindx]))
      if Symbol(par) in syms
        ypos = (line - 1) + 0.5
        mp = mean(mods[mindx][Symbol(par)])
        sp = std(mods[mindx][Symbol(par)])
        plot!([mp-sp, mp+sp], [ypos, ypos], leg=false, color=colors[pindx])
        scatter!([mp], [ypos], color=colors[pindx])
        println([models[mindx], par, syms, mp, ypos])
      end
    end
  end
  

  savefig("$(ProjDir)/Fig-13.png")

end