# Load Julia packages (libraries) needed.

using StatisticalRethinking
using MCMCChains, StatsPlots

ProjDir = @__DIR__

# ### snippet 5.1

println()
df = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';');
#first(df, 5) |> display

# ### snippet 5.1

scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])
println()

m5_1 = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] D; // Outcome
 vector[N] A; // Predictor
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
  mu = a + bA * A;
  D ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m_5_1 = SampleModel("m5_1", m5_1);

# Input data for cmdstan

ad_data = Dict("N" => size(df, 1), "D" => df[!, :Divorce_s],
    "A" => df[!, :MedianAgeMarriage_s]);

# Sample using StanSample

rc = stan_sample(m_5_1, data=ad_data);

if success(rc)

  # Describe the draws

  chns = read_samples(m_5_1; output_format=:mcmcchains)
  #show(chns)
  plot(chns)
  savefig("$(ProjDir)/m5.1chains.png")

  println()
  sdf = read_summary(m_5_1)
  #sdf |> display

  # Result rethinking

  rethinking = "
           mean   sd  5.5% 94.5%
    a      0.00 0.10 -0.16  0.16
    bA    -0.57 0.11 -0.74 -0.39
    sigma  0.79 0.08  0.66  0.91
  "
end
