using StatisticalRethinking, Turing

Turing.setadbackend(:reverse_diff);

d = CSV.read(rel_path("..", "data", "rugged.csv"), delim=';');

size(d)

d = hcat(d, map(log, d[Symbol("rgdppc_2000")]));

rename!(d, :x1 => :log_gdp);

notisnan(e) = !ismissing(e)
dd = d[map(notisnan, d[:rgdppc_2000]), :];

size(dd)

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

posterior = sample(m8_1stan(dd[:log_gdp], dd[:rugged], dd[:cont_africa]), Turing.NUTS(2000, 200, 0.95));

describe(posterior)

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
";#-
# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

