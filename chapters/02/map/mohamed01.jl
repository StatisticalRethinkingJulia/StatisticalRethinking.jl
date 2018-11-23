using Turing

@model gdemo(x, y) = begin
    s ~ InverseGamma(2,3)
    m ~ Normal(0,sqrt(s))
    x ~ Normal(m, sqrt(s))
    y ~ Normal(m, sqrt(s))
    return s, m
end
x = 1.5
y = 2.0
model = gdemo(x, y)
vi = Turing.VarInfo()
model(vi, Turing.SampleFromPrior())

function nlogp(sm)
    vi.vals .= sm
    model(vi, Turing.SampleFromPrior())
    -vi.logp
end

using Optim
sm_0 = Float64.(vi.vals)
lb = [0.0, -Inf]
ub = [Inf, Inf]
result = optimize(nlogp, lb, ub, sm_0, Fminbox())
