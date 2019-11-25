using Distributions, Random

function simulatePoisson(;Nd=1,Ns=10,a0=1.0,a1=.5,a0_sig=.3,kwargs...)
    N = Nd*Ns
    y = fill(0,N)
    x = fill(0.0,N)
    idx = similar(y)
    i = 0
    for s in 1:Ns
        a0s = rand(Normal(0,a0_sig))
        logpop = rand(Normal(9,1.5))
        λ = exp(a0 + a0s + a1*logpop)
        for nd in 1:Nd
            i+=1
            x[i] = logpop
            idx[i] = s
            y[i] = rand(Poisson(λ))
        end
    end
    return (y=y,x=x,idx=idx,N=N,Ns=Ns)
 end
