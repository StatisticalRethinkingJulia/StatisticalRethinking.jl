# Load Julia packages (libraries) needed

# ### snippet 0.5 is replaced by below `using StatisticalRethinking`.

using StatisticalRethinking, GLM
gr(size=(500, 500));

# ### snippet 0.4

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

# Fit a linear regression of distance on speed

m = lm(@formula(height ~ weight), df2)

# estimated coefficients from the model

coef(m)

# Plot residuals against speed

scatter( df2[:height], residuals(m), xlab="Height",
ylab="Model residual values", lab="Model residuals")
  
# End of `00/clip-04-05.jl`
