# Load Julia packages (libraries) needed  for the snippets in chapter 0

@time using StatisticalRethinking, StanSample, CSV
@time using LinearAlgebra, DataFrames, StatsBase
@time using KernelDensity, MonteCarloMeasurements, StatsPlots

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
	df = read_samples(sm; output_format=:dataframe)
	q = quap(df)
  display(q)

	# Check equivalence of Stan samples and Particles.
	mu_range = 152.0:0.01:157.0
	plot(mu_range, ecdf(sample(df[:, :mu], 10000))(mu_range),
		xlabel="ecdf", ylabel="mu", lab="Stan samples")
	plot!(mu_range, ecdf(sample(q.mu, 10000))(mu_range),
		lab="Particles samples")
	savefig("$ProjDir/Fig-34-36.1.png")

  dfa = read_samples(sm; output_format=:dataframes)
  plts = Vector{Plots.Plot{Plots.GRBackend}}(undef, size(dfa[1], 2))

  for (indx, par) in enumerate(names(dfa[1]))
    for i in 1:size(dfa,1)
      if i == 1
        plts[indx] = plot()
      end
      e = ecdf(dfa[i][:, par])
      r = range(minimum(e), stop=maximum(e), length=length(e.sorted_values))
      plts[indx] = plot!(plts[indx], r, e(r), lab = "ECDF $(par) in chain $i")
    end
  end
  plot(plts..., layout=(2,1))
  savefig("$(ProjDir)/Fig-34-36.2.png")

end

# End of `clip-34-36.jl`
