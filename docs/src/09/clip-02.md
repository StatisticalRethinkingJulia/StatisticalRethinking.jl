```@meta
EditURL = "@__REPO_ROOT_URL__/"
```

### `09/clip-02.jl`

### Snippet 9.2

```@example clip-02
using StatisticalRethinking, LinearAlgebra
#gr(size=(600, 600))

ProjDir = @__DIR__
```

Number of samples

```@example clip-02
T = 1000
```

Compute radial distance

```@example clip-02
rad_dist(x) = sqrt(sum(x .^ 2))
```

Plot densities

```@example clip-02
p = density(xlabel="Radial distance from mode", ylabel="Density")

for d in [1, 10, 100, 1000]
  m = MvNormal(zeros(d), Diagonal(ones(d)))
  y = rand(m, T)
  rd = [rad_dist( y[:, i] ) for i in 1:T]
  density!(p, rd, lab="d=$d")
end

plot(p)
```

End of `09/clip-02.jl

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

