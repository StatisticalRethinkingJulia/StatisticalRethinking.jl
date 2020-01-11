# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, StanSample, LinearAlgebra

# ### Snippet 4.26

ProjDir = @__DIR__
df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

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
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}
";

# ### Snippet 4.31

sm = SampleModel("heights", heightsmodel);

heightsdata = Dict("N" => length(df2[:, :height]), "h" => df2[:, :height]);

rc = stan_sample(sm, data=heightsdata);

if success(rc)
	println()
	chn = read_samples(sm)
	sigma_mu = Array(chn)
	@show p = Particles(sigma_mu)

	# ### snippet 4.32

	# Compute cov

	println()
	@show cov(p)

	# ### snippet 4.33

	# Compute cov

	println()
	@show cor(sigma_mu)

end

# End of `clip-32-34.jl`
