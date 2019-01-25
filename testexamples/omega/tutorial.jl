using Omega, StatPlots
gr(size=(400,400))

@show rand(uniform(0, 1))

weight=β(2.0, 2.0)
beta_samples=rand(weight, 10000);
density(beta_samples)

nflips=9;
coinflips_ = [bernoulli(weight) for i in 1:nflips];
coinflips = randarray(coinflips_);
rand(coinflips)

obs = [true, true, false, true, true, false, false, true, true]
weight_samples=rand(weight, coinflips==obs, 10, RejectionSample)
density(weight_samples)