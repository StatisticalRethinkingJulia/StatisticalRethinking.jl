using StatisticalRethinking
import StatsBase: sample

ProjDir = @__DIR__
cd(ProjDir)

include("../test/samplechain.jl")

describe(chn)

df = to_df(chn)

df_sample = sample(df, 5)
display(df_sample)
println()

chn_sample = sample(chn, 5)
display(chn_sample)
println()

s = kde(df[:sigma])
#plot(s.x, s.density)
