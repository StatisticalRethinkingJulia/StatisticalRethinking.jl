```@meta
EditURL = "@__REPO_ROOT_URL__/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip-30s
using StatisticalRethinking, CmdStan, LinearAlgebra
#gr(size=(600,600));
nothing #hide
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip-30s
ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)
```

### snippet 4.7

```@example clip-30s
howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
nothing #hide
```

Use only adults

```@example clip-30s
df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)
```

Use data from m4.1s

Check if the m4.1s.jls file is present. If not, run the model.

```@example clip-30s
!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))
```

Describe the draws

```@example clip-30s
MCMCChains.describe(chn)
```

Plot the density of posterior draws

```@example clip-30s
density(chn, lab="All heights", xlab="height [cm]", ylab="density")
```

Compute cor

```@example clip-30s
mu_sigma = hcat(chn.value[:, 2, 1], chn.value[:,1, 1])
LinearAlgebra.diag(cov(mu_sigma))
```

Compute cov

```@example clip-30s
cor(mu_sigma)
```

End of `clip_07.0s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

