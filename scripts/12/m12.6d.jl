using StatisticalRethinking
using CmdStan, StanMCMCChain

ProjDir = rel_path("..", "scripts", "12")

d = CSV.read(rel_path( "..", "data",  "Kline.csv"), delim=';');
size(d) # Should be 10x5

# New col logpop, set log() for population data
d[:logpop] = map((x) -> log(x), d[:population]);
d[:society] = 1:10;

first(d[[:total_tools, :logpop, :society]], 5)

# Input data for cmdstan

m12_6_1_data = Dict("total_tools" => d[:total_tools], "logpop" => d[:logpop], 
"society" => d[:society]);
        
# Describe the draws

describe(chn)

# End of 12/m12.6d.jl