# Load Julia packages (libraries) needed for clip

using StatisticalRethinking, GLM

ProjDir = @__DIR__

# Include snippets 5.19-5.21 

include(rel_path("..", "scripts", "05", "m5.3_A.jl"))

first(dfa, 5) |> display
println()

# Rethinking results

rethinking_results = "
           mean   sd  5.5% 94.5%
  a        0.00 0.10 -0.16  0.16
  bM      -0.07 0.15 -0.31  0.18
  bA      -0.61 0.15 -0.85 -0.37
  sigma    0.79 0.08  0.66  0.91
  aM       0.00 0.09 -0.14  0.14
  bAM     -0.69 0.10 -0.85 -0.54
  sigma_M  0.68 0.07  0.57  0.79
";

p = Particles(dfa)
display(p)

# Snippet 5.22

a_seq = range(-2, stop=2, length=100)

# Snippet 5.23

m_sim, d_sim = simulate(dfa, [:aM, :bAM, :sigma_M], a_seq, [:bM, :sigma])

# Snippet 5.24

plot(xlab="Manipulated A", ylab="Counterfactual D",
  title="Total counterfactual effect of A on D")
plot!(a_seq, mean(d_sim, dims=1)[1, :], leg=false)
hpdi_array = zeros(length(a_seq), 2)
for i in 1:length(a_seq)
  hpdi_array[i, :] =  hpdi(d_sim[i, :])
end
plot!(a_seq, mean(d_sim, dims=1)[1, :]; ribbon=(hpdi_array[:, 1], -hpdi_array[:, 2]))
savefig("$(ProjDir)/Fig-19-24.png")
