"""

# maximum_a_posterior 

Compute the maximum_a_posteriori of a model. 

### Method
```julia
maximum_a_posteriori(model, lower_bound, upper_bound)
```
### Required arguments
```julia
* `model::Turing model`
* `lower_bound::Float64`
```

### Return values
```julia
* `result`                       : Maximum_a_posterior vector
```

### Examples

See ...

"""
function maximum_a_posteriori(model, lower_bound, upper_bound)
  
  vi = Turing.VarInfo()
  model(vi, Turing.SampleFromPrior())
  
  # Define a function to optimize.
  function nlogp(sm)
    vi.vals .= sm
    model(vi, Turing.SampleFromPrior())
    -vi.logp
  end

  start_value = Float64.(vi.vals)
  optimize((v)->nlogp(v), lower_bound, upper_bound, start_value, Fminbox())
end