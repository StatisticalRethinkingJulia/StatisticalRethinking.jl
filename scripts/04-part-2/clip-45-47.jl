# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, StanSample
ProjDir = @__DIR__

# ### snippet 4.7

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

# Define the Stan language model

weightsmodel = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] height; // Predictor
 vector[N] weight; // Outcome
}

parameters {
 real alpha; // Intercept
 real beta; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

model {
 height ~ normal(alpha + weight * beta , sigma);
}

generated quantities {
} 
";

# Define the Stanmodel and set the output format to :mcmcchains.

sm = SampleModel("weights", weightsmodel);

# Input data for cmdstan

heightsdata = Dict(
  "N" => length(df2[:, :height]), 
  "height" => df2[:, :height],
  "weight" => df2[:, :weight]
);

# Sample using cmdstan

rc = stan_sample(sm, data=heightsdata);

# Plot estimates using the N = [10, 50, 150, 352] observations

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
nvals = [10, 50, 150, 352];

for i in 1:length(nvals)

  N = nvals[i]

  heightsdataN = Dict(
    "N" => N, 
    "height" => df2[1:N, :height], 
    "weight" => df2[1:N, :weight]
  )
  

  rc = stan_sample(sm, data=heightsdataN)

  if success(rc)

    xi = 30.0:0.1:65.0
    chnN = read_samples(sm)
    sample_df = DataFrame(chnN)
    p[i] = scatter(df2[1:N, :weight], df2[1:N, :height], 
      leg=false, xlab="weight_c")
    for j in 1:N
      yi = sample_df[j, :alpha] .+ sample_df[j, :beta]*xi
      plot!(p[i], xi, yi, title="N = $N")
    end

    scatter!(p[i], df2[1:N, :weight], df2[1:N, :height], leg=false,
      color=:darkblue, xlab="weight")

  end

end

plot(p..., layout=(2, 2))
savefig("$ProjDir/Fig-45-47.png")

# End of `04/clip-45-47s.jl`
