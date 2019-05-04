# Load Julia packages (libraries) needed

# ### snippet 0.5 is replaced by below `using StatisticalRethinking`.

using StatisticalRethinking, GLM
gr(size=(500, 500));

# ### snippet 0.4

# Below `dataset(...)` provides access to often used R datasets.
# If this is not a common R dataset, see the chapter 4 snippets.

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
first(df, 5)

# Fit a linear regression of distance on speed

m = lm(@formula(height ~ weight), df)

# estimated coefficients from the model

coef(m)

# Plot residuals against speed

scatter( df[:height], residuals(m), xlab="Speed",
ylab="Model residual values", lab="Model residuals")
  
# End of `00/clip-04-05.jl`
