# Load Julia packages (libraries) needed.

using StatisticalRethinking

ProjDir = @__DIR__

# ### snippet 5.1

println()
df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';');
first(df, 5) |> display

# ### snippet 5.1

scale!(df, [:WaffleHouses, :Divorce])
println()

wd = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] D; // Outcome (Divorce rate)
 vector[N] W; // Predictor ()
}

parameters {
 real a; // Intercept
 real bA; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 0.2);         //Priors
  bA ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bA * W;
  D ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

sm1 = SampleModel("Fig5.1", wd);

# Input data for cmdstan

wd_data = Dict("N" => size(df, 1), "D" => df[:, :Divorce_s],
    "W" => df[:, :WaffleHouses_s]);

# Sample using StanSample

rc = stan_sample(sm1, data=wd_data);

if success(rc)

  # Plot regression line using means and observations

  dfs = read_samples(sm1; output_format=:dataframe)
  println("\nSample Particles summary:"); p = Particles(dfs); p |> display
  println("\nQuap Particles estimate:"); q = quap(dfs); display(q)

  plotbounds(
    df, :WaffleHouses, :Divorce,
    dfs, [:a, :bA, :sigma];
    bounds=[:predicted, :sample, :hpdi],
    fig="$ProjDir/Fig-00.png",
    title="Divorce rate vs. waffle houses per million" * "\nshowing predicted and hpd range",
    xlab="WaffleHouses per million",
    ylab="Divorce rate"
  )


end

# End of `05/m5.1s.jl`

