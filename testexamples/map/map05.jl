using StatisticalRethinking

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

chn = sample(gdemo(), SMC(1000))
describe(chn)

chn = sample(gdemo(x, y), SMC(1000))
describe(chn)
