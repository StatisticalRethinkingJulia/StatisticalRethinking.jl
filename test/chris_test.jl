using Turing

N=50
θ = .6
k = rand(Binomial(N,θ))
@model model(N,k) = begin
    θ ~ Beta(5,5)
    k~ Binomial(N,θ)
end
Nsamples = 2000
Nadapt = 1000
δ = .85
specs = NUTS(Nsamples,Nadapt,δ)
chainarray = map(x->sample(model(N,k),specs),1:20)

x = []
for (i,ch) in enumerate(chainarray)
    print(i, " ")
    push!(x, dfchainsummary(ch[1001:end,:,:], [:parameters]))
end
println()

x[[1, 19, 20]]
