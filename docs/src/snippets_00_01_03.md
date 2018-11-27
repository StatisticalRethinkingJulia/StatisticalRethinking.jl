```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Snippets_00_01_03

Load Julia packages (libraries) needed  for the snippets in chapter 0

```@example snippets_00_01_03
using StatisticalRethinking
gr(size=(300, 300))
```

### snippet 0.1

```@example snippets_00_01_03
println( "All models are wrong, but some are useful." )
```

### snippet 0.2

This is a StepRange, not a vector

```@example snippets_00_01_03
x = 1:3
x = x*10
x = log.(x)
x = sum(x)
x = exp(x)
x = x*10
x = log(x)
x = sum(x)
x = exp(x)
```

### snippet 0.3

```@example snippets_00_01_03
log( 0.01^200 )
200 * log(0.01)
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

