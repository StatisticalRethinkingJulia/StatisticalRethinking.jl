function maximum_a_posteriori(model, lower_bound, upper_bound)
  
  vi = Turing.VarInfo()
  model(vi, Turing.SampleFromPrior())
  
  # Define a function to optimize.
  function nlogp(sm, vi=vi)
    vi.vals .= sm
    model(vi, Turing.SampleFromPrior())
    -vi.logp
  end

  vi = Turing.VarInfo()
  start_value = Float64.(vi.vals)
  model(vi, Turing.SampleFromPrior())
    
  result = optimize(nlogp, lower_bound, upper_bound, start_value, Fminbox())
end