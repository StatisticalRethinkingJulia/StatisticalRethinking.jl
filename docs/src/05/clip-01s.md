```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip-01s
using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip-01s
ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)
```

### snippet 5.1

```@example clip-01s
wd = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';')
df = convert(DataFrame, wd);
mean_ma = mean(df[:MedianAgeMarriage])
df[:MedianAgeMarriage_s] = convert(Vector{Float64},
  (df[:MedianAgeMarriage]) .- mean_ma)/std(df[:MedianAgeMarriage]);
first(df, 5)
```

Define the Stan language model

```@example clip-01s; continued = true
ad_model = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] divorce; // Predictor
 vector[N] median_age; // Outcome
}

parameters {
 real a; // Intercept
 real bA; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

model {
```

priors

```@example clip-01s; continued = true
  a ~ normal(10, 10);
  bA ~ normal(0, 1);
  sigma ~ uniform(0, 10);
```

model

```@example clip-01s
  divorce ~ normal(a + bA*median_age , sigma);
}
";
```

Define the Stanmodel and set the output format to :mcmcchain.

```@example clip-01s; continued = true
stanmodel = Stanmodel(name="MedianAgeDivorce", monitors = ["a", "bA", "sigma"],
  model=ad_model, output_format=:mcmcchain);
```

Input data for cmdstan

```@example clip-01s; continued = true
maddata = Dict("N" => length(df[:Divorce]), "divorce" => df[:Divorce],
    "median_age" => df[:MedianAgeMarriage_s]);
```

Sample using cmdstan

```@example clip-01s; continued = true
rc, chn, cnames = stan(stanmodel, maddata, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);
```

Describe the draws

```@example clip-01s
describe(chn)
```

Plot the density of posterior draws

```@example clip-01s
plot(chn)
```

Plot regression line using means and observations

```@example clip-01s
xi = -3.0:0.01:3.0
rws, vars, chns = size(chn[:, 1, :])
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))
yi = mean(alpha_vals) .+ mean(beta_vals)*xi

scatter(df[:MedianAgeMarriage_s], df[:Divorce], color=:darkblue,
  xlab="Median age of marriage [ $(round(mean_ma, digits=1)) years]",
  ylab="divorce rate [# of divorces/1000 adults]")
plot!(xi, yi, lab="Regression line")
```

shade(), abline() and link()

```@example clip-01s
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
scatter!(df[:MedianAgeMarriage_s], df[:Divorce], color=:darkblue)
plot!(xi, yi, lab="Regression line")
```

End of `05/clip_01s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

