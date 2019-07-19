using StatisticalRethinking
using CmdStan
#gr(size=(600,600));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df);

mean_weight = mean(df2[:weight])
df2 = hcat(df2, df2[:weight] .- mean_weight)
rename!(df2, :x1 => :weight_c); # Rename our col :x1 => :weight_c
first(df2, 5)

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

stanmodel = Stanmodel(name="weights", monitors = ["alpha", "beta", "sigma"],model=weightsmodel,
  output_format=:mcmcchains);

heightsdata = Dict("N" => length(df2[:height]), "height" => df2[:height], "weight" => df2[:weight_c]);

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

chn.value[1:5,:,1]

nvals = [10, 50, 150, 352];

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
for i in 1:length(nvals)
  N = nvals[i]
  heightsdataN = [
    Dict("N" => N, "height" => df2[1:N, :height], "weight" => df2[1:N, :weight_c])
  ]
  rc, chnN, cnames = stan(stanmodel, heightsdataN, ProjDir, diagnostics=false,
    summary=false, CmdStanDir=CMDSTAN_HOME)

  rws, vars, chns = size(chnN)
  xi = -15.0:0.1:15.0
  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))
  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))

  p[i] = scatter(df2[1:N, :weight_c], df2[1:N, :height], leg=false, xlab="weight_c")
  for j in 1:N
    yi = alpha_vals[j] .+ beta_vals[j]*xi
    plot!(p[i], xi, yi, title="N = $N")
  end
end
plot(p..., layout=(2, 2))

rws, vars, chns = size(chn)
mu_at_50 = link(50:10:50, chn, [1, 2], mean_weight);
density(mu_at_50)

mu = link(25:10:75, chn, [1, 2], mean_weight);

q = Vector{Plots.Plot{Plots.GRBackend}}(undef, size(mu, 1))
for i in 1:size(mu, 1)
  q[i] = density(mu[i], ylim=(0.0, 1.5),
    leg=false, title="mu_bar = $(round(mean(mu[i]), digits=1))")
end
plot(q..., layout=(2, 3), ticks=(3))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

