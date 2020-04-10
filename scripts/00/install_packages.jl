# Install all packages needed in StatisticalRethinking scripts

# Alternative ways of computing quap estimates
Pkg.add("Optim")
Pkg.add("StanOptimize")

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
