# Install all packages needed in StatisticalRethinking scripts

Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("Distributions")
Pkg.add("GLM")
Pkg.add("KernelDensity")
Pkg.add("MCMCChains")
Pkg.add("MonteCarloMeasurements")
Pkg.add("Optim")
Pkg.add("StanSample")
Pkg.add("StanOptimize")
Pkg.add("StatsPlots")
Pkg.add("StatsBase")
Pkg.add("LaTexStrings")

# Chapter 09 only
Pkg.add("DynamicHMC")
Pkg.add("LogDensityProblems")
Pkg.add("TransformVariables")

# Optional: update packages
Pkg.update()

# Optional: pre-compile packages
#Pkg.precompile()

# Optional: load packages
#using CSV, DataFrames, Distributions, GLM
#using KernelDensity, MCMCChains, MonteCarloMeasurements
#using Optim, StatsPlots
