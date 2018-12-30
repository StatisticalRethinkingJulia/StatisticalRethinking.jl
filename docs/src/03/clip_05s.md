```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed

```@example clip_05s
using StatisticalRethinking
gr(size=(500,800));
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip_05s
ProjDir = rel_path("..", "chapters", "03")
cd(ProjDir)
```

Define the Stan language model

```@example clip_05s
binomialstanmodel = "
// Inferring a Rate
data {
  int N;
  int<lower=0> k[N];
  int<lower=1> n[N];
}
parameters {
  real<lower=0,upper=1> theta;
  real<lower=0,upper=1> thetaprior;
}
model {
  // Prior Distribution for Rate Theta
  theta ~ beta(1, 1);
  thetaprior ~ beta(1, 1);

  // Observed Counts
  k ~ binomial(n, theta);
}
";
```

Define the Stanmodel and set the output format to :mcmcchain.

```@example clip_05s; continued = true
stanmodel = Stanmodel(name="binomial", monitors = ["theta"], model=binomialstanmodel,
  output_format=:mcmcchain);
```

Use 16 observations

```@example clip_05s
N2 = 4^2
d = Binomial(9, 0.66)
n2 = Int.(9 * ones(Int, N2))
k2 = rand(d, N2);
```

Input data for cmdstan

```@example clip_05s
binomialdata = [
  Dict("N" => length(n2), "n" => n2, "k" => k2)
];
```

Sample using cmdstan

```@example clip_05s; continued = true
rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);
```

Describe the draws

```@example clip_05s
describe(chn)
```

Plot the 4 chains

```@example clip_05s
if rc == 0
  plot(chn)
end
```

End of `clip_05s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

