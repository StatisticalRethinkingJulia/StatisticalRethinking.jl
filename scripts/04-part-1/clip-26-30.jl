# Load Julia packages (libraries) needed for clip4

using StatisticalRethinking

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

rc = stan_sample(sm, data=heightsdata);

if success(rc)
	println()

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
  savefig("$(ProjDir)/Fig-31.png")

	p = read_samples(sm; output_format=:particles)
  display(p)
	println()

# ### Snippet 4.28 & 4.29

  df = read_samples(sm; output_format=:dataframe)
	q = quap(df)
  q |> display

end

# ### Snippet 4.30

# If required, starting values can be passed in to `stan_sample()`
# See `?stan_sample`

# End of `clip-26-30.jl`
