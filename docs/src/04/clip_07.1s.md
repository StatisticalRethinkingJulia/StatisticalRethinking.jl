```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip_07.1s
using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip_07.1s
ProjDir = rel_path("..", "chapters", "04")
cd(ProjDir)
```

### snippet 4.7

```@example clip_07.1s
howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
```

Use only adults

```@example clip_07.1s
df2 = filter(row -> row[:age] >= 18, df)
```

Define the Stan language model

```@example clip_07.1s
heightsmodel = "
// Inferring a Rate
data {
  int N;
  real<lower=0> h[N];
}
parameters {
  real<lower=0> sigma;
  real<lower=0,upper=250> mu;
}
model {
  // Priors for mu and sigma
  mu ~ uniform(100, 250);
  sigma ~ cauchy( 0 , 1 );

  // Observed heights
  h ~ normal(mu, sigma);
}
";
```

Define the Stanmodel and set the output format to :mcmcchain.

```@example clip_07.1s; continued = true
stanmodel = Stanmodel(name="heights", monitors = ["mu", "sigma"],model=heightsmodel,
  output_format=:mcmcchain);
```

Input data for cmdstan

```@example clip_07.1s
heightsdata = [
  Dict("N" => length(df2[:height]), "h" => df2[:height])
];
```

Sample using cmdstan

```@example clip_07.1s; continued = true
rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);
```

Describe the draws

```@example clip_07.1s
describe(chn)
```

Compare with previous result

```@example clip_07.1s
clip_07s_example_output = "

Samples were drawn using hmc with nuts.
For each parameter, N_Eff is a crude measure of effective sample size,
and R_hat is the potential scale reduction factor on split chains (at
convergence, R_hat=1).

Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
          Mean        SD      Naive SE      MCSE      ESS
sigma   7.7641718 0.3055115 0.004830561 0.0047596714 1000
   mu 154.6042417 0.4158242 0.006574758 0.0068304868 1000

Quantiles:
         2.5%       25.0%       50.0%      75.0%      97.5%
sigma   7.198721   7.5573575   7.749435   7.960795   8.393317
   mu 153.795975 154.3307500 154.610000 154.884000 155.391050

";
```

Plot the density of posterior draws

```@example clip_07.1s
density(chn, xlab="height [cm]", ylab="density")
```

End of `clip_07.1s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

