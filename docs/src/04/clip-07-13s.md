```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip-07-13s
using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip-07-13s
ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)
```

### snippet 4.7

```@example clip-07-13s
howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
```

### snippet 4.8

Show first 5 rows of DataFrame df

```@example clip-07-13s
first(df, 5)
```

Use only adults

```@example clip-07-13s
df2 = filter(row -> row[:age] >= 18, df);
```

Plot the densities.

```@example clip-07-13s
density(df2[:height], lab="All heights", xlab="height [cm]", ylab="density")
```

Filter on sex to see if it is bi-modal

```@example clip-07-13s
female_df = filter(row -> row[:male] == 0, df2);
male_df = filter(row -> row[:male] == 1, df2);
first(male_df, 5)
```

Is it bi-modal?

```@example clip-07-13s
density!(female_df[:height], lab="Female heights")
density!(male_df[:height], lab="Male heights")
```

Use data from m4.1s

Check if the m4.1s.jls file is present. If not, run the model.

```@example clip-07-13s
!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))
```

Describe the draws

```@example clip-07-13s
describe(chn)
```

### snippet 4.13

Plot the density of posterior draws

```@example clip-07-13s
density(chn, lab="All heights", xlab="height [cm]", ylab="density")
```

End of `clip-07-13s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

