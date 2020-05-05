using StatisticalRethinking

ProjDir = @__DIR__

df = sim_happiness()
precis(df) |> display

df[!, :mid] = df[:, :married] .+ 1
df = df[df.age .> 17, :]

# or
#df = filter(row -> row[:age] > 17, df);

df[!, :A] = (df[:, :age] .- 18) / (65 - 18)

m6_9s = "
data {
  int <lower=1> N;
  vector[N] happiness;
  vector[N] A;
  int <lower=1>  k;
  int mid[N];
}
parameters {
  real <lower=0> sigma;
  vector[k] a;
  real bA;
}
model {
  vector[N] mu;
  sigma ~ exponential(1);
  a ~ normal(0, 1);
  bA ~ normal(0, 2);
  for (i in 1:N) {
    mu[i] = a[mid[i]] + bA * A[i];
  }
  happiness ~ normal(mu, sigma);
}
";

m6_9 = SampleModel("m6.9", m6_9s)

m6_9_data = Dict(
  :N => nrow(df),
  :k => 2,
  :happiness => df[:, :happiness],
  :A => df[:, :A],
  :mid => df[:, :mid]
)

rc = stan_sample(m6_9, data=m6_9_data)

if success(rc)
  p = read_samples(m6_9, output_format=:particles)
  p |> display
  println()
  dfa = read_samples(m6_9, output_format=:dataframe)
  precis(dfa) |> display
end
