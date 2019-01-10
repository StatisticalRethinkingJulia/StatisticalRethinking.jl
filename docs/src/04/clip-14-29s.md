```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip-14-29s
using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));
```

CmdStan uses a tmp directory to store the output of cmdstan

```@example clip-14-29s
ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)
```

Use data from m4.1s

Check if the m4.1s.jls file is present. If not, run the model.

```@example clip-14-29s
!isfile(joinpath(ProjDir, "m4.1s.jls")) && include(joinpath(ProjDir, "m4.1s.jl"))

chn = deserialize(joinpath(ProjDir, "m4.1s.jls"))
```

Describe the draws

```@example clip-14-29s
describe(chn)
```

### snippet 4.15

```@example clip-14-29s
scatter(chn.value[:, 2, 1], chn.value[:, 1, 1])
```

End of `clip-14-29s.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

