using StatisticalRethinking, KernelDensity
import StatsBase: sample

ProjDir = @__DIR__
cd(ProjDir)

include("../test/sampletest.jl")

describe(chn)

df = to_df(chn)
s = kde(df[:sigma])

# sample([rng], a, [wv::AbstractWeights], n::Integer; replace=true, ordered=false)
function sample(chn::MCMCChains.AbstractChains, n;
    replace=true, ordered=false) 
  indxs = sample(1:size(chn,1), n,
    replace=replace, ordered=ordered)
  Chains(chn.value[indxs, :, :], names(chn), chn.name_map)
end

function sample(df::DataFrame, n;
    replace=true, ordered=false)
  indxs = sample(1:size(df,1), n,
    replace=replace, ordered=ordered)
  df[indxs, :]
end

#plot(s.x, s.density)

df = to_df(chn)

df_sample = sample(df, 5)
display(df_sample)
println()

chn_sample = sample(chn, 5)
