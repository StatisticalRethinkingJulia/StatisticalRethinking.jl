```@meta
EditURL = "@__REPO_ROOT_URL__/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip-07-13s
using StatisticalRethinking, CmdStan
#gr(size=(700,700));
nothing #hide
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
nothing #hide
```

### snippet 4.8

Show first 5 rows of DataFrame df

```@example clip-07-13s
first(df, 5)
```

### snippet 4.9

Show first 5 heigth values in df

```@example clip-07-13s
first(df, 5)
```

### snippet 4.10

Use only adults

```@example clip-07-13s
df2 = filter(row -> row[:age] >= 18, df);
nothing #hide
```

Our model:

```@example clip-07-13s
m4_1 = "
  height ~ Normal(μ, σ) # likelihood
  μ ~ Normal(178,20) # prior
  σ ~ Uniform(0, 50) # prior
";
nothing #hide
```

Plot the densities.

```@example clip-07-13s
p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 3)
p[1] = density(df2[:height], xlim=(100,250), lab="All heights", xlab="height [cm]", ylab="density")
```

### snippet 4.10

Show  μ prior

```@example clip-07-13s
d1 = Normal(178, 20)
p[2] = plot(100:250, [pdf(d1, μ) for μ in 100:250], lab="Prior on mu")
```

### snippet 4.11

Show σ  prior

```@example clip-07-13s
d2 = Uniform(0, 50)
p[3] = plot(0:0.1:50, [pdf(d2, σ) for σ in 0:0.1:50], lab="Prior on sigma")

plot(p..., layout=(3,1))
```

### snippet 4.13

```@example clip-07-13s
sample_mu = rand(d1, 10000)
sample_sigma = rand(d2, 10000)
prior_height = [rand(Normal(sample_mu[i], sample_sigma[i]), 1)[1] for i in 1:10000]
df2 = DataFrame(mu = sample_mu, sigma=sample_sigma, prior_height=prior_height);
first(df2, 5)
```

Show density of prior_height

```@example clip-07-13s
density(prior_height, lab="prior_height")
```

Use data from m4.1s to show CmdStan results

Check if the m4.1s.jls file is present. If not, run the model.

```@example clip-07-13s
!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))
```

Describe the draws

```@example clip-07-13s
MCMCChains.describe(chn)
```

Plot the density of posterior draws

```@example clip-07-13s
density(chn)
```

End of `clip-07-13s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

