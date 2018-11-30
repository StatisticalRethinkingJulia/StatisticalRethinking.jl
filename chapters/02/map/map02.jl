using StatisticalRethinking

data = (n = 9, k = 6)

@model globe_toss(n, k) = begin
  #prior
  theta ~ Uniform(0, 1)
  #model
  k ~ Binomial(n, theta)
end

chn = sample(globe_toss(data.n, data.k), HMC(2000, 0.75, 5))
println()
describe(chn[:theta])
println()

# Maximum_a_posterior computation

model = globe_toss(data.n, data.k)
vi = Turing.VarInfo()
model(vi, Turing.SampleFromPrior())

function nlogp(sm, vi=vi)
    vi.vals .= sm
    model(vi, Turing.SampleFromPrior())
    -vi.logp
end

sm_0 = Float64.(vi.vals)
lb = [0.0]
ub = [1.0]
result = optimize(nlogp, lb, ub, sm_0, Fminbox())

result.minimizer |> display
println()

maximum_a_posteriori(model, lb, ub)
