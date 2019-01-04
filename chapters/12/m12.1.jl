using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "reedfrogs.csv"), delim=';')
size(d) # Should be 48x5

d[:tank] = 1:size(d,1)

@model m12_1(density, tank, surv) = begin

    N_tank = length(tank)

    a_tank = Vector{Real}(undef, N_tank)

    a_tank ~ [Normal(0,5)]

    logitp = [a_tank[tank[i]] for i = 1:N_tank]
    surv ~ VecBinomialLogit(density, logitp)
end

posterior = sample(m12_1(Vector{Int64}(d[:density]), Vector{Int64}(d[:tank]),
    Vector{Int64}(d[:surv])), Turing.NUTS(4000, 1000, 0.8))
describe(posterior)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

