using StatisticalRethinking

ProjDir = @__DIR__

df = sim_happiness()
precis(df) |> display

df[!, :A] = (df[:, :age] .- 18) / (65 - 18)

m6_10s = "
data {
  int <lower=1> N;
  vector[N] happiness;
  vector[N] A;
}
parameters {
  real <lower=0> sigma;
  real a;
  real bA;
}
model {
  vector[N] mu;
  sigma ~ exponential(1);
  a ~ normal(0, 1);
  bA ~ normal(0, 2);
  mu = a + bA * A;
  happiness ~ normal(mu, sigma);
}
";

tmpdir = ProjDir * "/tmp"
m6_10 = SampleModel("m6.10", m6_10s, tmpdir=tmpdir)

m6_10_data = Dict(
  :N => nrow(df),
  :happiness => df[:, :happiness],
  :A => df[:, :A],
)

rc = stan_sample(m6_10, data=m6_10_data)

if success(rc)
  p = read_samples(m6_10, output_format=:particles)
  p |> display

  dfa = read_samples(m6_10, output_format=:dataframe)
  precis(dfa) |> display

  plot(xlab="age", ylab="happiness", leg=false, title="unmarried (grey), married (blue)")
  for i in 1:nrow(df)
    if df[i, :married] == 1
      scatter!([df[i, :age]], [df[i, :happiness]], color=:darkblue)
    else
      scatter!([df[i, :age]], [df[i, :happiness]], color=:lightgrey)
    end
  end
  savefig("$(ProjDir)/Fig-24.png")
end
