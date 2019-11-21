```@meta
EditURL = "@__REPO_ROOT_URL__/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip-43s
using StatisticalRethinking, CmdStan
#gr(size=(600,600));
nothing #hide
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip-43s
ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)
```

### snippet 4.7

```@example clip-43s
howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
nothing #hide
```

Use only adults

```@example clip-43s
df2 = filter(row -> row[:age] >= 18, df);
mean_weight = mean(df2[:weight]);
df2[:weight_c] = df2[:weight] .- mean_weight;
first(df2, 5)
```

Define the Stan language model

```@example clip-43s
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
nothing #hide
```

Define the Stanmodel and set the output format to :mcmcchains.

```@example clip-43s
stanmodel = Stanmodel(name="weights", model=weightsmodel,
  output_format=:mcmcchains);
nothing #hide
```

Input data for cmdstan

```@example clip-43s
heightsdata = Dict("N" => length(df2[:height]), "height" => df2[:height], "weight" => df2[:weight_c]);
nothing #hide
```

Sample using cmdstan

```@example clip-43s
rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);
nothing #hide
```

Describe the draws

```@example clip-43s
MCMCChains.describe(chn)
```

Plot the density of posterior draws

```@example clip-43s
plot(chn)
```

Plot regression line using means and observations

```@example clip-43s
scatter(df2[:weight_c], df2[:height], lab="Observations",
  ylab="height [cm]", xlab="weight[kg]")
xi = -16.0:0.1:18.0
rws, vars, chns = size(chn)
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)));
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)));
yi = mean(alpha_vals) .+ mean(beta_vals)*xi;
plot!(xi, yi, lab="Regression line")
```

End of `clip-43s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

