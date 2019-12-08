using StatisticalRethinking, StanSample

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df2 = filter(row -> row[:age] >= 18, df)
first(df2, 5)

heightsmodel = "
// Inferring a Rate
data {
  int N;
  real<lower=0> h[N];
}
parameters {
  real<lower=0> sigma;
  real<lower=0,upper=250> mu;
}
model {
  // Priors for mu and sigma
  mu ~ normal(178, 20);
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}
";

sm = SampleModel("heights", heightsmodel);

heightsdata = Dict("N" => length(df2[:, :height]), "h" => df2[:, :height]);

(sample_file, log_file) = stan_sample(sm, data=heightsdata);

if sample_file !== nothing
  chn = read_samples(sm)
  show(chn)

  serialize("m4.1s.jls", chn)
  chn2 = deserialize("m4.1s.jls")

  show(chn2)

end

# end of m4.1s