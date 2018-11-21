using StatisticalRethinking
gr(size=(300, 300))

println( "All models are wrong, but some are useful." )

x = 1:3
x = x*10
x = log.(x)
x = sum(x)
x = exp(x)
x = x*10
x = log(x)
x = sum(x)
x = exp(x)

log( 0.01^200 )
200 * log(0.01)

cars = dataset("datasets", "cars")

m = lm(@formula(Dist ~ Speed), cars)

coef(m)

fig1 = scatter( cars[:Speed], residuals(m),
  xlab="Speed", ylab="Model residual values", lab="Model residuals")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

