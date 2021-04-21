function plot_model_coef(s::Vector{NamedTuple},  pars::Vector{Symbol};
  mnames=String[], fig="", title="")

  levels = length(s) * (length(pars) + 1)
  colors = [:blue, :red, :green, :darkred, :black, :grey, :darkblue, :cyan, :darkred]

  xmin = 0; xmax = 0.0
  for i in 1:length(s)
    for par in pars
      syms = Symbol.(keys(s[i]))
      if Symbol(par) in syms
        mp = s[i][par].mean
        xmin = min(xmin, s[i][par].lower)
        xmax = max(xmax, s[i][par].upper)
      end
    end
  end

  ylabs = String[]
  for j in 1:length(s)
    for i in 1:length(pars)
      l = length(String(pars[i]))
      str = repeat(" ", 9-l) * String(pars[i])
      append!(ylabs, [str])
    end
    l = length(mnames[j])
    str = mnames[j] * repeat(" ", 9-l)
    append!(ylabs, [str])
  end

  ys = [string(ylabs[i]) for i = 1:length(ylabs)]
  p = plot(xlims=(xmin, xmax), leg=false, framestyle=:grid)
  title!(title)
  yran = range(1, stop=length(ylabs), length=length(ys))
  yticks!(yran, ys)

  line = 0
  for mindx in 1:length(s)
    line += 1
    hline!([line] .+ length(pars), color=:darkgrey, line=(2, :dash))
    for (pindx, par) in enumerate(pars)
      line += 1
      syms = Symbol.(keys(s[mindx]))
      if Symbol(par) in syms
        ypos = (line - 1)
        mp = s[mindx][Symbol(par)].mean
        lower = s[mindx][Symbol(par)].lower
        upper = s[mindx][Symbol(par)].upper
        plot!([lower, upper], [ypos, ypos], leg=false, color=colors[pindx])
        scatter!([mp], [ypos], color=colors[pindx])
      end
    end
  end
  if length(fig) > 0
    savefig(p, fig)
  end
  (s, p)
end

function plot_model_coef(df::DataFrame, pars::Vector{Symbol};
    mname="", fig="", title="")

  if length(mname) > 9
    mname = mname[1:9]
  end
 
  s = Vector{NamedTuple}(undef, 1)
  for mindx in 1:1
    m, l, u = estimparam(df)
    d = Dict{Symbol, NamedTuple}()
    for (indx, par) in enumerate(names(df))
      d[Symbol(par)] = (mean=m[indx], lower=l[indx], upper=u[indx])
    end
    s[mindx] =   (; d...)
  end

  plot_model_coef(s, pars; mnames=[mname], fig, title)
end

function plot_model_coef(p::Pair{String, DataFrame}, pars::Vector{Symbol};
    fig="", title="")

  mname = p.first
  if length(mname) > 9
    mname = mname[1:9]
  end
 
  s = Vector{NamedTuple}(undef, 1)
  for mindx in 1:1
    m, l, u = estimparam(p.second)
    d = Dict{Symbol, NamedTuple}()
    for (indx, par) in enumerate(names(p.second))
      d[Symbol(par)] = (mean=m[indx], lower=l[indx], upper=u[indx])
    end
    s[mindx] =   (; d...)
  end

  plot_model_coef(s, pars; mnames=[mname], fig, title)
end

export
  plot_model_coef