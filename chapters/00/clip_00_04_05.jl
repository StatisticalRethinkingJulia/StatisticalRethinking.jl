# # Chapter 0 snippets

# Load Julia packages (libraries) needed

# ### snippet 0.0

using StatisticalRethinking
gr(size=(300, 300))

ProjDir = dirname(@__FILE__) #src
cd(ProjDir) #src

# ### snippet 0.4

# `dataset(...)` provides access to often used R datasets.

cars = dataset("datasets", "cars") 
@show cars = dataset("datasets", "cars") #src
println() #src

# If this is not a common R dataset, use e.g.:
# howell1 = CSV.read(joinpath(ProjDir, "..", "..",  "data", "Howell1.csv"), delim=';')
# df = convert(DataFrame, howell1)

# This reads the Howell1.csv dataset in the data subdirectory of this package,
#  StatisticalRethinking.jl. See also the chapter 4 snippets.

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
  
# Save the plot

savefig("clip_00_05.pdf") #src

# ### snippet 0.5

# Thie contents of this snipper is partially replaced by snippet 0.0.
# If any of these packages is not installed in your Julia system,
# you can add it by e.g. `Pkg.add("RDatasets")`
