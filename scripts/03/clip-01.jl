# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking

# ### snippet 3.1

PrPV = 0.95
PrPM = 0.01
PrV = 0.001
PrP = PrPV*PrV + PrPM*(1-PrV)
PrVP = PrPV*PrV / PrP

# End of `clip_01.jl`
