using StatsPlots, Random
gr(size=(800,600))

ProjDir = @__DIR__

function chart(N::Int)

  shapes = range(0.5, stop=2.0, length=N)
  scales = range(0.2, stop=2.5, length=N)

  p = Array{Plots.Plot{Plots.GRBackend},2}(undef, N, N);
  for (shi,sh) in enumerate(shapes)
    for (sci, sc) in enumerate(scales)
      dgamma = Gamma(sh, sc)
      p[sci, shi] = density(rand(dgamma, 10000), 
        title="Shape $(round(sh, digits=1)),
        scale $(round(sc, digits=1))",
        titlefontsize=6)
    end
  end

  plot(p..., layout=Plots.GridLayout(N, N), legend=false, yaxis=true, tickfontsize=6)
  savefig("$(ProjDir)/chart.png")

  plot(density(rand(Gamma(3, 15), 10000)), lab="Gamma(3, 15)")
  savefig("$(ProjDir)/chart_a.png")

end

chart(6)
