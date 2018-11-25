using StatisticalRethinking

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


# Define the simple gdemo model.
@model gdemo(x, y) = begin
    s ~ InverseGamma(2,3)
    m ~ Normal(0,sqrt(s))
    x ~ Normal(m, sqrt(s))
    y ~ Normal(m, sqrt(s))
    return s, m
end

# Define our data points.
x = 1.5
y = 2.0

# Set search bounds
lb = [0.0, -Inf]
ub = [Inf, Inf]

model = gdemo(x, y)

result = maximum_a_posteriori(model, lb, ub)
println()

result.minimizer
