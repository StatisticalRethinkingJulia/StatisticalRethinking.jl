# Install all packages needed in StatisticalRethinking scripts

# Used in most examples
Pkg.add("CSV")
Pkg.add("DataFrames")                  # includes gluecode
Pkg.add("Distributions")
Pkg.add("StanSample")
Pkg.add("StatsBase")
Pkg.add("Statistics")

# Particles and quap()                 # includes glue code if
Pkg.add("KernelDensity")               # both are loaded!
Pkg.add("MonteCarloMeasurements")

# MCMCChains                           # includes glue code
Pkg.add("MCMCChains")                  # StatsPlots for plot(chns)

# Alternative ways of computing quap estimates
Pkg.add("Optim")
Pkg.add("StanOptimize")

# For plotting
Pkg.add("StatsPlots")
Pkg.add("LaTexStrings")                # For greek characters
                                       # E.g. 04-part-2/clip-37-44a.jl
# Used occasionally
Pkg.add("GLM")

# Chapter 09 only (currently)
Pkg.add("LogDensityProblems")          # includes glue code
Pkg.add("DynamicHMC")
Pkg.add("TransformVariables")

# Optional: update packages
Pkg.update()

# Optional: pre-compile packages
#Pkg.precompile()

# Optional: load packages
#using CSV, DataFrames, Distributions, GLM
#using StatsBase, Statistics
#using KernelDensity, MonteCarloMeasurements
#using MCMCChains 
#using StatsPlots
#using Opyim
