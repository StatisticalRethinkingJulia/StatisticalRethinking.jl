using StatisticalRethinking
using Turing, StatsFuns

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "reedfrogs.csv"), delim=';')
size(d) # Should be 48x5

# Set number of tanks
d[:tank] = 1:size(d,1)

@model m12_2(density, tank, surv) = begin

    # Separate priors on α and σ for each tank
    σ ~ Truncated(Cauchy(0,1), 0, Inf)
    α ~ Normal(0,1) #Check stancode this might need to be in the for loop below?

    # Number of unique tanks in the data set
    N_tank = length(tank)

    # Set an TArray for the priors/param
    a_tank = TArray{Any}(undef, N_tank)

    # For each tank [1,..,48] set a prior
    for i ∈ 1:length(a_tank)
        a_tank[i] ~ Normal(α,σ)
    end

    for i ∈ 1:length(N_tank)
        p = logistic(a_tank[tank[i]])
        surv[i] ~ Binomial(density[i], p)
    end
end

posterior = sample(m12_2(d[:density], d[:tank], d[:surv]),
    Turing.NUTS(4000, 2000, 0.95))
describe(posterior)
