
using StatisticalRethinking, StatsPlots

ProjDir = @__DIR__

N = 200
p = 0.1

df = DataFrame(
  nw = rand(Normal(), N),
  tw = rand(Normal(), N)
)
df[!, :s] = df[:, :tw] + df[:, :nw]

q = quantile(s, 1-p)

selected_df = filter(row -> row.s > q, df)
unselected_df = filter(row -> row.s <= q, df)

println("\nCorrelation = $(cor(selected_df[:, :nw], selected_df[:, :tw]))\n")

m_6_0 = "
data {
  int <lower=1> N;
  vector[N] nw;
  vector[N] tw;
}

parameters {
  real a;
  real aS;
  real <lower=0> sigma;
}

model {
  vector[N] mu;
  mu = a + aS * nw;
  a ~ normal(0, 5.0);
  aS ~ normal(0, 1.0);
  sigma ~ exponential(1);
  tw ~ normal(mu, sigma);
}
";

m6_0s = SampleModel("m6.0s", m_6_0)

m_6_0_data = Dict(
  :nw => selected_df[:, :nw],
  :tw => selected_df[:, :tw],
  :N => size(selected_df, 1)
)

rc = stan_sample(m6_0s, data=m_6_0_data)

if success(rc)

  p = read_samples(m6_0s, output_format=:particles)
  display(p)

  x = -2.0:0.01:3.0
  plot(xlabel="newsworthiness", ylabel="trustworthiness",
    title="Science distortion")
  scatter!(selected_df[:, :nw], selected_df[:, :tw], color=:blue, lab="selected")
  scatter!(unselected_df[:, :nw], unselected_df[:, :tw], color=:lightgrey, lab="unselected")
  plot!(x, mean(p.a) .+ mean(p.aS) .* x, lab="Regression line")


  savefig("$(ProjDir)/Fig-01.png")

end