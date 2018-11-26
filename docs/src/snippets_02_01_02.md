```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Chapter 2 snippets

### snippet 2.0

Load Julia packages (libraries) needed

```@example snippets_02_01_02
using StatisticalRethinking
gr(size=(600,300))
```

snippet 2.1

```@example snippets_02_01_02
@show ways  = [0  , 3 , 8 , 9 , 0 ];
@show ways/sum(ways)
```

snippet 2.2

```@example snippets_02_01_02
@show d = Binomial(9, 0.5);
@show pdf(d, 6)
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

