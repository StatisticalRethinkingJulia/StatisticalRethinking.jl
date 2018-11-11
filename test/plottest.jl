# # Chapter 4 snippets

# ### snippet 4.0

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
gr(size=(600,300))

ProjDir = @__DIR__ #src
cd(ProjDir) #src

data = rand(1000)
p1 = plot(data)
p2 = density(data)
plot(p1, p2, layout=(1,2))
