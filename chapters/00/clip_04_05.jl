# Load Julia packages (libraries) needed

using StatisticalRethinking
gr(size=(300, 300))

# ### snippet 0.4

# Below `dataset(...)` provides access to often used R datasets.

cars = dataset("datasets", "cars")

# If this is not a common R dataset, use e.g.:
# howell1 = CSV.read(joinpath(ProjDir, "..", "..",  "data", "Howell1.csv"), delim=';')
# df = convert(DataFrame, howell1)

# This reads the Howell1.csv dataset in the data subdirectory of this package,
#  StatisticalRethinking.jl. See also the chapter 4 snippets.

# Fit a linear regression of distance on speed

m = lm(@formula(Dist ~ Speed), cars)

# estimated coefficients from the model

coef(m)

# Plot residuals against speed

scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")
  
# ### snippet 0.5 is replaced by above `using StatisticalRethinking`.
