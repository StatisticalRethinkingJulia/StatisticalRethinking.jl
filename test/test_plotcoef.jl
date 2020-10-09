
using Markdown
using InteractiveUtils

using DrWatson

begin
  @quickactivate "StatisticalRethinkingTuring"
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

function plotcoef1(
  models::Vector{T},
  mnames::Vector{String},
  pars::Vector{Symbol};
  fig="", title="", func=nothing,
  sampler=NUTS(0.65), nsamples=2000, nchains=4) where {T <: DynamicPPL.Model}

  # mnames = [nameof(m) for m in models]
  levels = length(models) * (length(pars) + 1)
  colors = [:blue, :red, :green, :darkred, :black]

  s = Vector{NamedTuple}(undef, length(models))
  for (mindx, mdl) in enumerate(models)
    if isnothing(func)
        chns = mapreduce(c -> sample(mdl, sampler, nsamples),
            chainscat, 1:nchains)
        df = DataFrame(Array(chns), names(chns, [:parameters]))
        m, l, u = estimparam(df)
        d = Dict{Symbol, NamedTuple}()
        for (indx, par) in enumerate(names(chns, [:parameters]))
            d[par] = (mean=m[indx], lower=l[indx], upper=u[indx])
        end
        s[mindx] =   (; d...)
    else
        quap_mdl = quap(mdl)
        post = rand(quap_mdl.distr, 10_000)
        df = DataFrame(post', [keys(quap_mdl.coef)...])
        m, l, u = estimparam(df)
        d = Dict{Symbol, NamedTuple}()
        for (indx, par) in enumerate([keys(quap_mdl.coef)...])
            d[par] = (mean=m[indx], lower=l[indx], upper=u[indx])
        end
        s[mindx] =   (; d...)
    end
  end

  xmin = 0; xmax = 0.0
  for i in 1:length(s)
    for par in pars
      syms = Symbol.(keys(s[i]))
      if Symbol(par) in syms
        mp = s[i][par].mean
        xmin = min(xmin, s[i][par].lower)
        xmax = max(xmax, s[i][par].upper)
      end
    end
  end

  ylabs = String[]
  for j in 1:length(models)
    for i in 1:length(pars)
      l = length(String(pars[i]))
      str = repeat(" ", 9-l) * String(pars[i])
      append!(ylabs, [str])
    end
    l = length(mnames[j])
    str = mnames[j] * repeat(" ", 9-l)
    append!(ylabs, [str])
  end

  ys = [string(ylabs[i]) for i = 1:length(ylabs)]
  p = plot(xlims=(xmin, xmax), leg=false, framestyle=:grid)
  title!(title)
  yran = range(1, stop=length(ylabs), length=length(ys))
  yticks!(yran, ys)

  line = 0
  for (mindx, model) in enumerate(models)
    line += 1
    hline!([line] .+ length(pars), color=:darkgrey, line=(2, :dash))
    for (pindx, par) in enumerate(pars)
      line += 1
      syms = Symbol.(keys(s[mindx]))
      if Symbol(par) in syms
        ypos = (line - 1)
        mp = s[mindx][Symbol(par)].mean
        lower = s[mindx][Symbol(par)].lower
        upper = s[mindx][Symbol(par)].upper
        plot!([lower, upper], [ypos, ypos], leg=false, color=colors[pindx])
        scatter!([mp], [ypos], color=colors[pindx])
      end
    end
  end
  if length(fig) > 0
    savefig(p, fig)
  end
  (s, p)
end

s1, p1 = plotcoef(
    [m5_1_At, m5_1_Mt, m5_1_A_Mt], 
    [:a, :bM, :bA, :σ]
)

s1 |> display

plot(p1)

gui()

s2, p2 = plotcoef(
    [m5_1_At, m5_1_Mt, m5_1_A_Mt], 
    [:a, :bM, :bA, :σ];
    func=quap
)

s2 |> display

plot(p2)

gui()

s3, p3 = plotcoef(
    [m5_1_At], 
    [:a, :bM, :bA, :σ]
)

s3 |> display

plot(p3)

gui()

s4, p4 = plotcoef(
    m5_1_At, 
    [:a, :bM, :bA, :σ];
    func=quap
)

s4 |> display

plot(p4)

gui()
