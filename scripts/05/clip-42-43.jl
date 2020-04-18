# Load Julia packages (libraries) needed for clip

using StatisticalRethinking, GLM

ProjDir = @__DIR__

# Include snippets 5.42-5.43

n = 100
df = DataFrame(
  :M => rand(Normal(), n),
)
df[!, :NC] = [rand(Normal(df[i, :M]), 1)[1] for i in 1:n]
df[!, :K] = [rand(Normal(df[i, :NC] - df[i, :M]), 1)[1] for i in 1:n]

scale!(df, [:K, :M, :NC])

include(rel_path("..", "scripts", "05", "m5.7_A.jl"))

first(dfa, 5) |> display
println()

p = Particles(dfa)
display(p)

# Snippet 5.22

a_seq = range(-2, stop=2, length=100)

# Snippet 5.23

m_sim, d_sim = simulate(dfa, [:aNC, :bMNC, :sigma_NC], a_seq, [:bM, :sigma])

# Snippet 5.24

plot(xlab="Manipulated M", ylab="Counterfactual K",
  title="Total counterfactual effect of M on K")
plot!(a_seq, mean(d_sim, dims=1)[1, :], leg=false)
hpdi_array = zeros(length(a_seq), 2)
for i in 1:length(a_seq)
  hpdi_array[i, :] =  hpdi(d_sim[i, :])
end
plot!(a_seq, mean(d_sim, dims=1)[1, :]; ribbon=(hpdi_array[:, 1], -hpdi_array[:, 2]))
savefig("$(ProjDir)/Fig-42-43.png")

