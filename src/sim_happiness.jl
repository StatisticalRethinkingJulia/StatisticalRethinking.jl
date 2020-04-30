
# simulation for Chapter 6 collider example


#invlogit(p) = 1 - 1/(1 + exp(p))

function sim_happiness(seed=nothing, n_years=1000, max_age=65, n_births=20, aom=18)
  !isnothing(seed) && Random.seed!(seed)
  h = Float64[]; a = Int[]; m = Int[];
  for t in 1:n_years
    a .+= 1
    append!(a, ones(Int, n_births))
    append!(h, range(-2, stop=2, length=n_births))
    append!(m, zeros(Int, n_births))
    for i in 1:length(a)
      if a[i] >= aom && m[i] == 0
        m[i] = rand(Bernoulli(logistic(h[i] - 4)))
      end
    end
    # mortality
    alive = findall(x -> x <= max_age, a)
    if length(alive) < length(a)
      a = a[alive]
      h = h[alive]
      m = m[alive]
    end
  end
  DataFrame(:age=>a, :happiness=>h, :married=>m)
end

export
#  invlogit,
  sim_happiness