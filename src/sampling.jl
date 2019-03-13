import StatsBase: sample
using Random

# sample([rng], a, [wv::AbstractWeights], n::Integer; replace=true, ordered=false)
function sample(rng::AbstractRNG, chn::MCMCChains.AbstractChains, n;
    replace=true, ordered=false) 
  indxs = sample(rng,1:size(chn,1), n,
    replace=replace, ordered=ordered)
  Chains(chn.value[indxs, :, :], names(chn), chn.name_map)
end
function sample(chn::MCMCChains.AbstractChains, n;
    replace=true, ordered=false) 
  indxs = sample(Random.GLOBAL_RNG, 1:size(chn,1), n,
    replace=replace, ordered=ordered)
  Chains(chn.value[indxs, :, :], names(chn), chn.name_map)
end

function sample(rng::AbstractRNG, df::DataFrame, n;
    replace=true, ordered=false)
  indxs = sample(rng, 1:size(df,1), n,
    replace=replace, ordered=ordered)
  df[indxs, :]
end
function sample(df::DataFrame, n;
    replace=true, ordered=false)
  indxs = sample(Random.GLOBAL_RNG, 1:size(df,1), n,
    replace=replace, ordered=ordered)
  df[indxs, :]
end
