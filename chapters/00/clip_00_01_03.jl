# # Chapter 0 snippets

# ### snippet 0.0

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
gr(size=(300, 300))

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
