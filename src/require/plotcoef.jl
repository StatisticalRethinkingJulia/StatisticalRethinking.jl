using .StatsPlots

import .StanSample: SampleModel

function plotcoef(models::Vector{SampleModel}, pars::Vector{Symbol}, fig::AbstractString; 
  func=nothing, title="")

  mnames = [models[i].name for i in 1:length(models)]
  levels = length(models) * (length(pars) + 1) + 2
  colors = [:blue, :red, :green, :yellow, :black]

  s = Vector{NamedTuple}(undef, length(models))
  for (mindx, mdl) in enumerate(models)
    if isnothing(func)
      s[mindx] = read_samples(mdl; output_format=:particles)
    else
      dfs = read_samples(mdl; output_format=:dataframe)      
      s[mindx] = func(dfs)
    end
  end

  xmin = 0; xmax = 0.0
  for i in 1:length(s)
    for par in pars
      syms = Symbol.(keys(s[i]))
      if Symbol(par) in syms
        mp = mean(s[i][Symbol(par)])
        sp = std(s[i][Symbol(par)])
        xmin = min(xmin, mp - sp)
        xmax = max(xmax, mp + sp)
      end
    end
  end
  #println(xmin); println(xmax)

  ylabs = ["        ", 
    "      bA", "      bM", "m5.1s   ",
    "      bA", "      bM", "m5.2s   ",
    "      bA", "      bM", "m5.3s   ",
    "        "]

  ys = [string(ylabs[i]) for i = 1:length(ylabs)]
  plot(xlims=(xmin, xmax), ys, leg=false, framestyle=:grid)
  title!(title)
  #xran = range(xmin, stop=xmax, length=11)
  #xticks!(xran)
  yran = range(0, stop=10, length=11)
  yticks!(yran, ys)


  local line = 0
  for (mindx, model) in enumerate(models)
    line += 1
    hline!([line] .+ 2, color=:darkgrey, line=(2, :dash))
    for (pindx, par) in enumerate(pars)
      line += 1
      syms = Symbol.(keys(s[mindx]))
      if Symbol(par) in syms
        ypos = (line - 1)
        mp = mean(s[mindx][Symbol(par)])
        sp = std(s[mindx][Symbol(par)])
        plot!([mp-sp, mp+sp], [ypos, ypos], leg=false, color=colors[pindx])
        scatter!([mp], [ypos], color=colors[pindx])
        #println([mnames[mindx], par, syms, mp, ypos])
      end
    end
  end
  
  savefig(fig)

  s

end

export
  plotcoef
