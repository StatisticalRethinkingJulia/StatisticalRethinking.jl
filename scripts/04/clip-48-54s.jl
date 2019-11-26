# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, StanSample

ProjDir = @__DIR__

# ### Preliminary snippets

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);

# Center weight and store as weight_c

mean_weight = mean(df2[:, :weight])
df2 = hcat(df2, df2[:, :weight] .- mean_weight)
rename!(df2, :x1 => :weight_c); # Rename our col :x1 => :weight_c
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

# Define the Stanmodel and set the output format to :mcmcchains.

sm = SampleModel("weights", weightsmodel);

# Input data.

heightsdata = Dict("N" => length(df2[:, :height]), 
  "height" => df2[:, :height], "weight" => df2[:, :weight_c]);

# Sample using cmdstan

(sample_file, log_file) = stan_sample(sm, data=heightsdata);

if sample_file !== nothing

  chn = read_samples(sm)

  # ### Snippet 4.47

  # Show first 5 draws of correlated parameter values in chain 1

  chn.value[1:5,:,1]

  # ### Snippets 4.48 & 4.49

  # Plot estimates using the N = [10, 50, 150, 352] observations

  nvals = [10, 50, 150, 352];

  # Create the 4 nvals plots

  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
  for i in 1:length(nvals)
    N = nvals[i]
    heightsdataN = [
      Dict("N" => N, "height" => df2[1:N, :height], "weight" => df2[1:N, :weight_c])
    ]
    (sample_file, log_file) = stan_sample(sm, data=heightsdataN)

    if sample_file !== nothing

      chnN = read_samples(sm)
      xi = -15.0:0.1:15.0
      sample_df = DataFrame(chnN)
      p[i] = scatter(df2[1:N, :weight_c], df2[1:N, :height], leg=false, xlab="weight_c")
      for j in 1:N
        yi = sample_df[j, :alpha] .+ sample_df[j, :beta]*xi
        plot!(p[i], xi, yi, title="N = $N")
      end

    end

  end
  plot(p..., layout=(2, 2))
  savefig("$ProjDir/Fig-48-54.1.pdf")

  # ### Snippet 4.50

  # Get dimensions of chains

  rws, vars, chns = size(chn)
  mu_at_50 = link(50:10:50, chn, [1, 2], mean_weight);
  density(mu_at_50)
  savefig("$ProjDir/fig-48-54.2.pdf")

  # ### Snippet 4.54

  # Show posterior density for 6 mu_bar values

  mu = link(25:10:75, chn, [1, 2], mean_weight);

  q = Vector{Plots.Plot{Plots.GRBackend}}(undef, size(mu, 1))
  for i in 1:size(mu, 1)
    q[i] = density(mu[i], ylim=(0.0, 1.5),
      leg=false, title="mu_bar = $(round(mean(mu[i]), digits=1))")
  end
  plot(q..., layout=(2, 3), ticks=(3))
  savefig("$ProjDir/Fig-48-54.3.pdf")

end

# End of `04/clip-48-54s.jl`
