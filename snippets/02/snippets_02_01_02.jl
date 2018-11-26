using StatisticalRethinking
gr(size=(600,300))

@show ways  = [0  , 3 , 8 , 9 , 0 ];
@show ways/sum(ways)

@show d = Binomial(9, 0.5);
@show pdf(d, 6)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

