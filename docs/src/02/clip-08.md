```@meta
EditURL = "@__REPO_ROOT_URL__/"
```

Load Julia packages (libraries) needed

```@example clip-08
using StatisticalRethinking
```

### snippet 2.8

Simple Metropolis algorithm

```@example clip-08
n_samples = 10000
a3d = ones(n_samples,1,1)
w = 6; l = 3; n = w +l
p = [0.5]
for i in 2:n_samples
  p_new = rand(Normal(p[i-1], 0.1), 1)[1]
  if  p_new < 0
    p_new = abs(p_new)
  end
  if p_new > 1
    p_new = 2 - p_new
  end
  q0 = pdf(Binomial(n, p[i-1]), w)
  q1 = pdf(Binomial(n, p_new), w)
  append!(p, [rand(Uniform(0, 1), 1)[1] < q1/q0 ? p_new : p[i-1]])
end
```

Create an MCMCChains.Chains object.
This Chains object has length(p) samples, one varable and a single chain.

```@example clip-08
a3d[:, 1, 1] = p
chns = MCMCChains.Chains(a3d, ["toss"])
```

Describe the chain

```@example clip-08
MCMCChains.describe(chns)
```

Plot the chain

```@example clip-08
plot(chns)
```

Show density and computed conjugate solution

```@example clip-08
w = 6; n = 9; x = 0:0.01:1
density(chns, lab="Samples")
plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab="Conjugate solution")
```

End of `02/clip-08.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

