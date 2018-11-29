```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed

```@example snippets_02_01_02
using StatisticalRethinking
gr(size=(600,300))
```

snippet 2.1

```@example snippets_02_01_02
ways  = [0, 3, 8, 9, 0]
```

```@example snippets_02_01_02
ways/sum(ways)
```

snippet 2.2
Create a distribution with n = 9 (e.g. tosses) and p = 0.5.

```@example snippets_02_01_02
d = Binomial(9, 0.5)
```

Probability density for 6 `waters` holding n = 9 and p = 0.5.

```@example snippets_02_01_02
pdf(d, 6)
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

