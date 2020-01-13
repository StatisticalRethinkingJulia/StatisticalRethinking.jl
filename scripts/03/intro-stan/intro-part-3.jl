# Execute this script after `scripts/03/intro_stan/intro-part-1.jl`

using StanOptimize

ProjDir = @__DIR__

# Define the OptimizeModel, use model from intro_part_1.jl.

sm = OptimizeModel("m1.1s", m1_1s);

# Use observations generated in intro_m1.1s.jl.

m1_1_data = Dict("N" => N, "n" => n, "k" => k);

# Optimize using cmdstan
 
rc = stan_optimize(sm, data=m1_1_data);

# Describe the draws

if success(rc)
  optim_stan, cnames = read_optimize(sm)
  println("\nStan_optimize estimates of mean:\n")
  display(optim_stan)
end

# End of `intro/intro-part-3.jl`
