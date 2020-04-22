# Load Julia packages (libraries) needed.

using StatisticalRethinking

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
scale!(df, [:kcal_per_g, :perc_fat, :perc_lactose])
println()

m_6_3 = "
data{
  int <lower=1> N;              // Sample size
  vector[N] K;
  vector[N] F;
}
parameters{
  real a;
  real bF;
  real<lower=0> sigma;
}
model{
  vector[N] mu;
  sigma ~ exponential( 1 );
  a ~ normal( 0 , 0.2 );
  bF ~ normal( 0 , 0.5 );
  mu = a + bF * F;
  K ~ normal( mu , sigma );
}
";

# Define the SampleModel and set the output format to :mcmcchains.

tmpdir = ProjDir * "/tmp"
m6_3s = SampleModel("m6.3", m_6_3, 
  #tmpdir=tmpdir
);

# Input data for cmdstan

m6_3_data = Dict("N" => size(df, 1), "F" => df[:, :perc_fat_s],
    "K" => df[!, :kcal_per_g_s]);

# Sample using StanSample

rc = stan_sample(m6_3s, data=m6_3_data);

if success(rc)

  # Describe the draws

  dfa6_3 = read_samples(m6_3s; output_format=:dataframe)
  p = Particles(dfa6_3)
  q = quap(dfa6_3)
  q |> display
  hpdi(p.bF.particles, alpha=0.11) |> display

end
