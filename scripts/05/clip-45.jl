# Load Julia packages (libraries) needed.

using StatisticalRethinking

ProjDir = @__DIR__

# ### snippet 5.44

println()
df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';');
df = filter(row -> row[:age] > 18, df)

scale!(df, [:height, :weight])

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
    vector[2] bA;
    real<lower=0,upper=50> sigma;
}
model{
    vector[N] mu;
    sigma ~ uniform( 0 , 50 );
    a ~ normal( 178 , 20 );
    for ( i in 1:N ) {
        mu[i] = a[sex[i]] + bA[sex[i]] * weight[i];
    }
    height ~ normal( mu , sigma );
}
";

# Define the SampleModel and set the output format to :mcmcchains.

tmpdir = ProjDir * "/tmp"
m5_8s = SampleModel("m5.8", m_5_8);

# Input data for cmdstan

df[!, :sex] = [df[i, :male] == 1 ? 2 : 1 for i in 1:size(df, 1)]
df_m = filter(row -> row[:sex] == 2, df)
df_f = filter(row -> row[:sex] == 1, df)

m5_8_data = Dict("N" => size(df, 1), "male" => df[:, :male],
    "weight" => df[:, :weight_s], "height" => df[:, :height], 
    "age" => df[:, :age], "sex" => df[:, :sex])

# Sample using StanSample

rc = stan_sample(m5_8s, data=m5_8_data);

if success(rc)

  # Describe the draws

  dfa = read_samples(m5_8s; output_format=:dataframe)
  println("Normal estimate:")
  p = Particles(dfa)
  p |> display
  println("Quap estimates:")
  quap(dfa) |> display

  x = -2:0.01:2
  plot(title="Intercepts and slopes by sex")
  plot!(x, mean(p[Symbol("a.1")]) .+ mean(p[Symbol("bA.1")]) * x, lab="Female")
  plot!(x, mean(p[Symbol("a.2")]) .+ mean(p[Symbol("bA.2")]) * x, lab="Male")
  scatter!(df_m[:, :weight_s], df_m[:, :height], lab="Male data")
  scatter!(df_f[:, :weight_s], df_f[:, :height], lab="Female data")

  savefig("$(ProjDir)/Fig-45.png")

end
