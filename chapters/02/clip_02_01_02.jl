# # Chapter 2 snippets

# ### snippet 2.0

# Load Julia packages (libraries) needed

using StatisticalRethinking
gr(size=(600,300))

ProjDir = dirname(@__FILE__) #src
cd(ProjDir) #src

# snippet 2.1

@show ways  = [0  , 3 , 8 , 9 , 0 ];
@show ways/sum(ways)

# snippet 2.2

@show d = Binomial(9, 0.5);
@show pdf(d, 6)

