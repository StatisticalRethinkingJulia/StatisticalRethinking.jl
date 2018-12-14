// Inferring a Rate
data {
  int N;
  real<lower=0> h[N];
}
parameters {
  real<lower=0> sigma;
  real<lower=0,upper=250> mu;
}
model {
  // Priors for mu and sigma
  mu ~ uniform(100, 250);
  sigma ~ cauchy( 0 , 1 );

  // Observed heights
  h ~ normal(mu, sigma);
}