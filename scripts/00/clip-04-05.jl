# Load Julia packages (libraries) needed

# ### snippet 0.5 is replaced by below `using StatisticalRethinking`.

using StatisticalRethinking, GLM
gr(size=(500, 500));

# ### snippet 0.4

# Below `dataset(...)` provides access to often used R datasets.
# If this is not a common R dataset, see the chapter 4 snippets.

cars = dataset("datasets", "cars");
first(cars, 5)

# Fit a linear regression of distance on speed

m = lm(@formula(Dist ~ Speed), cars)

# estimated coefficients from the model

coef(m)

# Plot residuals against speed

scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")
  
# End of `clip_04_05.jl`
