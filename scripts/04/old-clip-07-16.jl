

#=

p[3] = density(df2[:, :height], xlim=(100,250),
	lab="All heights", xlab="height [cm]", ylab="density")

# Plot the prior densities.

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
p[1] = density(rand(d1, xlim=(100,250),
	lab="All heights", xlab="height [cm]", ylab="density")




p[1] = density(df2[:, :height], xlim=(100,250),
	lab="All heights", xlab="height [cm]", ylab="density")


# ### snippet 4.11

# Show σ  prior

d2 = Uniform(0, 50)
p[3] = plot(0:0.1:50, [pdf(d2, σ) for σ in 0:0.1:50], lab="Prior on sigma")


=#
