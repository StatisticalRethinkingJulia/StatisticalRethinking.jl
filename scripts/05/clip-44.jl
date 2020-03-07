# Load Julia packages (libraries) needed.

using StatisticalRethinking

ProjDir = @__DIR__

# ### snippet 5.44

println()
df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';');
#scale!(df, [:height, :weight])

m_5_8 = "
data{
    int N;
    int male[N];
    vector[N] age;
    vector[N] weight;
    vector[N] height;
    int sex[N];
}
parameters{
    vector[2] a;
    real<lower=0,upper=50> sigma;
}
model{
    vector[N] mu;
    sigma ~ uniform( 0 , 50 );
    a ~ normal( 178 , 20 );
    for ( i in 1:N ) {
        mu[i] = a[sex[i]];
    }
    height ~ normal( mu , sigma );
}
";

# Define the SampleModel and set the output format to :mcmcchains.

tmpdir = ProjDir * "/tmp"
m5_8s = SampleModel("m5.8", m_5_8);

# Input data for cmdstan

df[!, :sex] = [df[i, :male] == 1 ? 2 : 1 for i in 1:size(df, 1)]

m5_8_data = Dict("N" => size(df, 1), "male" => df[:, :male],
    "weight" => df[:, :weight], "height" => df[:, :height], 
    "age" => df[:, :age], "sex" => df[:, :sex])

# Sample using StanSample

rc = stan_sample(m5_8s, data=m5_8_data);

if success(rc)

  # Describe the draws

  dfa = read_samples(m5_8s; output_format=:dataframe)
  println("Normal estimate:")
  p = Particles(dfa) |> display
  println("Quap estimates:")
  quap(dfa) |> display

end
