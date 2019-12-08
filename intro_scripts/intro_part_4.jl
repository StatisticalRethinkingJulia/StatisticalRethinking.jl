# Load Julia packages (libraries) needed

using StanOptimize

ProjDir = rel_path("..", "scripts", "02")

# Define the OptimizeModel, use model from intro_m1.1s.jl.

sm = OptimizeModel("m1.1s", m1_1s);

# Use observations generated in intro_m1.1s.jl.

m1_1_data = Dict("N" => N, "n" => n, "k" => k);

# Optimize using cmdstan
 
(optim_file, log_file) = stan_optimize(sm, data=m1_1_data);

# Describe the draws

if !(optim_file == nothing)
  optim_stan, cnames = read_optimize(sm)
  println("\nStan_optimize estimates of mean:\n")
  display(optim_stan)
end

# End of `intro/intro_part_4.jl`
