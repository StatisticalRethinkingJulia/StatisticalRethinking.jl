# Load Julia packages

using StatisticalRethinking

ProjDir = @__DIR__

N = 100
df = DataFrame(
  :h0 => rand(Normal(10,2 ), N),
  :treatment => vcat(zeros(Int, Int(N/2)), ones(Int, Int(N/2)))
);
df[!, :fungus] = [rand(Binomial(1, 0.5 - 0.4 * df[i, :treatment]), 1)[1] for i in 1:N]
df[!, :h1] = [df[i, :h0] + rand(Normal(5 - 3 * df[i, :fungus]), 1)[1] for i in 1:N]

# Execute m6.7
include("$(ProjDir)/m6.7.jl")

m6_8s = "
data {
  int <lower=1> N;
  vector[N] h0;
  vector[N] h1;
  vector[N] treatment;
}
parameters{
  real a;
  real bt;
  real<lower=0> sigma;
}
model {
  vector[N] mu;
  vector[N] p;
  a ~ lognormal(0, 0.2);
  bt ~ normal(0, 0.5);
  sigma ~ exponential(1);
  for ( i in 1:N ) {
    p[i] = a + bt*treatment[i];
    mu[i] = h0[i] * p[i];
  }
  h1 ~ normal(mu, sigma);
}
"

m6_8_data = Dict(
  :N => nrow(df),
  :h0 => df[:, :h0],
  :h1 => df[:, :h1],
  :treatment => df[:, :treatment]
)

m6_8 = SampleModel("m6.8", m6_8s)

rc = stan_sample(m6_8; data=m6_8_data)

if success(rc)
  dfa = read_samples(m6_8; output_format=:dataframe);
  p = Particles(dfa)
  display(p)
  display(precis(dfa))
  UnicodePlots.histogram(dfa[:, :bt], xlabel="p") |> display

  plotcoef([m6_7, m6_8], [:bt, :bf], "$(ProjDir)/Fig-17.png")
end