using StatisticalRethinking
using Turing
# install: dev https://github.com/tpapp/AltDistributions.jl
using AltDistributions # for LKJL correlation matix

α = 3.5       # average morning wait time
β = (-1)      # average difference afternoon wait time
σ_a = 1        # std dev in intercepts
σ_b = 0.5      # std dev in slopes
ρ = (-0.7)    # correlation between intercepts and slopes

μ = [α , β]

# covariance
cov_ab = σ_a * σ_b * ρ

# var/covar matrix
Σ =  [σ_a^2 cov_ab; cov_ab σ_b^2]

N_cafes = 20

# Sample randomly from the multivariate Gaussian distribution defined by μ and Σ
vary_effects = rand(MvNormal(μ, Σ), N_cafes)

# Look at vary_effects now. It should be a matrix with 20 columns and 2 rows.
# Each column is a café. The first row contains intercepts. The second row
# contains slopes. For transparency, let's split these rows apart into nicely
# named vectors:
a_cafe = vary_effects[1,:] # intercepts
b_cafe = vary_effects[2,:] # slopes

# Number of visits per cafe
N_visits = 10

# The code below simulates 10 visits to each café (5 in the morning and 5 in the
# afternoon)
afternoon = repeat([0,1], convert(Int64, N_visits*N_cafes/2))
cafe_id = repeat(collect(1:20), inner=N_visits)

mu = a_cafe[cafe_id] .+ b_cafe[cafe_id] .* afternoon
σ = 0.5  # std dev *within* cafes

# Build our dataframe with all the data we need for our model
# use waiting since wait is a reserved word in Julia it seems...
waiting = rand.(Normal.(mu, σ))
d = DataFrame()
d.cafe_id = cafe_id
d.afternoon = afternoon
d.waiting = waiting

@model m13_1(cafe_id, afternoon, waiting) = begin

    α ~ Normal(0, 10)
    β ~ Normal(0, 10)
    σ_cafe ~ Truncated(Cauchy(0, 2), 0, Inf)
    σ ~ Truncated(Cauchy(0, 2), 0, Inf)

    # Prior for correlation matrix. This particular correlation matrix is only
    # 2-by-2 in size:
    # 1 ρ
    # ρ 1
    # McElreath (2018):
    # What [LKJL(2)] does is define a weakly informative prior on Ρ that is
    # skeptical of extreme correlations near −1 or 1. You can think of it as a
    # regularizing prior for correlations. This distribution has a single
    # parameter, η, that controls how skeptical the prior is of large
    # correlations in the matrix. When we use [LKJL(1)], the prior is flat over
    # all valid correlation matrices. When the value is greater than 1, such as
    # the 2 we use [below], then extreme correlations are less likely.
    ρ ~ LKJL(2)

    a_cafe ~ [MvNormal([α, β], σ_cafe, ρ)]
    b_cafe ~ [MvNormal([α, β], σ_cafe, ρ)]

    for i ∈ 1:length(cafe_id)
        mu = a_cafe[cafe_id[i]] + b_cafe[cafe_id[i]] * afternoon[i]
        wait[i] ~ Normal(mu, σ)
    end
end

posterior = sample(m13_1(d[:cafe_id], d[:afternoon], d[:waiting], a_cafe, b_cafe),
                        Turing.NUTS(5000, 2000, 0.95))
describe(posterior)
