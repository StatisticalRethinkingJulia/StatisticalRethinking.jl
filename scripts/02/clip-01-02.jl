# Load Julia packages (libraries) needed

using StatisticalRethinking

# snippet 2.1

ways  = [0, 3, 8, 9, 0];
ways/sum(ways)

# snippet 2.2

# Create a distribution with n = 9 (e.g. tosses) and p = 0.5.

d = Binomial(9, 0.5)

# Probability density for 6 `waters` holding n = 9 and p = 0.5.

pdf(d, 6)

# End of `02/clip-01-02.jl`
