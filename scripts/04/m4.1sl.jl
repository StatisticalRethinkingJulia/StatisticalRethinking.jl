using StatisticalRethinking, StanSample

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df2 = filter(row -> row[:age] >= 18, df)
first(df2, 5)

heightsmodel = "
// Inferring a Rate
data {
  int<lower=1> N;
  real<lower=0> h[N];
}
parameters {
  real mu;
  real<lower=0,upper=250> sigma;
}
model {
  // Priors for mu and sigma
  target += normal_lpdf(mu | 178, 20);

  // Observed heights
  target += normal_lpdf(h | mu, sigma);
}
";

sm = SampleModel("heights", heightsmodel);

heightsdata = Dict("N" => length(df2[:, :height]), "h" => df2[:, :height]);

(sample_file, log_file) = stan_sample(sm, data=heightsdata);

if sample_file !== nothing
  chn = read_samples(sm)
  show(chn)
end

# end of m4.1sl