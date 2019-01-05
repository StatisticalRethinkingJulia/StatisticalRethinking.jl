data {
 int < lower = 1 > N; // Sample size
 vector[N] divorce; // Predictor
 vector[N] median_age; // Outcome
}

parameters {
 real a; // Intercept
 real bA; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

transformed parameters {
  vector[N] mu; // Intermediate mu
  for (i in 1:N)
    mu[i] = a + bA*median_age[i];
}

model {
  a ~ normal(10, 10);
  bA ~ normal(0, 1);
  sigma ~ uniform(0, 10);
  divorce ~ normal(mu , sigma);
}

generated quantities {
}