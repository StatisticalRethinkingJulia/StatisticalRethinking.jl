using StatisticalRethinking, GLM
gr(size=(500, 500));

cars = dataset("datasets", "cars");
first(cars, 5)

m = lm(@formula(Dist ~ Speed), cars)

coef(m)

scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

