# Load Julia packages

using StatisticalRethinking, UnicodePlots

ProjDir = @__DIR__

N = 100
df = DataFrame(
  :h0 => rand(Normal(10,2 ), N),
  :treatment => vcat(zeros(Int, Int(N/2)), ones(Int, Int(N/2)))
);

df[!, :fungus] = [rand(Binomial(1, 0.5 - 0.4 * df[i, :treatment]), 1)[1] for i in 1:N]
df[!, :h1] = [df[i, :h0] + rand(Normal(5 - 3 * df[i, :fungus]), 1)[1] for i in 1:N]

println()

first(df, 10)

na = precis(df)
na |> display

UnicodePlots.histogram(df[:, :h0], xlabel="h0 count") |> display
UnicodePlots.histogram(df[:, :h1], xlabel="h1 count") |> display

scale!(df, [:h0, :treatment, :fungus, :h1])

sim_p = DataFrame(
  :sim_p => rand(LogNormal(0, 0.25), 10000);
)
precis(sim_p)
UnicodePlots.histogram(sim_p[:, :sim_p], xlabel="sim_p") |> display

m6_6s = "
data {
  int <lower=1> N;
  vector[N] h0;
  vector[N] h1;
}
parameters{
  real<lower=0> p;
  real<lower=0> sigma;
}
model {
  vector[N] mu;
  p ~ lognormal(0, 0.25);
  sigma ~ exponential(1);
  mu = h0 * p;
  h1 ~ normal(mu, sigma);
}
"

m6_6_data = Dict(
  :N => nrow(df),
  :h0 => df[:, :h0],
  :h1 => df[:, :h1]
)

tmpdir = ProjDir*"/tmp"
sm = SampleModel("m6.6", m6_6s, tmpdir=tmpdir)

rc = stan_sample(sm; data=m6_6_data)

if success(rc)
  dfa = read_samples(sm; output_format=:dataframe);
  p = Particles(dfa)
  display(p)
  display(precis(dfa))
  UnicodePlots.histogram(dfa[:, :p], xlabel="p") |> display


end