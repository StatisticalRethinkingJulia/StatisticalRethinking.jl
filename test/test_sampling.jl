using StatisticalRethinking
import StatsBase: sample

ProjDir = @__DIR__
cd(ProjDir)

include("../test/samplechain.jl")

describe(chn)

df = DataFrame(chn)

df_sample = sample(df, 5)
display(df_sample)
println()

chn_sample = sample(chn, 2048)
display(chn_sample)
println()

s = kde(df[:sigma])
plot(s.x, s.density, lab="df_kde")

c = kde(Array(chn[:sigma]))
plot!(c.x, c.density, lab="chn_kde")

chn_weighted_sample = sample(chn_sample, Weights(c.density), 100000)
display(chn_weighted_sample)
println()
cw = kde(chain_to_array(chn_weighted_sample[:sigma]))
plot!(cw.x, cw.density, lab="chn_weighted_sample")

x1 = 4.0:0.00001:6.0
plot!(x1, pdf(cw, x1), lab="pdf_kde")

