using StatisticalRethinking

ProjDir = @__DIR__
cd(ProjDir)

include("samplechain.jl")

describe(chns)

df = DataFrame(chns)

df_sample = sample(df, 5)
display(df_sample)
println()

chns_sample = sample(chns, 2048)
display(chns_sample)
println()

s = kde(df[:sigma])
plot(s.x, s.density, lab="df_kde")

l1 = size(Array(chns[:sigma]), 1)

c = kde(Array(chns[:sigma]))
plot!(c.x, c.density, lab="chns_kde")

chns_weighted_sample = sample(chns_sample, Weights(c.density), 100000)
display(chns_weighted_sample)
println()

l2 = size(Array(chns_weighted_sample[:sigma]), 1)

cw = kde(Array(chns_weighted_sample[:sigma]))
plot!(cw.x, cw.density, lab="chns_weighted_sample")

x1 = 4.0:0.00001:6.0
plot!(x1, pdf(cw, x1), lab="pdf_kde")
