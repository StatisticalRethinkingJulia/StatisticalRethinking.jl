# ### m8.1stan

# m8.1stan is the first model in the Statistical Rethinking book (pp. 249) using Stan.

# Here we will use Turing's NUTS support, which is currently (2018) the originalNUTS by [Hoffman & Gelman]( http://www.stat.columbia.edu/~gelman/research/published/nuts.pdf) and not the one that's in Stan 2.18.2, i.e., Appendix A.5 in: https://arxiv.org/abs/1701.02434

# The StatisticalRethinking pkg uses, e.g., Turing, CSV, DataFrames

using StatisticalRethinking

# Read in rugged data as a DataFrame

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "rugged.csv"), delim=';');

# Show size of the DataFrame (should be 234x51)
    
size(d)

# Apply log() to each element in rgdppc_2000 column and add it as a new column

d = hcat(d, map(log, d[Symbol("rgdppc_2000")]));

# Rename our col x1 => log_gdp

rename!(d, :x1 => :log_gdp);

# Now we need to drop every row where rgdppc_2000 == missing

# When this (https://github.com/JuliaData/DataFrames.jl/pull/1546) hits DataFrame it'll be conceptually easier: i.e., completecases!(d, :rgdppc_2000)

notisnan(e) = !ismissing(e)
dd = d[map(notisnan, d[:rgdppc_2000]), :];

# Updated DataFrame dd size (should equal 170 x 52)

size(dd) 

# Define the Turing model

@model m8_1stan(y, x₁, x₂) = begin
    σ ~ Truncated(Cauchy(0, 2), 0, Inf)
    βR ~ Normal(0, 10)
    βA ~ Normal(0, 10)
    βAR ~ Normal(0, 10)
    α ~ Normal(0, 100)

    for i ∈ 1:length(y)
        y[i] ~ Normal(α + βR * x₁[i] + βA * x₂[i] + βAR * x₁[i] * x₂[i], σ)
    end
end;

# Test to see that the model is sane. Use 2000 for now, as in the book.
# Need to set the same stepsize and adapt_delta as in Stan...

posterior = sample(m8_1stan(dd[:,:log_gdp], dd[:,:rugged], dd[:,:cont_africa]),
    Turing.NUTS(2000, 1000, 0.95));

# Describe the posterior samples

describe(posterior)

# Example of a Turing run simulation output

m_08_1t_turing_result = "
        Mean           SD        Naive SE        MCSE         ESS
α    9.2140454953  0.416410339 0.00931121825 0.0303436655  188.324543
βA  -1.9414588557  0.373885658 0.00836033746 0.0583949856   40.994586
βR  -0.1987645549  0.158902372 0.00355316505 0.0128657961  152.541295
σ    0.9722532977  0.440031013 0.00983939257 0.0203736871  466.473854
βAR  0.3951414223  0.187780491 0.00419889943 0.0276680621   46.062071
"

# Here's the map2stan output from rethinking

m_08_1_map2stan_result = "
       Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
 a      9.24   0.14       9.03       9.47   291    1
 bR    -0.21   0.08      -0.32      -0.07   306    1
 bA    -1.97   0.23      -2.31      -1.58   351    1
 bAR    0.40   0.13       0.20       0.63   350    1
 sigma  0.95   0.05       0.86       1.03   566    1
""