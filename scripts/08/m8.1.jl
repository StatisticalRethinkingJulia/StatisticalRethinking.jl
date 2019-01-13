# ### m8.1stan

# m8.1stan is the first model in the Statistical Rethinking book (pp. 249) using Stan.

# Here we will use Turing's NUTS support, which is currently (2018) the originalNUTS by [Hoffman & Gelman]( http://www.stat.columbia.edu/~gelman/research/published/nuts.pdf) and not the one that's in Stan 2.18.2, i.e., Appendix A.5 in: https://arxiv.org/abs/1701.02434

# The StatisticalRethinking pkg imports modules such as CSV and DataFrames

using StatisticalRethinking, Turing

Turing.setadbackend(:reverse_diff);
#nb Turing.turnprogress(false);

# Read in the `rugged` data as a DataFrame

d = CSV.read(rel_path("..", "data", "rugged.csv"), delim=';');

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

# Use Turing mcmc

posterior = sample(m8_1stan(dd[:log_gdp], dd[:rugged], dd[:cont_africa]), Turing.NUTS(2000, 200, 0.95));
    
# Describe the posterior samples

describe(posterior)

# Example of a Turing run simulation output

# Here's the ulam() output from rethinking (note that in above output the SD value is too large).

m8_1_map = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.22 0.14  8.98  9.43   242 1.00
bR    -0.20 0.08 -0.33 -0.07   235 1.00
bA    -1.95 0.23 -2.30 -1.58   202 1.00
bAR    0.39 0.14  0.17  0.61   268 1.00
sigma  0.95 0.05  0.87  1.04   307 1.01
";

m8_1_rethinking = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.22 0.14  8.98  9.43   242 1.00
bR    -0.20 0.08 -0.33 -0.07   235 1.00
bA    -1.95 0.23 -2.30 -1.58   202 1.00
bAR    0.39 0.14  0.17  0.61   268 1.00
sigma  0.95 0.05  0.87  1.04   307 1.01
";