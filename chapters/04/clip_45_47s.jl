# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500))

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "chapters", "04")
cd(ProjDir)

# ### snippet 4.7

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df)

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
"

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="weights", monitors = ["alpha", "beta", "sigma"],model=weightsmodel,
  output_format=:mcmcchain)

# Input data for cmdstan

heightsdata = [
  Dict("N" => length(df2[:height]), "height" => df2[:height], "weight" => df2[:weight])
]

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME)

# Show individual draws of correlated parameter values

display(chn.value[1:5,:,1])

# Plot estimates using the first N = 10 observations

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
nvals = [10, 50, 150, 200]

for i in 1:length(nvals)
  N = nvals[i]
  heightsdataN = [
    Dict("N" => N, "height" => df2[1:N, :height], "weight" => df2[1:N, :weight])
  ]
  rc, chnN, cnames = stan(stanmodel, heightsdataN, ProjDir, diagnostics=false,
    CmdStanDir=CMDSTAN_HOME)

  xi = 30.0:0.1:65.0
  rws, vars, chns = size(chnN[:, 1, :])
  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))
  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))

  p[i] = scatter(df2[1:N, :weight], df2[1:N, :height], leg=false, xlab="weight")
  for j in 1:N
    yi = alpha_vals[j] .+ beta_vals[j]*xi
    plot!(p[i], xi, yi, title="N = $N")
  end
end
plot(p..., layout=(2, 2))

# End of clip_45_47s.jl
