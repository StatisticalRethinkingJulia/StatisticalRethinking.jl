using Distributions, Zygote,ForwardDiff,BenchmarkTools,Tracker

function g(x)
   return logpdf(Normal(x[1],x[2]),x[3])
end
x = [0,1,1]
println("Normal")
@btime Zygote.gradient($g, $x)
@btime Tracker.gradient($g, $x)
@btime ForwardDiff.gradient($g, $x)


function g1(x)
   return logpdf(Cauchy(x[1],x[2]),x[3])
end
x = [3.,1.,.4]
println("Beta")
@btime Zygote.gradient($g1, $x)
@btime Tracker.gradient($g1, $x)
@btime ForwardDiff.gradient($g1, $x)

function g2(x)
   return -x[1]+x[2]*log(x[1])-log(factorial(x[2]))
end
x = [3.,1.]
println("Poisson")
@btime Zygote.gradient($g2, $x)
@btime Tracker.gradient($g2, $x)
@btime ForwardDiff.gradient($g2, $x)
