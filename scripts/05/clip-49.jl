# Load Julia packages (libraries) needed.

using StatisticalRethinking

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "milk.csv"), delim=';');
df = filter(row -> !(row[:neocortex_perc] == "NA"), df);
df[!, :neocortex_perc] = parse.(Float64, df[:, :neocortex_perc])
df[!, :lmass] = log.(df[:, :mass])

df[!, :clade_id] = Int.(indexin(df[:, :clade], unique(df[:, :clade])))
scale!(df, [:kcal_per_g, :neocortex_perc, :lmass])
println()

c_id= [4, 4, 4, 4, 4, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1]
kcal_per_g = [
  0.49, 0.51, 0.46, 0.48, 0.60, 0.47, 0.56, 0.89,
  0.91, 0.92, 0.80, 0.46, 0.71, 0.71, 0.73, 0.68, 0.72,
  0.97, 0.79, 0.84, 0.48, 0.62, 0.51, 0.54, 0.49, 0.53, 0.48, 0.55, 0.71]

df2=DataFrame(:clade_id => c_id, :K => kcal_per_g)

m_5_9 = "
data{
  int <lower=1> N;              // Sample size
  int <lower=1> k;
  vector[N] K;
  int clade_id[N];
}
parameters{
  vector[k] a;
  real<lower=0> sigma;
}
model{
  vector[N] mu;
  sigma ~ exponential( 1 );
  a ~ normal( 0 , 0.5 );
  for ( i in 1:N ) {
      mu[i] = a[clade_id[i]];
  }
  K ~ normal( mu , sigma );
}
";

# Define the SampleModel and set the output format to :mcmcchains.

tmpdir = ProjDir * "/tmp"
m5_9s = SampleModel("m5.9", m_5_9, tmpdir=tmpdir);

# Input data for cmdstan

m5_9_data = Dict("N" => size(df, 1), "clade_id" => df[:, :clade_id],
    "K" => df[!, :kcal_per_g_s], "k" => length(unique(df[:, :clade])));

# Sample using StanSample

rc = stan_sample(m5_9s, data=m5_9_data);

if success(rc)

  # Describe the draws

  dfa9 = read_samples(m5_9s; output_format=:dataframe)
  p = Particles(dfa9)
  q = quap(dfa9)
  q |> display

  rethinking = "
           mean   sd  5.5% 94.5% n_eff Rhat4
    a[1]  -0.47 0.24 -0.84 -0.09   384     1
    a[2]   0.35 0.25 -0.07  0.70   587     1
    a[3]   0.64 0.28  0.18  1.06   616     1
    a[4]  -0.53 0.29 -0.97 -0.05   357     1
    sigma  0.81 0.11  0.64  0.98   477     1
  ";

  xbar = mean(df[:, :lmass])
  end
