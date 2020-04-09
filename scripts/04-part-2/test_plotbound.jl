import StatisticalRethinking: plotbounds

ProjDor = @__DIR__

xvar = :weight; yvar = :height
dfs = dfa 
linkvars = [:a, :b]
bounds = [:predicted, :hpdi]
fig = "$ProjDir/Fig-56-63a.png"
title = "Height vs. Weight" * "\nshowing predicted and hpd range"
colors=[:lightgrey, :darkgrey]
stepsize = 0.1
alpha = 0.11
xlab = String(xvar)
ylab = String(yvar)

function plotbounds(
  df::DataFrame, 
  xvar::Symbol,
  yvar::Symbol, 
  dfs::DataFrame, 
  linkvars::Vector{Symbol};
  fig::AbstractString="",
  bounds::Vector{Symbol}=[:range, :hpdi],
  title::AbstractString="",
  xlab::AbstractString=String(xvar),
  ylab::AbstractString=String(yvar),
  alpha::Float64=0.11,
  colors::Vector{Symbol}=[:lightgrey, :grey],
  stepsize::Float64=0.01
)
  
  xbar = mean(df[:, xvar])
  xstd = std(df[:, xvar])
  ybar = mean(df[:, yvar])
  ystd = std(df[:, yvar])
  
  xvar_s = Symbol(String(xvar)*"_s")
  yvar_s = Symbol(String(yvar)*"_s")

  x_s = minimum(df[:, xvar_s]):stepsize:maximum(df[:, xvar_s])
  y_s = link(dfs, linkvars, x_s);

  x = rescale(x_s, xbar, xstd)
  y = [rescale(y_s[i], ybar, ystd) for i in 1:length(x)]
  mu = [mean(y[i]) for i in 1:length(x)]

  p = plot(xlab=xlab, ylab=ylab, title=title)

  if :range in bounds
    bnds_range = [[minimum(y[i]), maximum(y[i])] for i in 1:length(x)]
    for i in 1:length(x)
      plot!([x[i], x[i]], bnds_range[i], color=colors[1], leg=false)
    end
  end
   
  if :predicted in bounds
    predictions = zeros(length(x), nrow(dfs))
    for i in 1:length(x)
      for j in 1:nrow(dfs)
        predictions[i, j] = 
          ybar .+ rand(Normal(dfs[j, :a] + ystd/xstd * dfs[j, :b] * (x[i] - xbar), ystd*dfs[j, :sigma]), 1)[1] 
      end
    end
    pred_hpd = [hpdi(predictions[i, :], alpha=alpha) for i in 1:length(x)]
    for i in 1:length(x)
      plot!([x[i], x[i]], pred_hpd[i], color=colors[1], leg=false)
    end
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
  scatter!(df[:, xvar], df[:, yvar], leg=false, color=:darkblue)

  if fig == ""
    return(p)
  else
    savefig(p, fig)
  end

end

  plotbounds(
    df, :weight, :height,
    dfa, [:a, :b];
    bounds=[:predicted, :range, :hpdi],
    fig="$ProjDir/Fig-56-63b.png",
    title=title,
    colors=[:lightgrey, :darkgrey]
  )
