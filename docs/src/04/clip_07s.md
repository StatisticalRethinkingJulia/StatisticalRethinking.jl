```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip_07s
using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,800))
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip_07s
ProjDir = @__DIR__
cd(ProjDir)
```

### snippet 4.7

```@example clip_07s
howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
```

Use only adults

```@example clip_07s
df2 = filter(row -> row[:age] >= 18, df)
female_df = filter(row -> row[:male] == 0, df2)
male_df = filter(row -> row[:male] == 1, df2)
```

Plot the densities.

```@example clip_07s
density(df2[:height], lab="All heights")
```

Is it bi-modal?

```@example clip_07s
density!(female_df[:height], lab="Female heights")
density!(male_df[:height], lab="Male heights")
```

Define the Stan language model

```@example clip_07s
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
"
```

Define the Stanmodel and set the output format to :mcmcchain.

```@example clip_07s; continued = true
stanmodel = Stanmodel(name="heights", monitors = ["mu", "sigma"],model=heightsmodel,
  output_format=:mcmcchain)
```

Input data for cmdstan

```@example clip_07s
heightsdata = [
  Dict("N" => length(df2[:height]), "h" => df2[:height])
]
```

Sample using cmdstan

```@example clip_07s; continued = true
rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME)
```

Describe the draws

```@example clip_07s
describe(chn)
```

Plot the density of posterior draws

```@example clip_07s
density(chn, lab="All heights")
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

