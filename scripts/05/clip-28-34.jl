# Load Julia packages (libraries) needed.

using StatisticalRethinking

ProjDir = @__DIR__

# ### snippet 5.28

println()
df = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
df[!, :lmass] = log.(df[:, :mass])

# ### snippet 5.31

df = filter(row -> !(row[:neocortex_perc] == "NA"), df);
df[!, :neocortex_perc] = parse.(Float64, df[:, :neocortex_perc])
first(df, 5) |> display

# ### snippet 5.29

scale!(df, [:kcal_per_g, :neocortex_perc, :lmass])
println()

# ### snippet 5.30

m_5_5_draft = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] K; // Outcome
 vector[N] NC; // Predictor
}

parameters {
 real a; // Intercept
 real bN; // Slope (regression coefficients)
 real < lower = 0 > sigma;    // Error SD
}

model {
  vector[N] mu;               // mu is a vector
  a ~ normal(0, 1);           //Priors
  bN ~ normal(0, 1);
  sigma ~ exponential(1);
  mu = a + bN * NC;
  K ~ normal(mu , sigma);     // Likelihood
}
";

# Define the SampleModel and set the output format to :mcmcchains.

m5_5_draft = SampleModel("m5.5.draft", m_5_5_draft);

# Input data for cmdstan

m5_5_data = Dict("N" => size(df, 1), "NC" => df[!, :neocortex_perc_s],
    "K" => df[!, :kcal_per_g_s]);

# Sample using StanSample

rc = stan_sample(m5_5_draft, data=m5_5_data);

if success(rc)

  # Describe the draws

  dfa5 = read_samples(m5_5_draft; output_format=:dataframe)
  Particles(dfa5) |> display

  # Result rethinking

  rethinking = "
          mean   sd  5.5% 94.5%
    a     0.09 0.24 -0.28  0.47
    bN    0.16 0.24 -0.23  0.54
    sigma 1.00 0.16  0.74  1.26
  "

  Particles(dfa5)

  plot(title="m5.5.draft: a ~ Normal(0, 1), bN ~ Normal(0, 1)")
  x = -2:0.01:2
  for j in 1:100
    y = dfa5[j, :a] .+ dfa5[j, :bN]*x
    plot!(x, y, color=:lightgrey, leg=false)
  end
  savefig("$(ProjDir)/Fig-28-34.png")
end
