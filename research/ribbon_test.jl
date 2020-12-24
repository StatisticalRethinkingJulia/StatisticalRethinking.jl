# Load Julia packages (libraries) needed for clip

using StatisticalRethinking, GLM

ProjDir = @__DIR__

n = 100
df = DataFrame(:M => rand(Normal(), n));
df[!, :NC] = [rand(Normal(df[i, :M])) for i in 1:n];
df[!, :K] = [rand(Normal(df[i, :NC] - df[i, :M])) for i in 1:n];
scale!(df, [:K, :M, :NC])

include("$(ProjDir)/m5.7_A.jl") 

first(dfa, 5) |> display
println()

#plotbounds(df, :NC, :K, dfa, [:a, :bN, :sigma])

p = Particles(dfa)
a_seq = range(-2, stop=2, length=100)
m_sim, d_sim = simulate(dfa, [:aNC, :bMNC, :sigma_NC], a_seq, [:bM, :sigma])

plot(xlab="Manipulated M", ylab="Counterfactual K",
  title="Total counterfactual effect of M on K")
plot!(a_seq, mean(d_sim, dims=1)[1, :], leg=false)
hpdi_array = zeros(length(a_seq), 2)
for i in 1:length(a_seq)
  hpdi_array[i, :] =  hpdi(d_sim[i, :])
end
plot!(a_seq, mean(d_sim, dims=1)[1, :]; ribbon=(hpdi_array[:, 1], -hpdi_array[:, 2]))
savefig("$(ProjDir)/ribbon.png")
