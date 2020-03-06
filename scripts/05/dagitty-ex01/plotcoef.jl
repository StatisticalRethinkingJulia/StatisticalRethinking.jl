function plotcoef(models::Vector{SampleModel}, pars::Vector{Symbol}, fig::AbstractString; 
  func=nothing, title="")

  mnames = [models[i].name for i in 1:length(models)]
  levels = length(models) * (length(pars) + 1) + 2
  colors = [:blue, :red, :green, :darkred, :black]

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

  ylabs = String[]
  append!(ylabs, ["        "])
  for j in 1:length(models)
    for i in 1:length(pars)
      append!(ylabs, ["      " * String(pars[i])])
    end
    append!(ylabs, [models[j].name * "       "])
  end
  append!(ylabs, ["        "])

  ys = [string(ylabs[i]) for i = 1:length(ylabs)]
  plot(xlims=(xmin, xmax), ys, leg=false, framestyle=:grid)
  title!(title)
  yran = range(0, stop=length(ylabs)-1, length=length(ylabs))
  yticks!(yran, ys)

  line = 0
  for (mindx, model) in enumerate(models)
    line += 1
    hline!([line] .+ length(pars), color=:darkgrey, line=(2, :dash))
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
