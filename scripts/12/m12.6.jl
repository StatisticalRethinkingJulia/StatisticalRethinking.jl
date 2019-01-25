using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)
#nbTuring.turnprogress(false);

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "Kline.csv"), delim=';');
size(d) # Should be 10x5

# New col log_pop, set log() for population data
d[:log_pop] = map((x) -> log(x), d[:population]);
d[:society] = 1:10;

# Turing model

@model m12_6(total_tools, log_pop, society) = begin

    # Total num of y
    N = length(total_tools)

    # priors
    α ~ Normal(0, 10)
    βp ~ Normal(0, 1)

    # Separate σ priors for each society
    σ_society ~ Truncated(Cauchy(0, 1), 0, Inf)

    # Number of unique societies in the data set
    N_society = length(unique(society)) #10

    # Vector of societies (1,..,10) which we'll set priors on
    α_society = Vector{Real}(undef, N_society)

    # For each society [1,..,10] set a prior N(0, σ_society)
    α_society ~ [Normal(0, σ_society)]

    for i ∈ 1:N
        λ = exp(α + α_society[society[i]] + βp*log_pop[i])
        total_tools[i] ~ Poisson(λ)
    end
end

# Sample

posterior = sample(m12_6(d[:total_tools], d[:log_pop],
    d[:society]), Turing.NUTS(5000, 2000, 0.95));

# Fix the inclusion of adaptation samples

posterior2 = MCMCChain.Chains(posterior.value[2001:5000,:,:], names=posterior.names)

# Describe the posterior samples

describe(posterior2)


# Results rethinking

m126rethinking = "
              Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
a              1.11   0.75      -0.05       2.24  1256    1
bp             0.26   0.08       0.13       0.38  1276    1
a_society[1]  -0.20   0.24      -0.57       0.16  2389    1
a_society[2]   0.04   0.21      -0.29       0.38  2220    1
a_society[3]  -0.05   0.19      -0.36       0.25  3018    1
a_society[4]   0.32   0.18       0.01       0.60  2153    1
a_society[5]   0.04   0.18      -0.22       0.33  3196    1
a_society[6]  -0.32   0.21      -0.62       0.02  2574    1
a_society[7]   0.14   0.17      -0.13       0.40  2751    1
a_society[8]  -0.18   0.19      -0.46       0.12  2952    1
a_society[9]   0.27   0.17      -0.02       0.52  2540    1
a_society[10] -0.10   0.30      -0.52       0.37  1433    1
sigma_society  0.31   0.13       0.11       0.47  1345    1
";
