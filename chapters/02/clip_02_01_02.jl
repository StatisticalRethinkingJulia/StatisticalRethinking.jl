# # `Snippets_02_01_02`

# Load Julia packages (libraries) needed

using StatisticalRethinking
gr(size=(600,300))

# snippet 2.1

ways  = [0, 3, 8, 9, 0]

#

ways/sum(ways)

# snippet 2.2

d = Binomial(9, 0.5)
pdf(d, 6)

