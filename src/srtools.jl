function zscore_transform(data)
    μ = mean(data)
    σ = std(data)
    z(d) = (d .- μ) ./ σ
    unz(d) = d .* σ .+ μ
    return z, unz
end

"""
# meanlowerupper

Compute a NamedTuple with means, lower and upper PI values.

$(SIGNATURES)

"""
function meanlowerupper(data, PI = (0.055, 0.945))
    m = mean.(eachrow(data))
    lower = quantile.(eachrow(data), PI[1])
    upper = quantile.(eachrow(data), PI[2])
    return (mean = m,
            lower = lower,
            upper = upper,
            raw = data)
end

function estimparam(data, PI = (0.055, 0.945))
    m = mean.(eachcol(data))
    lower = quantile.(eachcol(data), PI[1])
    upper = quantile.(eachcol(data), PI[2])
    return m, lower, upper
end

function lin(a, b, c, x...)
    result = @. a + b * c
    for i in 1:2:length(x)
        @. result += x[i] * x[i+1]
    end
    return result
end

"""
# pairsplot

Create a polynomial observation matrix.

$(SIGNATURES)

"""
function create_observation_matrix(x::Vector, k::Int)
    n = length(x)
    m = reshape(x, n, 1)
    for i in 2:k
        m = hcat(m, x.^i)
    end
    m
end

"""
# var2

Variance without n-1 correction.

$(SIGNATURES)

"""
var2(x) = mean(x.^2) .- mean(x)^2

"""
# r2_is_bad

Compute R^2 values.

$(SIGNATURES)

"""
function r2_is_bad(model::NamedTuple, df::DataFrame)
    s = mean(model.mu, dims=2)
    r = s - df.brain_s
    round(1 - var2(r) / var2(df.brain_s), digits=2)
end

"""
# PI

Compute percentile central interval of data. Returns vector of bounds.

$(SIGNATURES)

## Required arguments
* `data`: iterable over data values

## Optional arguments
* `prob::Float64=0.89`: percentile interval to calculate

## Examples
```jldoctest
julia> using StatisticalRethinking

julia> PI(1:10)
2-element Vector{Float64}:
 1.495
 9.505

julia> PI(1:10; prob=0.1)
2-element Vector{Float64}:
 5.05
 5.95

```
"""
function PI(data; perc_prob::Float64=0.89)
    d = (1-perc_prob)/2
    quantile(data, [d, 1-d])
end

export
    zscore_transform,
    meanlowerupper,
    estimparam,
    lin,
    create_observation_matrix,
    r2_is_bad,
    PI
