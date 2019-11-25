if !(sample_file == nothing)

  # Turn chains into DataFrames

  # Separate df for each chain

  dfs = DataFrame(chn, append_chains=false);

  # All chains appended

  dfsa = DataFrame(chn);

  # Fit a normal distribution to each chain.

  fits_mu = zeros(4)
  fits_sigma = zeros(4)
  for i in 1:4
    fits_mu[i] = fit_mle(Normal, dfs[i][:, :theta]).μ
    fits_sigma[i] = fit_mle(Normal, dfs[i][:, :theta]).σ
  end

  # Plot the 4 chains

  mu_avg = sum([fits_mu[i] for i in 1:4]) / 4.0;
  sigma_avg = sum([fits_sigma[i] for i in 1:4]) / 4.0;

    # Compute the hpd bounds for plotting using all 4 chains

  dfsa = DataFrame(chn);
  bnds = quantile(dfsa[:, :theta], [0.045, 0.945])

end
