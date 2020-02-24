# Execute this script after `scripts/03/intro_stan/intro-part-1.jl`

using StatisticalRethinking

if success(rc)

  # Allocate array of 4 Normal fits

  fits = Vector{Normal{Float64}}(undef, 4);

  # Fit a normal distribution to each chain.

  dfsa = read_samples(sm; output_format=:dataframes)

  println("\nFit a Normal distribution to each chain:\n")
  for i in 1:4
    fits[i] = fit_mle(Normal, dfsa[i][:, :theta])
    println(fits[i])
  end

  # Plot the 4 chains

  mu_mle = sum([fits[i].μ for i in 1:4]) / 4.0;
  sigma_mle = sum([fits[i].σ for i in 1:4]) / 4.0;

  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
  x = 0:0.001:1
  for i in 1:4
    μ = round(fits[i].μ, digits=2)
    σ = round(fits[i].σ, digits=2)
    p[i] = density(dfsa[i][:, :theta], lab="Chain $i density",
       xlim=(0.45, 1.0), title="$(N) data points")
   plot!(p[i], x, pdf.(Normal(fits[i].μ, fits[i].σ), x), lab="Fitted Normal($μ, $σ)")
  end
  plot(p..., layout=(4, 1))
  savefig("$ProjDir/Fig-part-2.png")

end

# End of `intro/intro-part-2.jl`
