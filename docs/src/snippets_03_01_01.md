```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example snippets_03_01_01
using StatisticalRethinking
gr(size=(600,300))
```

snippet 3.1

```@example snippets_03_01_01
PrPV = 0.95
PrPM = 0.01
PrV = 0.001
PrP = PrPV*PrV + PrPM*(1-PrV)
PrVP = PrPV*PrV / PrP
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

