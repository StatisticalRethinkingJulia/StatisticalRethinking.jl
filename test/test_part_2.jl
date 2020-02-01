if success(rc)

  # Fit a normal distribution to the chain.

  fits_mu = fit_mle(Normal, df[:, :theta]).μ
  fits_sigma = fit_mle(Normal, df[:, :theta]).σ

  # MLE of mean and sd:

  mu_sigma = [fits_mu, fits_sigma]

  # quadratic approximation

  # Compute MAP, compare with CmndStan & MLE

  using Optim

  x0 = [0.5]
  lower = [0.2]
  upper = [1.0]

  inner_optimizer = GradientDescent()

  function loglik(x)
    ll = 0.0
    ll += log.(pdf.(Beta(1, 1), x[1]))
    ll += sum(log.(pdf.(Binomial(9, x[1]), k)))
    -ll
  end

  res = optimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))

  # MAP estimate and associated sd:

  optim_optim =[Optim.minimizer(res)[1], std(df[:, :theta], mean=mean(df[:, :theta]))]

end

# Load Julia packages (libraries) needed

using StanOptimize

# Define the OptimizeModel, use model from intro_m1.1s.jl.

sm = OptimizeModel("m1.1s", m1_1s);

# Use observations generated in intro_m1.1s.jl.

m1_1_data = Dict("N" => N, "n" => n, "k" => k);

# Sample using cmdstan
 
rc = stan_optimize(sm, data=m1_1_data);

# Describe the draws

if success(rc)
  optim_stan, cnames = read_optimize(sm)
end
