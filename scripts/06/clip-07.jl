using StatisticalRethinking

ProjDir = @__DIR__

N = 100

# Snippet 6.1

df = DataFrame(
  height = rand(Normal(10, 2), N),
  leg_prop = rand(Uniform(0.4, 0.5), N),
)

df[!, :leg_left] = df[:, :leg_prop] .* df[:, :height] + rand(Normal(0, 0.02), N)
df[!, :leg_right] = df[:, :leg_prop] .* df[:, :height] + rand(Normal(0, 0.02), N)

# Snippet 6.2

m_6_2 = "
data {
  int <lower=1> N;
  vector[N] H;
  vector[N] LL;
}

parameters {
  real a;
  real bL;
  real <lower=0> sigma;
}

model {
  vector[N] mu;
  mu = a + bL * LL;
  a ~ normal(10, 100);
  bL ~ normal(2, 10);
  sigma ~ exponential(1);
  H ~ normal(mu, sigma);
}
";

m6_2s = SampleModel("m6.2s", m_6_2)

m_6_2_data = Dict(
  :H => df[:, :height],
  :LL => df[:, :leg_left],
  :N => size(df, 1)
)

rc = stan_sample(m6_2s, data=m_6_2_data)

if success(rc)

  p = read_samples(m6_2s, output_format=:particles)
  display(p)

  chns = read_samples(m6_2s, output_format=:mcmcchains)
  plot(chns)
  savefig("$(ProjDir)/Fig-07.png")

end