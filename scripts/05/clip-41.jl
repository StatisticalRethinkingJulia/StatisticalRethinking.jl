# Load Julia packages (libraries) needed.

using StatisticalRethinking
using StatsPlots

ProjDir = @__DIR__

# ### snippet 5.39

include("$(ProjDir)/m5.7.jl")

if success(rc)

  dfa7 = read_samples(m5_7s; output_format=:dataframe)
  first(dfa7, 5)

  xbar = mean(df[:, :lmass])
  xstd = std(df[:, :lmass])
  ybar = mean(df[:, :kcal_per_g])
  ystd = std(df[:, :kcal_per_g])

  xi = minimum(df[:, :lmass_s]):0.01:maximum(df[:, :lmass_s])
  yi = mean(dfa7[:, :a]) .+ mean(dfa7[:, :bM]) .* xi
  mu = link(dfa7, [:a, :bM], xi);
  mu_r = [rescale(mu[i], ybar, ystd) for i in 1:length(xi)]
  mu_means_r = [mean(mu_r[i]) for i in 1:length(xi)]
  bnds_hpd = [hpdi(mu_r[i], alpha=0.11) for i in 1:length(xi)];

  title = "Kcal_per_g vs. log mass with N=0.0"
  plot(xlab="log mass", ylab="Kcal_per_g",
    title=title)

  x_r = rescale(xi, xbar, xstd)

  for i in 1:length(xi)
    plot!([x_r[i], x_r[i]], bnds_hpd[i],
      color=:grey, leg=false)
  end

  plot!(x_r , mu_means_r, color=:black)
  scatter!(df[:, :lmass], df[:, :kcal_per_g], leg=false, color=:darkblue)

  savefig("$(ProjDir)/Fig-41.png")


end
