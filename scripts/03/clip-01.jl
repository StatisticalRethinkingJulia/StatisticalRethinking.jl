# # clip-01.jl

# ### snippet 3.1

PrPV = 0.95
PrPM = 0.01
PrV = 0.001
PrP = PrPV*PrV + PrPM*(1-PrV)
PrVP = PrPV*PrV / PrP

# End of `03/clip-01.jl`
