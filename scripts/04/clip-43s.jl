using StatisticalRethinking, CmdStan

ProjDir = rel_path("..", "scripts", "04")

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

# ### snippet 4.7

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);
mean_weight = mean(df2[:weight]);
df2[:weight_c] = df2[:weight] .- mean_weight;
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

stanmodel = Stanmodel(name="weights", model=weightsmodel,
  output_format=:mcmcchains);

# Input data for cmdstan

heightsdata = Dict("N" => length(df2[:height]), "height" => df2[:height], "weight" => df2[:weight_c]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

MCMCChains.describe(chn)

# Plot the density of posterior draws

plot(chn)

# Plot regression line using means and observations

scatter(df2[:weight_c], df2[:height], lab="Observations",
  ylab="height [cm]", xlab="weight[kg]")
xi = -16.0:0.1:18.0
rws, vars, chns = size(chn)
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)));
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)));
yi = mean(alpha_vals) .+ mean(beta_vals)*xi;
plot!(xi, yi, lab="Regression line")
savefig("$ProjDir/fig-43s.pdf")

# End of `clip-43s.jl`
