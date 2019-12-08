using StatisticalRethinking, StanOptimize

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
  mu ~ normal(178, 40);
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}
";

sm = OptimizeModel("heights", heightsmodel);

heightsdata = Dict("N" => length(df2[:, :height]), 
  "h" => df2[:, :height]);

# Optimize using cmdstan
 
(optim_file, log_file) = stan_optimize(sm, data=heightsdata);

# Describe the draws

if !(optim_file == nothing)
  optim_stan, cnames = read_optimize(sm)
  println("\nStan_optimize estimates of mean:\n")
  display(optim_stan)
end

# end of m4.2s