using StatisticalRethinking
using Turing

Turing.setadbackend(:reverse_diff)

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "chimpanzees.csv"), delim=';')
size(d) # Should be 504x8

# pulled_left, actor, condition, prosoc_left
@model m12_5(pulled_left, actor, block, condition, prosoc_left) = begin
    # Total num of y
    N = length(pulled_left)
    # Separate σ priors for each actor and block
    σ_actor ~ Truncated(Cauchy(0, 1), 0, Inf)
    σ_block ~ Truncated(Cauchy(0, 1), 0, Inf)

    # Number of unique actors in the data set
    N_actor = length(unique(actor)) #7
    N_block = length(unique(actor))

    # Vector of actors (1,..,7) which we'll set priors on
    α_actor = Vector{Real}(undef, N_actor)
    α_block = Vector{Real}(undef, N_block)

    # For each actor [1,..,7] and each block [1,..,6] set a prior N(0,σ_actor)
    α_actor ~ [Normal(0, σ_actor)]
    α_block ~ [Normal(0, σ_block)]

    # Prior for intercept, prosoc_left, and the interaction
    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    logitp = [α + α_actor[actor[i]] + α_block[block[i]] +
            (βp + βpC * condition[i]) * prosoc_left[i]
            for i = 1:N]

    # Thanks to Kai Xu for suggesting ones(Int64, N)
    pulled_left ~ VecBinomialLogit(ones(Int64, N), logitp)

end

posterior = sample(m12_5(
    Vector{Int64}(d[:pulled_left]),
    Vector{Int64}(d[:actor]),
    Vector{Int64}(d[:block]),
    Vector{Int64}(d[:condition]),
    Vector{Int64}(d[:prosoc_left])),
    Turing.NUTS(6000, 1000, 0.95))
describe(posterior)
#                Mean            SD         Naive SE        MCSE         ESS
# α_actor[1]   -1.13871505244  1.021214964 0.01318382850 0.06895961469  219.30306
# α_actor[2]    4.27029981488  1.636312322 0.02112470124 0.09673729050  286.11759
# α_actor[3]   -1.44955094702  1.006799943 0.01299773137 0.06692338610  226.32397
# α_actor[4]   -1.45545952069  1.014972954 0.01310324449 0.06742742421  226.58742
# α_actor[5]   -1.14448484224  1.016623688 0.01312455537 0.06814746797  222.54662
# α_actor[6]   -0.19321942877  1.016393875 0.01312158851 0.06768800631  225.47616
# α_actor[7]    1.34343156473  1.038893816 0.01341206150 0.06654947219  243.69863
# α_block[1]   -0.17452779898  0.238515803 0.00307922577 0.00828040137  829.71996
# α_block[2]    0.03980651259  0.191708160 0.00247494170 0.00256880080 5569.55298
# α_block[3]    0.05645849132  0.195415129 0.00252279846 0.00344012971 3226.76048
# α_block[4]    0.00740199127  0.190070041 0.00245379368 0.00279015970 4640.54740
# α_block[5]   -0.03335550081  0.194646823 0.00251287969 0.00277635002 4915.25672
# α_block[6]    0.11198371176  0.212284017 0.00274057488 0.00512718457 1714.26000
# α_block[7]   -0.00273742392  0.299448832 0.00386586780 0.00618228297 2346.10523
#          α    0.42521129611  1.003349135 0.01295318164 0.06724439123  222.63428
#         βp    0.83270139638  0.267910867 0.00345871442 0.00336241600 6000.00000
#        βpC   -0.14751307654  0.305572881 0.00394492893 0.00701893425 1895.34061
#    σ_actor    2.31737640716  0.981806474 0.01267506707 0.05001779873  385.30322
#    σ_block    0.22551167634  0.200429880 0.00258753863 0.00873889239  526.03199

# Rethinking
#             Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
# a_actor[1]  -1.19   0.98      -2.66       0.35  3451    1
# a_actor[2]   4.14   1.59       1.87       6.38  5514    1
# a_actor[3]  -1.49   0.99      -2.96       0.05  3493    1
# a_actor[4]  -1.50   0.98      -3.00       0.01  3340    1
# a_actor[5]  -1.19   0.99      -2.68       0.34  3447    1
# a_actor[6]  -0.25   0.99      -1.79       1.25  3361    1
# a_actor[7]   1.30   1.01      -0.21       2.89  3673    1
# a_block[1]  -0.19   0.23      -0.56       0.10  3825    1
# a_block[2]   0.04   0.19      -0.24       0.34  9346    1
# a_block[3]   0.06   0.19      -0.22       0.37  9202    1
# a_block[4]   0.00   0.18      -0.29       0.29 11314    1
# a_block[5]  -0.03   0.19      -0.33       0.25 10596    1
# a_block[6]   0.11   0.21      -0.16       0.45  6040    1
# a            0.47   0.97      -1.01       1.99  3273    1
# bp           0.83   0.26       0.40       1.24 13225    1
# bpc         -0.15   0.30      -0.61       0.36  8492    1
# sigma_actor  2.27   0.91       1.03       3.35  5677    1
# sigma_block  0.23   0.18       0.01       0.44  2269    1
