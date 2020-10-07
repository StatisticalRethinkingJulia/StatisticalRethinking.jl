# Not quite sure yet how to do these cross mcmc tests inside SR's test dir.

using Markdown
using InteractiveUtils
using Test
using Pkg, DrWatson

begin
  #@quickactivate "StatisticalRethinking"
  using Turing
  using StatisticalRethinking
end

md"## Clip-05-01-27t.jl"

begin
  df = CSV.read(sr_datadir("WaffleDivorce.csv"), DataFrame)
  df.D = zscore(df.Divorce)
  df.M = zscore(df.Marriage)
  df.A = zscore(df.MedianAgeMarriage)
end

std(df.MedianAgeMarriage)

@model function m5_1_A(A, D)
    a ~ Normal(0, 0.2)
    bA ~ Normal(0, 0.5)
    σ ~ Exponential(1)
    μ = lin(a, A, bA)
    D ~ MvNormal(μ, σ)
end

begin
    m5_1_At = m5_1_A(df.A, df.D)
  quap5_1_At = quap(m5_1_At)
  post5_1_At = DataFrame(rand(quap5_1_At.distr, 1000)', quap5_1_At.params)

  A_seq = range(-3, 3.2, length = 30)
  mu5_1_At = lin(post5_1_At.a', A_seq, post5_1_At.bA') |> meanlowerupper

  scatter(df.A, df.D, alpha = 0.4, legend = false)
  plot!(A_seq, mu5_1_At.mean, ribbon =
        (mu5_1_At.mean .- mu5_1_At.lower, mu5_1_At.upper .- mu5_1_At.mean))
end


@model function m5_1_M(M, D)
    a ~ Normal(0, 0.2)
    bM ~ Normal(0, 0.5)
    σ ~ Exponential(1)
    μ = lin(a, M, bM)
    D ~ MvNormal(μ, σ)
end

begin
    m5_1_Mt = m5_1_M(df.M, df.D)
    quap5_1_Mt = quap(m5_1_Mt)
    post5_1_Mt = DataFrame(rand(quap5_1_Mt.distr, 1000)', quap5_1_Mt.params)

    M_seq = range(-3, 3.2, length = 30)
    mu5_1_Mt = lin(post5_1_Mt.a', M_seq, post5_1_Mt.bM') |> meanlowerupper

    scatter(df.M, df.D, alpha = 0.4, legend = false)
    plot!(M_seq, mu5_1_Mt.mean, ribbon =
        (mu5_1_Mt.mean .- mu5_1_Mt.lower, mu5_1_Mt.upper .- mu5_1_Mt.mean))
end

@model function m5_1_A_M(A, M, D)
    a ~ Normal(0, 0.2)
    bM ~ Normal(0, 0.5)
    bA ~ Normal(0, 0.5)
    σ ~ Exponential(1)
    μ = lin(a, A, bA, M, bM)
    D ~ MvNormal(μ, σ)
end

begin
    m5_1_A_Mt = m5_1_A_M(df.A, df.M, df.D)
    quap5_1_A_Mt = quap(m5_1_A_Mt)
    post5_1_A_Mt = DataFrame(rand(quap5_1_A_Mt.distr, 1000)', quap5_1_A_Mt.params)

    A_M_seq = range(-3, 3.2, length = 30)
    mu5_1_A_Mt = lin(post5_1_A_Mt.a', A_M_seq, post5_1_A_Mt.bM') |> meanlowerupper

    scatter(df.M, df.D, alpha = 0.4, legend = false)
    plot!(M_seq, mu5_1_A_Mt.mean, ribbon = 
        (mu5_1_A_Mt.mean .- mu5_1_A_Mt.lower, mu5_1_A_Mt.upper .- mu5_1_A_Mt.mean))
end

s, p = plotcoef(
    [m5_1_At, m5_1_Mt, m5_1_A_Mt], 
    ["m5_1_At", "m5_1_Mt", "m5_1_A_Mt"], 
    [:a, :bM, :bA, :σ]

)

@test length(s) == 3
@test s[1].a.mean ≈ 0.0 atol=0.01
@test s[1].bA.mean = -0.56 atol=0.01

