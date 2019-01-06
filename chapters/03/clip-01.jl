using StatisticalRethinking

PrPV = 0.95
PrPM = 0.01
PrV = 0.001
PrP = PrPV*PrV + PrPM*(1-PrV)
PrVP = PrPV*PrV / PrP

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

