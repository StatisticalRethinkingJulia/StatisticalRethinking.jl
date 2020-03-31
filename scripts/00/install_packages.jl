# Install all packages needed in StatisticalRethinking scripts

# MCMCChains                           # includes glue code
Pkg.add("MCMCChains")                  # for e.g. plot(chns)

# Alternative ways of computing quap estimates
Pkg.add("Optim")
Pkg.add("StanOptimize")

# For plotting
Pkg.add("StatsPlots")
Pkg.add("LaTexStrings")                # For greek characters
                                       # E.g. 04-part-2/clip-37-44a.jl
# Used occasionally
Pkg.add("GLM")
Pkg.add("LinearAlgebra")

# Chapter 09 only (currently)
Pkg.add("LogDensityProblems")          # includes glue code
Pkg.add("DynamicHMC")
Pkg.add("TransformVariables")

# Optional: update packages
Pkg.update()

# Optional: pre-compile packages
#Pkg.precompile()
