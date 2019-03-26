using MCMCChains

function getSummary(ch)
    chain = ch[1001:end,:,:]
    return chain.info.hashedsummary.x[2].summaries[1].value
end
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
chain = map(x->sample(model(N,k),specs),1:20)

TmpDir = mktempdir()
io = open("$(TmpDir)/myfile.txt", "a");
map(x->print(io, x),chain)
close(io)
rm("$(TmpDir)/myfile.txt")

x = []
for (i,v) in enumerate(chain)
    println(i)
    push!(x,getSummary(v))
end
