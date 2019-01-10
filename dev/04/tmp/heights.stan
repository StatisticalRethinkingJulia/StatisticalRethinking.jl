// Inferring a Rate
data {
  int N;
  real h[N];
}
parameters {
  real<lower=0> sigma;
  real<lower=-18.072092613636357,upper=24.47290738636363> mu;
}
model {
  // Priors for mu and sigma
  mu ~ normal(178, 20);
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}