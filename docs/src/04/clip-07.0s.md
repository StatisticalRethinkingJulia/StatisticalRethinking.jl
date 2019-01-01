```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip-07.0s
using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip-07.0s
ProjDir = rel_path("..", "chapters", "04")
cd(ProjDir)
```

### snippet 4.7

```@example clip-07.0s
howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
```

Use only adults

```@example clip-07.0s
df2 = filter(row -> row[:age] >= 18, df)
female_df = filter(row -> row[:male] == 0, df2)
male_df = filter(row -> row[:male] == 1, df2)
```

Plot the densities.

```@example clip-07.0s
density(df2[:height], lab="All heights", xlab="height [cm]", ylab="density")
```

Is it bi-modal?

```@example clip-07.0s
density!(female_df[:height], lab="Female heights")
density!(male_df[:height], lab="Male heights")
```

Define the Stan language model

```@example clip-07.0s
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
  mu ~ normal(178, 20);
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}
";
```

Define the Stanmodel and set the output format to :mcmcchain.

```@example clip-07.0s; continued = true
stanmodel = Stanmodel(name="heights", monitors = ["mu", "sigma"],model=heightsmodel,
  output_format=:mcmcchain);
```

Input data for cmdstan

```@example clip-07.0s
heightsdata = [
  Dict("N" => length(df2[:height]), "h" => df2[:height])
];
```

Sample using cmdstan

```@example clip-07.0s; continued = true
rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);
```

Describe the draws

```@example clip-07.0s
describe(chn)
```

Plot the density of posterior draws

```@example clip-07.0s
density(chn, lab="All heights", xlab="height [cm]", ylab="density")
```

End of `clip_07.0s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

