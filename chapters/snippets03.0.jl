# # Chapter 23snippets

# ### snippet 230

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using Distributions, RDatasets, DataFrames, Plots

# Package `RDatasets` provides access to the often used R datasets.
# See RData if you have local .rda files.

# Package `DataFrames` supports a Julia implementation DataFrames.

# Package `Plos` is one of the available plotting options in Julia.
# By default Plots uses GR as the .

ProjDir = dirname(@__FILE__) #src
cd(ProjDir) #src

# snippet 3.1
