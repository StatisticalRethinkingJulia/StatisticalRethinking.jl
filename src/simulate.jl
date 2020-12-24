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

export
  simulate
