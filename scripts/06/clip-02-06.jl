using StatisticalRethinking
using GLM
gr(size=(600,500))

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

m_6_1 = "
data {
  int <lower=1> N;
  vector[N] H;
  vector[N] LL;
  vector[N] LR;
}

parameters {
  real a;
  real bL;
  real bR;
  real <lower=0> sigma;
}

model {
  vector[N] mu;
  mu = a + bL * LL + bR * LR;
  a ~ normal(10, 100);
  bL ~ normal(2, 10);
  bR ~ normal(2, 10);
  sigma ~ exponential(1);
  H ~ normal(mu, sigma);
}
";

m6_1s = SampleModel("m6.1s", m_6_1,
  method=StanSample.Sample(num_samples=1000))

m_6_1_data = Dict(
  :H => df[:, :height],
  :LL => df[:, :leg_left],
  :LR => df[:, :leg_right],
  :N => size(df, 1)
)

rc = stan_sample(m6_1s, data=m_6_1_data)

if success(rc)

  p = read_samples(m6_1s, output_format=:particles)
  display(p)

  plotcoef(m6_1s, [:a, :bL, :bR, :sigma], "$(ProjDir)/Fig-02-06.1.png",
    "Multicollinearity between bL and bR")

  dfa = read_samples(m6_1s, output_format=:dataframe)

  # Fit a linear regression

  println()
  m = lm(@formula(bL ~ bR), dfa)
  display(m)

  # estimated coefficients from the model

  coefs = coef(m)

  p1 = plot(xlabel="bR", ylabel="bL", lab="bL ~ bR")
  plot!(p1, dfa[:, :bR], dfa[:, :bL])
  p2 = density(p.bR.particles + p.bL.particles, xlabel="sum of bL and bR",
    ylabel="Density", lab="bL + bR")
  plot(p1, p2, layout=(1, 2))
  
  savefig("$(ProjDir)/Fig-02-06.2.png")

end