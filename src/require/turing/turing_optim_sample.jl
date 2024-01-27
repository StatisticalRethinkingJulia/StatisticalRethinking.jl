import StatsBase: sample
using Optim
import .TuringOptimExt: ModeResult
import LinearAlgebra: Symmetric

"""
# sample

Sample from ModeResult - optimisation result produced by Turing mode estimation.

$(SIGNATURES)

## Required arguments
* `m::ModeResult`: mode estimation result
* `n::Integer`: amount of samples to be drawn

## Return values
`Chains` object with drawn samples

## Examples
```jldoctest
julia> using Optim, Turing, StatisticalRethinking

julia> @model function f(x)
           a ~ Normal()
           x ~ Normal(a)
       end
f (generic function with 2 methods)

julia> m = optimize(f([1,1.1]), MLE())
ModeResult with maximized lp of -1.84
1-element Named Vector{Float64}
A  │
───┼─────
:a │ 1.05

julia> sample(m, 10)
Chains MCMC chain (10×1×1 reshape(adjoint(::Matrix{Float64}), 10, 1, 1) with eltype Float64):

Iterations        = 1:1:10
Number of chains  = 1
Samples per chain = 10
Wall duration     = 0.0 seconds
Compute duration  = 0.0 seconds
parameters        = a

Summary Statistics
  parameters      mean       std   naive_se      mcse       ess      rhat   ess_per_sec
      Symbol   Float64   Float64    Float64   Float64   Float64   Float64       Float64

           a    0.7186    0.5911     0.1869    0.1717    9.4699    0.9243     9469.8745

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5%
      Symbol   Float64   Float64   Float64   Float64   Float64

           a    0.0142    0.3041    0.6623    0.9987    1.7123
```
"""
function sample(m::ModeResult, n::Int)::Chains
    st = now()
    μ = coef(m)
    Σ = Symmetric(vcov(m))
    dist = MvNormal(μ, Σ)
    Chains(rand(dist, n)', coefnames(m), info=(start_time=st, stop_time=now()))
end
