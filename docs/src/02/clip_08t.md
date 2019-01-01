```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

Load Julia packages (libraries) needed

```@example clip_08t
using StatisticalRethinking
using StatsFuns, Optim, Turing, Flux.Tracker
gr(size=(600,300));

Turing.setadbackend(:reverse_diff)
```

### snippet 2.8t

Define the data

```@example clip_08t
k = 6; n = 9;
```

Define the model

```@example clip_08t
@model globe_toss(n, k) = begin
  theta ~ Beta(1, 1) # prior
  k ~ Binomial(n, theta) # model
  return k, theta
end;
```

Compute the "maximum_a_posteriori" value

Set search bounds

```@example clip_08t
lb = [0.0]; ub = [1.0];
```

Create (compile) the model

```@example clip_08t
model = globe_toss(n, k);
```

Compute the maximum_a_posteriori

```@example clip_08t
result = maximum_a_posteriori(model, lb, ub)
```

Use Turing mcmc

```@example clip_08t
Turing.turnprogress(false)
chn = sample(model, NUTS(2000, 1000, 0.65));
```

Look at the generated draws (in chn)

```@example clip_08t
describe(chn)
```

Look at the mean and sd

```@example clip_08t
println("\ntheta = $(mean_and_std(chn[:theta][1001:2000]))\n")
```

Compute at hpd region

```@example clip_08t
bnds = MCMCChain.hpd(chn[:theta], alpha=0.06);
```

analytical calculation

```@example clip_08t
w = 6; n = 9; x = 0:0.01:1
plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab="Conjugate solution")
```

quadratic approximation

```@example clip_08t
plot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")
```

Turing Chain &  89%hpd region boundaries

```@example clip_08t
density!(chn[:theta], lab="Turing chain")
vline!([bnds[1]], line=:dash, lab="hpd lower bound")
vline!([bnds[2]], line=:dash, lab="hpd upper bound")
```

Show hpd region

```@example clip_08t
println("hpd bounds = $bnds\n")
```

End of `clip_08t.jl`

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

