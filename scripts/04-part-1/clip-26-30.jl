# Load Julia packages (libraries) needed  for the snippets in chapter 04

using StatisticalRethinking, StanSample, LinearAlgebra

# ### Snippet 4.26

ProjDir = @__DIR__
df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

# ### Snippet 4.27

heightsmodel = "
// Inferring the mean and std
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
  sigma ~ uniform(0 , 50);

  // Observed heights
  h ~ normal(mu, sigma);
}
";

sm = SampleModel("heights", heightsmodel);

heightsdata = Dict("N" => length(df2[:, :height]), "h" => df2[:, :height]);

(sample_file, log_file) = stan_sample(sm, data=heightsdata);

if sample_file !== nothing
	println()
	chn = read_samples(sm)
	sigma_mu = Array(chn)
	@show p = Particles(sigma_mu)
	println()

# ### Snippet 4.28 & 4.29

	quap(DataFrame(chn)) |> display

end

# ### Snippet 4.30

# If required, startring values can be passed in to `stan_sample()`
# See `?stan_sample`

# End of `clip-26-30.jl`
