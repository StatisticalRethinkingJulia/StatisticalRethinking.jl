# # Chapter 4 snippets

# ### snippet 4.0

# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
gr(size=(600,300))

ProjDir = rel_path("..", "test")
cd(ProjDir) #src

let μ = 1500,
    σ = 300,
    n = Normal(μ,σ), 
    (from,x0,x1,x2,x3,x4,x5,to) = μ .+ (σ .* (-5, -3, -2 , -1, 1, 2, 3, 5))
    plot(x->pdf(n,x), from, to, fillrange=0, c=:red4, legend=false)
    plot!(x->pdf(n,x), x0, x5, fillrange=0, c=:gray80, alpha=0.5)
    plot!(x->pdf(n,x), x1, x4, fillrange=0, c=:gray80, alpha=0.5)
    plot!(x->pdf(n,x), x2, x3, fillrange=0, c=:gray80, alpha=0.5)
    plot!(x->pdf(n,x), from, to, c=:black)
    vline!([μ], line=:dash)
end
savefig("t0_0.pdf")
