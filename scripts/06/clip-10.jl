# Load Julia packages (libraries) needed.

using StatisticalRethinking, StatsPlots

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
scale!(df, [:kcal_per_g, :perc_fat, :perc_lactose])
println()

m_6_5 = "
data{
  int <lower=1> N;              // Sample size
  vector[N] K;
  vector[N] F;
  vector[N] L;
}
parameters{
  real a;
  real bL;
  real bF;
  real<lower=0> sigma;
}
model{
  vector[N] mu;
  sigma ~ exponential( 1 );
  a ~ normal( 0 , 0.2 );
  bL ~ normal( 0 , 0.5 );
  bF ~ normal( 0 , 0.5 );
  mu = a + bL * L + bF * F;
  K ~ normal( mu , sigma );
}
";

# Define the SampleModel and set the output format to :mcmcchains.

tmpdir = ProjDir * "/tmp"
m6_5s = SampleModel("m6.5", m_6_5, 
  #tmpdir=tmpdir
);

# Input data for cmdstan

m6_5_data = Dict("N" => size(df, 1), "L" => df[:, :perc_lactose_s],
    "F" => df[:, :perc_fat_s], "K" => df[!, :kcal_per_g_s]);

# Sample using StanSample

rc = stan_sample(m6_5s, data=m6_5_data);

if success(rc)

  # Describe the draws

  dfa = read_samples(m6_5s; output_format=:dataframe)
  p = Particles(dfa)
  p |> display

  r1 = plotcoef(m6_5s, [:a, :bF, :bL, :sigma], "$(ProjDir)/Fig-10.png",
    "Multicollinearity for milk model using quap()", quap)
  r1 |> display

end
