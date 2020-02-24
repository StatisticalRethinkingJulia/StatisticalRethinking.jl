using StatisticalRethinking
using StatsPlots, LaTeXStrings

ProjDir = @__DIR__

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);
mean_weight = mean(df2[:, :weight]);
df2[!, :weight_c] = df2[:, :weight] .- mean_weight;
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

# Input data

heightsdata = Dict("N" => length(df2[:, :height]), 
	"height" => df2[:, :height], "weight" => df2[:, :weight_c]);

# Sample using cmdstan

@time rc = stan_sample(sm, data=heightsdata);

if success(rc)

	# Describe the draws
	df3 = read_samples(sm; output_format=:dataframe)
	p = Particles(df3)
	p |> display
	println()

	# ### snippet 4.37

	# Plot regression line using means and observations

	scatter(df2[:, :weight_c], df2[:, :height], lab="Observations",
	  ylab="height [cm]", xlab="weight[kg]")
	xi = -16.0:0.1:18.0
	yi = mean(df3[:, :alpha]) .+ mean(df3[:, :beta])*xi;
	plot!(xi, yi, lab="Regression line")
	savefig("$ProjDir/Fig-37-44.2.png")

	# ### snippet 4.44

	println()
	q = quap(df3)
	display(q)

	plot(plot(q.alpha, lab="\\alpha"), plot(q.beta, lab="\\beta"), layout=(2, 1))
	savefig("$ProjDir/Fig-37-44.1.png")

end

# End of `clip-37-44.jl`
