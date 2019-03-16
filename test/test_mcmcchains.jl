using MCMCChains, Parameters, Statistics, DataFrames
using StatisticalRethinking: to_df

val = rand(10, 6, 3)

# Create a chain

chn = Chains(val,
  vcat(["p[$i]" for i in 1:3], ["α", "bp", "_lp"]),
  Dict(
    :parameters => vcat(["α", "bp"], ["p[$i]" for i in 1:3]),
    :internals => ["_lp"]
  )
);
describe(chn);
describe(chn, section=:internals);

# Make a chain with variables, using a Symbol for _lp

chn1 = Chains(val,
  vcat(["p[$i]" for i in 1:3], ["α", "bp", "_lp"]),
  Dict(
    :parameters => vcat(["α", "bp"], ["p[$i]" for i in 1:3]),
    :internals => Symbol.(["_lp"])          # <======= Should this case be caught?
  )
);
describe(chn1); 
#describe(chn1, section=:internals);   # <======= Fails

# Get p and a tuples from the chain.

x = get(chn, [:p, :α, :bp]);
length(x.p)
x.p[2]

@unpack α, p = get(chn, [:α, :p])
mean.(p, dims=1)

chn2 = set_section(chn, Dict(
  :parameters => ["α", "bp"],
  :pooled => ["p[$i]" for i in 1:3],
  :internals => ["_lp"]
  )
)

chn2.name_map

df = DataFrame(chn2)
df |> display
x.bp
