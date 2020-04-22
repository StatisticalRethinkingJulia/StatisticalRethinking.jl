# Load Julia packages (libraries) needed.

using StatisticalRethinking

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
scale!(df, [:kcal_per_g, :perc_fat, :perc_lactose])
println()

m_6_4 = "
data{
  int <lower=1> N;              // Sample size
  vector[N] K;
  vector[N] L;
}
parameters{
  real a;
  real bL;
  real<lower=0> sigma;
}
model{
  vector[N] mu;
  sigma ~ exponential( 1 );
  a ~ normal( 0 , 0.2 );
  bL ~ normal( 0 , 0.5 );
  mu = a + bL * L;
  K ~ normal( mu , sigma );
}
";

# Define the SampleModel and set the output format to :mcmcchains.

tmpdir = ProjDir * "/tmp"
m6_4s = SampleModel("m6.3", m_6_4, 
  #tmpdir=tmpdir
);

# Input data for cmdstan

m6_4_data = Dict("N" => size(df, 1), "L" => df[:, :perc_lactose_s],
    "K" => df[!, :kcal_per_g_s]);

# Sample using StanSample

rc = stan_sample(m6_4s, data=m6_4_data);

if success(rc)

  # Describe the draws

  dfa6_4 = read_samples(m6_4s; output_format=:dataframe)
  p = Particles(dfa6_4)
  q = quap(dfa6_4)
  q |> display
  hpdi(p.bL.particles, alpha=0.11) |> display

end
