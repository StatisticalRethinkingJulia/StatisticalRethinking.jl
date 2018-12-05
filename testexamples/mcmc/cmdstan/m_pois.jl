using StatisticalRethinking
#using Turing
#using StatsFuns #logistic

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "UCBadmit.csv"), delim=';')
size(d) # Should be 12x5

# Change male/female to 1/0
d[:admit] = map(x -> ifelse(x=="male", 1, 0), d[:admit])

# reject is a keyword
rename!(d, :reject => :rej)

@model m_pois(admit, rej) = begin
    α₁ ~ Normal(0,100)
    α₂ ~ Normal(0,100)

    for i ∈ 1:length(admit)
        λₐ = logistic(α₁)
        λᵣ = logistic(α₂)
        admit[i] ~ Poisson(λₐ)
        rej[i] ~ Poisson(λᵣ)
    end
end

posterior = sample(m_pois(d[:admit], d[:rej]), Turing.NUTS(2000, 1000, 0.95))
describe(posterior)
