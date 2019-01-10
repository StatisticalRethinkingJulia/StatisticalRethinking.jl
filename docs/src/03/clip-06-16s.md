```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed

```@example clip-06-16s
using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip-06-16s
ProjDir = rel_path("..", "scripts", "03")
cd(ProjDir)
```

Define the Stan language model

```@example clip-06-16s
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

```@example clip-06-16s; continued = true
stanmodel = Stanmodel(name="binomial", monitors = ["theta"], model=binomialstanmodel,
  output_format=:mcmcchain);
```

Use 16 observations

```@example clip-06-16s
N2 = 4
n2 = Int.(9 * ones(Int, N2))
k2 = [6, 5, 7, 6]
```

Input data for cmdstan

```@example clip-06-16s
binomialdata = Dict("N" => length(n2), "n" => n2, "k" => k2);
```

Sample using cmdstan

```@example clip-06-16s; continued = true
rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);
```

Describe the draws

```@example clip-06-16s
describe(chn)
```

Look at area of hpd

```@example clip-06-16s
MCMCChain.hpd(chn)
```

Plot the 4 chains

```@example clip-06-16s
if rc == 0
  mixeddensity(chn, xlab="height [cm]", ylab="density")
  bnds = MCMCChain.hpd(convert(Vector{Float64}, chn.value[:,1,1]))
  vline!([bnds[1]], line=:dash)
  vline!([bnds[2]], line=:dash)
end
```

End of `clip_06_16s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

