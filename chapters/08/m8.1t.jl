using StatisticalRethinking, Turing

Turing.setadbackend(:reverse_diff)
Turing.turnprogress(false) #nb

d = CSV.read(rel_path("..", "data",
    "rugged.csv"), delim=';');

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

posterior = sample(m8_1stan(dd[:log_gdp], dd[:rugged], dd[:cont_africa]),
    Turing.NUTS(2000, 200, 0.95));

describe(posterior)

m81turing = "
             Mean                SD             Naive SE           MCSE             ESS
α    9.2140454953  0.416410339 0.00931121825 0.0303436655  188.324543
βA  -1.9414588557  0.373885658 0.00836033746 0.0583949856   40.994586
βR  -0.1987645549  0.158902372 0.00355316505 0.0128657961  152.541295
σ    0.9722532977  0.440031013 0.00983939257 0.0203736871  466.473854
βAR  0.3951414223  0.187780491 0.00419889943 0.0276680621   46.062071
";

m81map2stan = "
       Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
 a      9.24   0.14       9.03       9.47   291    1
 bR    -0.21   0.08      -0.32      -0.07   306    1
 bA    -1.97   0.23      -2.31      -1.58   351    1
 bAR    0.40   0.13       0.20       0.63   350    1
 sigma  0.95   0.05       0.86       1.03   566    1
";#-
# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

