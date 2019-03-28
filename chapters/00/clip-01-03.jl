using StatisticalRethinking

println( "All models are wrong, but some are useful." );

x = 1:3

x = x*10

x = log.(x)

x = sum(x)

x = exp(x)
x = x*10
x = log(x)
x = sum(x)
x = exp(x)

[log(0.01^200) 200 * log(0.01)]

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

