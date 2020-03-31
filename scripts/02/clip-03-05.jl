# Load Julia packages (libraries) needed

using StatisticalRethinking
using StatsPlots

ProjDir = @__DIR__

# ### snippet 2.3, 2.4

scatter( p_grid , posterior,
    xlab="probability of water" , ylab="posterior probability",
    lab = "computed", title="5 points", legend=:topleft)
plot!( p_grid , posterior , lab="approximated")
savefig("$ProjDir/Fig-03-05.1.png")

# ### snippet 2.5

p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 9)
N = [5, 20, 50]

for l in 1:3            # Different priors

    for i in 1:3        # prior, likelihood & posterior
        local p_grid = range( 0 , stop=1 , length=N[i] )
        local prior = zeros(N[i])

        if l == 1
            prior = [pdf.(Uniform(0, 1), p_grid)]
        elseif l == 2
            prior = [[p < 0.5 ? 0 : 1 for p in p_grid]]
        else
            prior = [[exp( -5*abs( p - 0.5 ) ) for p in p_grid]]
        end

        local likelihood = [pdf.(Binomial(9, p), 6) for p in p_grid]
        local post = (1  / sum(prior .* likelihood)) * (prior .* likelihood)

        j = (i-1)*3 + 1
        p[j] = plot(p_grid, prior, leg=false, ylims=(0, 1), title="Prior")
        p[j+1] = plot(p_grid, likelihood, leg=false, title="Likelihood")
        p[j+2] = plot(p_grid, post, leg=false, title="Posterior")
    end

plot(p..., layout=(3, 3))
savefig("$ProjDir/Fig-03-05.$l.png")

end


# End of `02/clip-03-05.jl`
