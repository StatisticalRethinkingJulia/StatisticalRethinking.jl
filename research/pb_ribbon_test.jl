using StatisticalRethinking

ProjDir = @__DIR__

include("$(ProjDir)/m5.5.jl")

# Is ribbons() an option?

function plotbounds_ribbons(
  df::DataFrame, 
  xvar::Symbol,
  yvar::Symbol, 
  dfs::DataFrame, 
  linkvars::Vector{Symbol};
  fig::AbstractString="",
  bounds::Vector{Symbol}=[:predicted, :hpdi],
  title::AbstractString="",
  xlab::AbstractString=String(xvar),
  ylab::AbstractString=String(yvar),
  alpha::Float64=0.11,
  colors::Vector{Symbol}=[:lightgrey, :grey],
  stepsize::Float64=0.01,
  rescale_axis=true
)
  
  xbar = mean(df[:, xvar])
  xstd = std(df[:, xvar])
  ybar = mean(df[:, yvar])
  ystd = std(df[:, yvar])
  
  xvar_s = Symbol(String(xvar)*"_s")
  yvar_s = Symbol(String(yvar)*"_s")

  x_s = minimum(df[:, xvar_s]):stepsize:maximum(df[:, xvar_s])
  y_s = link(dfs, linkvars, x_s);

  if rescale_axis
    x = rescale(x_s, xbar, xstd)
    y = [rescale(y_s[i], ybar, ystd) for i in 1:length(x)]
  else
    x = x_s
    y = y_s
    xbar = 0.0
    xstd = 1.0
    ybar = 0.0
    ystd = 1.0
  end

  mu = [mean(y[i]) for i in 1:length(x)]

  p = plot(xlab=xlab, ylab=ylab, title=title)

  if :predicted in bounds
    p_sim = zeros(length(x), nrow(dfs))
    for i in 1:length(x)
      for j in 1:nrow(dfs)
        p_sim[i, j] = 
          ybar .+ rand(Normal(dfs[j, linkvars[1]] + ystd/xstd * dfs[j, 
            linkvars[2]] * (x[i] - xbar), ystd*dfs[j, linkvars[3]]))
      end
    end

    pred_hpd = [hpdi(p_sim[i, :], alpha=alpha) for i in 1:length(x)]

    p = plot(xlab=xlab, ylab=ylab, title=title)
    hpdi_array = zeros(length(x), 2);
    for i in 1:length(x)
      hpdi_array[i, :] =  hpdi(p_sim[i, :]) - [mu[i], mu[i]]
    end
    plot!(x, mu; ribbon=(hpdi_array[:, 1], -hpdi_array[:, 2]), alpha=0.4, color=colors[1])
  end
   
  if :quantile in bounds
    bnds_quantile = [quantile(y[i], [alpha/2, 1-alpha/2]) for i in 1:length(x)]
    for i in 1:length(x)
      plot!([x[i], x[i]], bnds_quantile[i], color=colors[2], leg=false)
    end
  end
  
  if :hpdi in bounds
    bnds_hpd = [hpdi(y[i], alpha=alpha) for i in 1:length(x)]
    for i in 1:length(x)
      plot!([x[i], x[i]], bnds_hpd[i], color=colors[2], leg=false)
    end
  end

  plot!(x, mu, color=:black)
  if rescale_axis
    scatter!(df[:, xvar], df[:, yvar], leg=false, color=:darkblue)
  else
    scatter!(df[:, xvar_s], df[:, yvar_s], leg=false, color=:darkblue)
  end

  if fig == ""
    return(p)
  else
    savefig(p, fig)
  end
end

xvar = :neocortex_perc
yvar = :kcal_per_g
dfs = dfa5
linkvars = [:a, :bN, :sigma]
fig = "$ProjDir/pba.png"
title = "Kcal_per_g vs. neocortex_perc" * "\nshowing predicted and hpd range"

xlab=String(xvar)
ylab=String(yvar)
alpha=0.11
#colors=[:orangered, :lightgrey]
stepsize=0.01
rescale_axis=true
bounds = [:predicted, :hpdi]

plotbounds_ribbons(
  df, :neocortex_perc, :kcal_per_g,
  dfa5, [:a, :bN, :sigma];
  fig="$ProjDir/pb.png",
  title=title
)
