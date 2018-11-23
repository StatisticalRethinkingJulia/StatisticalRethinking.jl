using Turing

@model SampleFromPrior(y, use_data = true) = begin
    @assert typeof(use_data) == Bool

    N = length(y)
    y_pred = tzeros(Real, N)
    σ ~ Truncated(Cauchy(0, 5), 0, Inf)
    μ ~ Normal(10, 5)

    if use_data
        [y[i] ~ Normal(μ, σ) for i ∈ 1:N]
    else
        [y_pred[i] ~ Normal(μ, σ) for i ∈ 1:N]
    end
end

y = rand(Normal, 5)

chn = sample(SampleFromPrior(y, use_data=false), HMC(2000, 0.75, 5))
describe(chn)

chn2 = sample(SampleFromPrior(y, use_data=true), HMC(2000, 0.75, 5))
describe(chn2)

