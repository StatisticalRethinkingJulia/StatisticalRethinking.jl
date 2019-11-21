```@meta
EditURL = "@__REPO_ROOT_URL__/"
```

Load Julia packages (libraries) needed

```@example clip-17s
using StatisticalRethinking, CmdStan
#gr(size=(600,600));
nothing #hide
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip-17s
ProjDir = rel_path("..", "scripts", "03")
cd(ProjDir)
```

Define the Stan language model

```@example clip-17s
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
nothing #hide
```

Define the Stanmodel and set the output format to :mcmcchains.

```@example clip-17s
stanmodel = Stanmodel(name="binomial", monitors = ["theta"], model=binomialstanmodel,
  output_format=:mcmcchains);
nothing #hide
```

Use 4 observations

```@example clip-17s
N2 = 4
n2 = Int.(9 * ones(Int, N2))
k2 = [6, 5, 7, 6]
```

Input data for cmdstan

```@example clip-17s
binomialdata = Dict("N" => length(n2), "n" => n2, "k" => k2);
nothing #hide
```

Sample using cmdstan

```@example clip-17s
rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);
nothing #hide
```

Describe the draws

```@example clip-17s
MCMCChains.describe(chn)
```

Look at area of hpd

```@example clip-17s
MCMCChains.hpd(chn)
```

Plot the 4 chains

```@example clip-17s
if rc == 0
  mixeddensity(chn, xlab="height [cm]", ylab="density")
  bnds = hpd(chn[:,1,1])
  vline!([bnds[:lower]], line=:dash)
  vline!([bnds[:upper]], line=:dash)
end
```

End of `clip-06-16s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

