# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__

for i in 1:3
  include(rel_path("..", "scripts", "05", "m5.$i.jl"))
end

if success(rc)

  r1 = plotcoef([m5_1s, m5_2s, m5_3s], [:bA, :bM], "$(ProjDir)/Fig-12a.png",
    "Particles (Normal) estimates")
  display(r1)

  println()
  r2 = plotcoef([m5_1s, m5_2s, m5_3s], [:bA, :bM], "$(ProjDir)/Fig-12b.png",
    "Quap estimates", quap)
  display(r2)

end

# The simulations as in R code 5.12 will be included in StructuralCausalModels.jl