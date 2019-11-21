```@meta
EditURL = "@__REPO_ROOT_URL__/"
```

# clip-01.jl

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example clip-01
using StatisticalRethinking
```

### snippet 3.1

```@example clip-01
PrPV = 0.95
PrPM = 0.01
PrV = 0.001
PrP = PrPV*PrV + PrPM*(1-PrV)
PrVP = PrPV*PrV / PrP
```

End of `03/clip-01.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

