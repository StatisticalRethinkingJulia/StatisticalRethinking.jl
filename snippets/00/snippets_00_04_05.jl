using StatisticalRethinking
gr(size=(300, 300))

cars = dataset("datasets", "cars")

m = lm(@formula(Dist ~ Speed), cars)

coef(m)

fig1 = scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

