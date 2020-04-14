# Load Julia packages (libraries) needed for clip

using StatisticalRethinking, GLM

ProjDir = @__DIR__

N = 100
df = DataFrame(
  :R => rand(Normal(), N)
)
df[!, :S] = [rand(Normal(df[i, :R]), 1)[1] for i in 1:N]
df[!, :Y] = [rand(Normal(df[i, :R]), 1)[1] for i in 1:N]

scale!(df, [:R, :S, :Y])

for suf in ["RS", "SR"]
  include(rel_path("..", "scripts", "05", "m5.4_$suf.jl"))
end

if success(rc)

  pRS = plotbounds(df, :R, :S, dfs_RS, [:a, :bRS, :sigma])
  pSR = plotbounds(df, :S, :R, dfs_SR, [:a, :bSR, :sigma])

  plot(pRS, pSR, layout=(1, 2))
  savefig("$(ProjDir)/Fig-18a.png")

  # Compute standardized residuals

  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
  
  r = -2.0:0.1:3.0
  mu_SR = mean(p_SR.a) .+ mean(p_SR.bSR)*r

  p[1] = plot(xlab="R (std)", ylab="S (std)", leg=false)
  plot!(r, mu_SR)
  scatter!(df[:, :S_s], df[:, :R_s])
  
  mu_RS_obs = mean(p_RS.a) .+ mean(p_RS.bRS)*df[:, :S_s]
  res_RS = df[:, :R_s] - mu_RS_obs

  s = -2.0:0.1:3.0
  mu_RS = mean(p_RS.a) .+ mean(p_RS.bRS)*s

  p[2] = plot(xlab="S (std)", ylab="R (std)", leg=false)
  plot!(s, mu_RS)
  scatter!(df[:, :R_s], df[:, :S_s])
  
  mu_SR_obs = mean(p_SR.a) .+ mean(p_SR.bSR)*df[:, :R_s]
  res_SR = df[:, :S_s] - mu_SR_obs

  df2 = DataFrame(
    :y => df[:, :Y_s],
    :r => res_RS
  )

  m1 = lm(@formula(y ~ r), df2)
  coef(m1) |> display

  p[3] = plot(xlab="R residuals", ylab="Y (std)", leg=false)
  plot!(s, coef(m1)[1] .+ coef(m1)[2]*s)
  scatter!(res_RS, df[:, :Y_s])
  vline!([0.0], line=:dash, color=:black)

  mu_SR_obs = mean(p_SR.a) .+ mean(p_SR.bSR)*df[:, :R_s]
  res_SR = df[:, :S_s] - mu_SR_obs

  df3 = DataFrame(
    :y => df[:, :Y_s],
    :s => res_SR
  )

  m2 = lm(@formula(y ~ s), df3)
  coef(m2) |> display

  p[4] = plot(xlab="S residuals", ylab="Y (std)", leg=false)
  plot!(r, coef(m2)[1] .+ coef(m2)[2]*r)
  scatter!(res_SR, df[:, :Y_s])
  vline!([0.0], line=:dash, color=:black)
  
  plot(p..., layout=(2,2))
  savefig("$(ProjDir)/Fig-18b.png")

end


# The simulations as in R code 5.12 will be included in StructuralCausalModels.jl