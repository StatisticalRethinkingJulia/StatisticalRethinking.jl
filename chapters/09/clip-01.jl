using StatisticalRethinking
gr(size=(600,600));

ProjDir = @__DIR__

function generate_walk(N::Int64)
  num_weeks = N
  positions = zeros(Int64, num_weeks);
  current = 10
  d = Uniform(0, 1)

  for i in 1:N

    positions[i] = current

    proposal = current + sample([-1, 1], 1)[1]

    proposal = proposal < 1  ? 10 : proposal
    proposal = proposal > 10  ? 1 : proposal

    prob_move = proposal/current
    current = rand(d, 1)[1] <  prob_move ? proposal : current

  end

  positions

end

N = 100000
walk = generate_walk(N)

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)
p[1] = plot(walk[1:100], leg=false, xlabel="Week", ylabel="Island", title="First 100 steps")
p[2] = histogram(walk, leg=false, xlabel="Island", ylabel="Number of weeks",
  title="$N steps")
plot(p..., layout=(1, 2))

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

