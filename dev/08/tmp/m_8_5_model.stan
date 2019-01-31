data{
  int N;
  vector[N] y;
}
parameters{
  real sigma;
  real alpha;
  real a1;
  real a2;
}
model{
  real mu;
  a1 ~ normal(0, 10);
  a2 ~ normal(0, 10);
  mu = a1 + a2;
  y ~ normal( mu , sigma );
}