data {
  int N;
  real h[N];
}
parameters {
  real<lower=0> sigma;
  real<lower=136.525,upper=179.07> mu;
}
model {
  // Priors for mu and sigma
  mu ~ normal(178, 0.1);
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}