# # Chapter 0 snippets

# ### snippet 0.0

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using RDatasets, DataFrames, GLM, Plots

# Package `RDatasets` provides access to the often used R datasets.
# See RData if you have local .rda files.

# Package `DataFrames` supports a Julia implementation DataFrames.

# Package `Plos` is one of the available plotting options in Julia.
# By default Plots uses GR as the .

ProjDir = dirname(@__FILE__) #src
cd(ProjDir) #src

# ### snippet 0.1

println( "All models are wrong, but some are useful." )

# ### snippet 0.2

# This is a StepRange, not a vector

x = 1:3
@show x = 1:3;  #src
x = x*10
@show x = x*10 #src
x = log.(x)
@show log.(x) #src
x = sum(x)
@show x = sum(x) #src
x = exp(x)
@show x = exp(x) #src
println() #src
x = x*10
x = log(x)
x = sum(x)
x = exp(x)
@show x #src
println() #src

# ### snippet 0.3

log( 0.01^200 )
@show ( log( 0.01^200 ) ) #src
200 * log(0.01)
@show ( 200 * log(0.01) ) #src
println() #src

# ### snippet 0.4

# `dataset(...)` provides access to often used R datasets.

cars = dataset("datasets", "cars") 
@show cars = dataset("datasets", "cars") #src
println()

# Fit a linear regression of distance on speed

m = lm(@formula(Dist ~ Speed), cars)
@show m = lm(@formula(Dist ~ Speed), cars) #src
println() #src

# estimated coefficients from the model

coef(m)
@show coef(m) #src
println() #src

# Plot residuals against speed

fig1 = scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")

#savefig("Chapter00snippet00.pdf") #src

# ### snippet 0.5

# Thie contents of this snipper is partially replaced by snippet 0.0.
# If any of these packages is not installed in your Julia system,
# you can add it by e.g. `Pkg.add("RDatasets")`
