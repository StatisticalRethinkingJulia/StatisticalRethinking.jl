# Load Julia packages (libraries) needed for clip

using StatisticalRethinking, GLM

ProjDir = @__DIR__

for suf in ["MA", "AM"]
  include(rel_path("..", "scripts", "05", "m5.4_$suf.jl"))
end

if success(rc)

  pMA = plotbounds(df, :M, :A, dfs_MA, [:a, :bMA, :sigma])
  pAM = plotbounds(df, :A, :M, dfs_AM, [:a, :bAM, :sigma])

  plot(pAM, pMA, layout=(1, 2))
  savefig("$(ProjDir)/Fig-13a.png")

  # Compute standardized residuals

  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)

  a = -2.5:0.1:3.0
  mu_MA = mean(p_MA.a) .+ mean(p_MA.bMA)*a

  p[1] = plot(xlab="Age at marriage (std)", ylab="Marriage rate (std)", leg=false)
  plot!(a, mu_MA)
  scatter!(df[:, :A_s], df[:, :M_s])
  annotate!([(df[9, :A_s]-0.1, df[9, :M_s], Plots.text("DC", 6, :red, :right))])

  m = -2.0:0.1:3.0
  mu_AM = mean(p_AM.a) .+ mean(p_AM.bAM)*m

  p[2] = plot(ylab="Age at marriage (std)", xlab="Marriage rate (std)", leg=false)
  plot!(m, mu_AM)
  scatter!(df[:, :M_s], df[:, :A_s])
  annotate!([(df[9, :M_s]+0.2, df[9, :A_s], Plots.text("DC", 6, :red, :left))])

  mu_MA_obs = mean(p_MA.a) .+ mean(p_MA.bMA)*df[:, :A_s]
  res_MA = df[:, :M_s] - mu_MA_obs

  df2 = DataFrame(
    :d => df[:, :D_s],
    :r => res_MA
  )

  m1 = lm(@formula(d ~ r), df2)
  #coef(m1) |> display

  p[3] = plot(xlab="Marriage rate residuals", ylab="Divorce rate (std)", leg=false)
  plot!(m, coef(m1)[1] .+ coef(m1)[2]*m)
  scatter!(res_MA, df[:, :D_s])
  vline!([0.0], line=:dash, color=:black)
  annotate!([(res_MA[9], df[9, :D_s]+0.1, Plots.text("DC", 6, :red, :bottom))])

  mu_AM_obs = mean(p_AM.a) .+ mean(p_AM.bAM)*df[:, :M_s]
  res_AM = df[:, :A_s] - mu_AM_obs

  df3 = DataFrame(
    :d => df[:, :D_s],
    :r => res_AM
  )

  m2 = lm(@formula(d ~ r), df3)
  #coef(m2) |> display

  p[4] = plot(xlab="Age at marriage residuals", ylab="Divorce rate (std)", leg=false)
  plot!(a, coef(m2)[1] .+ coef(m2)[2]*a)
  scatter!(res_AM, df[:, :D_s])
  vline!([0.0], line=:dash, color=:black)
  annotate!([(res_AM[9]-0.1, df[9, :D_s], Plots.text("DC", 6, :red, :right))])

  plot(p..., layout=(2,2))
  savefig("$(ProjDir)/Fig-13b.png")

end


# The simulations as in R code 5.12 will be included in StructuralCausalModels.jl