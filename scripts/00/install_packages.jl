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

# Chapter 09 only
Pkg.add("DynamicHMC")
Pkg.add("LogDensityProblems")
Pkg.add("TransformVariables")

# To update these packages:
Pkg.update()

# To pre-compile:
Pkg.precompile()
