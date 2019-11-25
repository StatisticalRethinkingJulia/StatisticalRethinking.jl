if !(sample_file == nothing)

  # Turn chains into DataFrames

  # Separate df for each chain

  dfs = DataFrame(chn, append_chains=false);

  # All chains appended

  dfsa = DataFrame(chn);

  # Allocate array of Normal fits

  fits = Vector{Normal{Float64}}(undef, 4);

  # Fit a normal distribution to each chain.

  println("\nFitted Normal distribution to each Chain:\n")
  for i in 1:4
    fits[i] = fit_mle(Normal, dfs[i][:, :theta])
    println(fits[i])
  end

  # Plot the 4 chains

  mu_avg = sum([fits[i].μ for i in 1:4]) / 4.0;
  sigma_avg = sum([fits[i].σ for i in 1:4]) / 4.0;

  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
  x = 0:0.001:1
  for i in 1:4
    μ = round(fits[i].μ, digits=2)
    σ = round(fits[i].σ, digits=2)
    p[i] = density(dfsa[:, :theta], lab="Chain $i density",
       xlim=(0.45, 1.0), title="$(N) data points")
    plot!(p[i], x, pdf.(Normal(fits[i].μ, fits[i].σ), x), lab="Fitted Normal($μ, $σ)")
  end
  plot(p..., layout=(4, 1))
  savefig("$ProjDir/Fig-part_2.pdf")

  # Show the hpd region

  hpd(chn, alpha=0.055)

  # Compute the hpd bounds for plotting using all 4 chains

  dfsa = DataFrame(chn);
  bnds = quantile(dfsa[:, :theta], [0.045, 0.945])

  # Show hpd region

  println("\nHPD region for all 4 chains:\n")
  println("$bnds\n")

end

# End of `intro/intro_part_2.jl`
