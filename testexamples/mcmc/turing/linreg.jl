using StatisticalRethinking


@model linreg(y, x₁, x₂) = begin
    N = length(y)
    σ ~ Truncated(Cauchy(0, 2), 0, Inf)
    βR ~ Normal(0, 10)
    βA ~ Normal(0, 10)
    α ~ Normal(0, 100)
    for i ∈ 1:N
        y[i] ~ Normal(α + βR * x₁[i] + βA * x₂[i], σ)
    end
    return βR, βA, σ
end

x₁ = [1.0, 3.0, 4.0, 6.0, 2.0]
x₂ = [3.0, 4.0, 2.0, 5.0, 9.0]
y = 3.0 .+ 5.0x₁ .+ 7.0x₂

chn = sample(linreg(y, x₁, x₂), NUTS(1000, 0.65))

describe(chn)
