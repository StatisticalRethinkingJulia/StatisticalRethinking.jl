```@meta
EditURL = "@__REPO_ROOT_URL__/"
```

Load Julia packages (libraries) needed.

```@example clip-01-05s
using StatisticalRethinking, CmdStan
#gr(size=(600,600));

ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)
```

### snippet 5.1

```@example clip-01-05s
wd = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';');
df = convert(DataFrame, wd);
df[!, :A] = scale(df[!, :MedianAgeMarriage]);
df[!, :D] = scale(df[!, :Divorce]);
first(df, 5)
```

### snippet 5.1

```@example clip-01-05s
std(df[!, :MedianAgeMarriage])

ad = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] D; // Outcome
 vector[N] A; // Predictor
}

parameters {
 real a; // Intercept
 real bA; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

model {
  vector[N] mu;
  a ~ normal(0, 0.2);
  bA ~ normal(0, 0.5);
  sigma ~ exponential(1);
  mu = a + bA * A;
  D ~ normal(mu , sigma);
}
";
nothing #hide
```

Define the Stanmodel and set the output format to :mcmcchains.

```@example clip-01-05s
m5_1s = Stanmodel(name="MedianAgeDivorce", model=ad);
nothing #hide
```

Input data for cmdstan

```@example clip-01-05s
data = Dict("N" => length(df[!, :D]), "D" => df[!, :Divorce],
    "A" => df[!, :A]);
nothing #hide
```

Sample using cmdstan

```@example clip-01-05s
rc, chn, cnames = stan(m5_1s, data, ProjDir, diagnostics=false,
  summary=true, CmdStanDir=CMDSTAN_HOME);
nothing #hide
```

Describe the draws

```@example clip-01-05s
MCMCChains.describe(chn)
```

Plot the density of posterior draws

```@example clip-01-05s
plot(chn)
```

Result rethinking

```@example clip-01-05s
rethinking = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.69 0.22  9.34 10.03  2023    1
bA    -1.04 0.21 -1.37 -0.71  1882    1
sigma  1.51 0.16  1.29  1.79  1695    1
"
```

Plot regression line using means and observations

```@example clip-01-05s
xi = -3.0:0.01:3.0
rws, vars, chns = size(chn)
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))
yi = mean(alpha_vals) .+ mean(beta_vals)*xi

scatter(df[!, :A], df[!, :D], color=:darkblue,
  xlab="Standardized median age of marriage",
  ylab="Standardize divorce rate")
plot!(xi, yi, lab="Regression line")
```

shade(), abline() and link()

```@example clip-01-05s
mu = link(xi, chn, [1, 2], mean(xi));
yl = [minimum(mu[i]) for i in 1:length(xi)];
yh =  [maximum(mu[i]) for i in 1:length(xi)];
ym =  [mean(mu[i]) for i in 1:length(xi)];
pi = hcat(xi, yl, ym, yh);
pi[1:5,:]

plot!((xi, yl), color=:lightgrey, leg=false)
plot!((xi, yh), color=:lightgrey, leg=false)
for i in 1:length(xi)
  plot!([xi[i], xi[i]], [yl[i], yh[i]], color=:lightgrey, leg=false)
end
scatter!(df[!, :A], df[!, :D], color=:darkblue)
plot!(xi, yi, lab="Regression line")
```

End of `05/m5.1s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

