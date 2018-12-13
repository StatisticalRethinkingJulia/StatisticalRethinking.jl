# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, Turing
gr(size=(600,300))

# ### snippet 4.7

howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1)

# Use only adults

df2 = filter(row -> row[:age] >= 18, df)

# Plot height density

density(df2[:height])
