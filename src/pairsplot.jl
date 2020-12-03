"""
# pairsplot

A simple version of StatsPlots' `cornerplot`.

$(SIGNATURES)

### Required arguments
```julia
* `df::DataFrame`                      : DataFrame containing the variables (as columns)
* `vars::Vector{Symbol}`               : Vector of variables to include in plot
```

"""
function pairsplot(df::DataFrame, vars::Vector{Symbol})

  l = length(vars)
  pmat = Matrix{Plots.Plot{Plots.GRBackend}}(undef, l, l)

  for i in 1:l
    for j in 1:l
      if i == j
        pmat[i, j] = plot(xlims=(0, 2), ylims=(0, 2), leg=false, framestyle=:none)
        plot!(pmat[i, j], annotations=(1, 1, Plots.text(String(vars[i]), :mid)),
          leg=false)
      else
        pmat[i,j] = scatter(df[:, vars[i]], df[:, vars[j]],
          markersize=5, color=:darkblue, leg=false)
      end
    end
  end
  plot(pmat..., layout=(l, l))

end

export
  pairsplot
