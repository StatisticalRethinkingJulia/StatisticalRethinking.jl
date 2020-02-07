# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, StanSample, LinearAlgebra
using DataFrames, CSV
using KernelDensity, MonteCarloMeasurements

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')

# Use only adults

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
  mu ~ normal(178, 0.1);
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
	df = read_samples(sm; output_format=:dataframe)
	q = quap(df)
  q |> display
end

# End of `clip-31.jl`
