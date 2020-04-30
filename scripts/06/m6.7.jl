# Load Julia packages

using StatisticalRethinking

ProjDir = @__DIR__

m6_7s = "
data {
  int <lower=1> N;
  vector[N] h0;
  vector[N] h1;
  vector[N] treatment;
  vector[N] fungus;
}
parameters{
  real a;
  real bt;
  real bf;
  real<lower=0> sigma;
}
model {
  vector[N] mu;
  vector[N] p;
  a ~ lognormal(0, 0.2);
  bt ~ normal(0, 0.5);
  bf ~ normal(0, 0.5);
  sigma ~ exponential(1);
  for ( i in 1:N ) {
    p[i] = a + bt*treatment[i] + bf*fungus[i];
    mu[i] = h0[i] * p[i];
  }
  h1 ~ normal(mu, sigma);
}
"

m6_7_data = Dict(
  :N => nrow(df),
  :h0 => df[:, :h0],
  :h1 => df[:, :h1],
  :fungus => df[:, :fungus],
  :treatment => df[:, :treatment]
)

m6_7 = SampleModel("m6.7", m6_7s)
rc = stan_sample(m6_7; data=m6_7_data)

if success(rc)

  p = read_samples(m6_7; output_format=:particles);
  display(p)
  
end
