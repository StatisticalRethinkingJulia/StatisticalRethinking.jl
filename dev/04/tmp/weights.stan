data {
 int < lower = 1 > N;
 vector[N] height;
 vector[N] weight;
}

parameters {
 real alpha;
 real beta;
 real < lower = 0, upper = 50 > sigma;
}

model {
  alpha ~ normal(178, 100);
  beta ~ normal(0, 10);
  sigma ~ uniform(0, 50);
  height ~ normal(alpha + beta*weight , sigma);
}

generated quantities {
}