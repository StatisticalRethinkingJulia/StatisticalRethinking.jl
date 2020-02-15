# Load Julia packages (libraries) needed for clip

using StatisticalRethinking, StanSample, CSV
using DataFrames, StatsPlots, Statistics

ProjDir = @__DIR__
cd(ProjDir) do

# ### Preliminary snippets

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);

# Center weight and store as weight_c

mean_weight = mean(df2[:, :weight])
df2[!, :weight_c] = (df2[:, :weight] .- mean_weight)/std(df2[:, :weight])
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
";

# Define the SampleModel.

sm = SampleModel("weights", weightsmodel);

# Input data.

heightsdata = Dict(
  "N" => length(df2[:, :height]), 
  "height" => df2[:, :height], 
  "weight" => df2[:, :weight_c]
);

# Sample using stan

rc = stan_sample(sm, data=heightsdata);

if success(rc)

  dfa = read_samples(sm; output_format=:dataframe)

  # ### Snippet 4.47

  # Show first 5 draws of correlated parameter values in chain 1

  println()
  dfa[1:5,:] |> display
  println()

  # ### Snippets 4.48 & 4.49

  # Plot estimates using the N = [10, 50, 150, 352] observations

  nvals = [10, 50, 150, 352];

  # Create the 4 nvals plots

  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
  for i in 1:length(nvals)
    N = nvals[i]
    heightsdataN = Dict(
      "N" => N, 
      "height" => df2[1:N, :height], 
      "weight" => df2[1:N, :weight_c]
    )
    
    # Make sure previous sample files are removed!
    sm = SampleModel("weights", weightsmodel);
    rc = stan_sample(sm, data=heightsdataN)

    if success(rc)

      sample_df = read_samples(sm; output_format=:dataframe)
      xi = -2.5:0.1:3.0
      p[i] = scatter(df2[1:N, :weight_c], df2[1:N, :height],
        leg=false, xlab="weight_c")

      for j in 1:N
        yi = sample_df[j, :alpha] .+ sample_df[j, :beta]*xi
        plot!(p[i], xi, yi, title="N = $N")
      end

    end

  end
  plot(p..., layout=(2, 2))
  savefig("$ProjDir/Fig-48-49.png")
end

end # cd .. do

# End of `04/clip-48-49.jl`
