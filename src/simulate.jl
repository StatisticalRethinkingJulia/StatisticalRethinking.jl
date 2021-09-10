"""
# simulate

Used for counterfactual simulations.

$(SIGNATURES)

### Required arguments
```julia
* `df`                                 : DataFrame with coefficient samples
* `coefs`                              : Vector of coefficients
* `var_seq`                            : Input values for simulated effect
```

### Return values
```julia
* `m_sim::NamedTuple`                  : Array with predictions
```

"""
function simulate(df, coefs, var_seq)
  m_sim = zeros(size(df, 1), length(var_seq));
  for j in 1:size(df, 1)
    for i in 1:length(var_seq)
      d = Normal(df[j, coefs[1]] + df[j, coefs[2]] * var_seq[i], df[j, coefs[3]])
      m_sim[j, i] = rand(d)
    end
  end
  m_sim
end

"""
# simulate

Counterfactual predictions after manipulating a variable.

$(SIGNATURES)

### Required arguments
```julia
* `df`                                 : DataFrame with coefficient samples
* `coefs`                              : Vector of coefficients
* `var_seq`                            : Input values for simulated effect
* `ext_coefs`                          : Vector of simulated variable coefficients
```

### Return values
```julia
* `(m_sim, d_sim)`                     : Arrays with predictions
```

"""
function simulate(df, coefs, var_seq, coefs_ext)
  m_sim = simulate(df, coefs, var_seq)
  d_sim = zeros(size(df, 1), length(var_seq));
  for j in 1:size(df, 1)
    for i in 1:length(var_seq)
      d = Normal(df[j, coefs[1]] + df[j, coefs[2]] * var_seq[i] +
        df[j, coefs_ext[1]] * m_sim[j, i], df[j, coefs_ext[2]])
      d_sim[j, i] = rand(d)
    end
  end
  (m_sim, d_sim)
end


"""
# simulate

Generic simulate of predictions using callable returning distribution to sample from.

$(SIGNATURES)

## Required arguments
* `df::DataFrame`: data frame with parameters in each row
* `rx_to_dist::Function`: callable with two arguments: row object and x value. Have to return `Distribution` instance.
* `xrange`: iterable with arguments

## Optional arguments
* `return_dist::Bool = false`: if set to `true`, distributions will be returned, not their samples
* `seed::Int = missing`: sets the random seed

## Return value
Vector were each item is generated from every item in xrange argument.
Each item is again a vector obtained from `rx_to_dist` call to obtain a distribution and then sample from it.
If argument `return_dist=true`, sampling step will be omitted.

## Examples
```jldoctest
julia> using StatisticalRethinking, DataFrames, Distributions

julia> d = DataFrame(:mu => [1.0, 2.0], :sigma => [0.1, 0.2])
2×2 DataFrame
 Row │ mu       sigma
     │ Float64  Float64
─────┼──────────────────
   1 │     1.0      0.0
   2 │     2.0      0.0

julia> simulate(d, (r,x) -> Normal(r.mu+x, r.sigma), 0:1)
2-element Vector{Vector{Float64}}:
 [1.0, 2.0]
 [2.0, 3.0]

julia> simulate(d, (r,x) -> Normal(r.mu+x, r.sigma), 0:1, return_dist=true)
2-element Vector{Vector{Normal{Float64}}}:
 [Normal{Float64}(μ=1.0, σ=0.0), Normal{Float64}(μ=2.0, σ=0.0)]
 [Normal{Float64}(μ=2.0, σ=0.0), Normal{Float64}(μ=3.0, σ=0.0)]

```
"""
function simulate(df::DataFrame, rx_to_dist::Function, xrange; return_dist::Bool=false,
    seed::Union{Int,Missing} = missing)
  ismissing(seed) || Random.seed!(seed)

  [
    [
      begin
        dist = rx_to_dist(row, x)
        return_dist ? dist : rand(dist)
      end
      for x ∈ xrange
    ]
    for row ∈ eachrow(df)
  ]
end


export
  simulate
