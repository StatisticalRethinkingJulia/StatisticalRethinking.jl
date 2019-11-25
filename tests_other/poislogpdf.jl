using StatsFuns,Distributions
import ForwardDiff, Zygote

f(x) = poislogpdf(x[1], x[2])
#new Poisson logpdf
poission_lpdf(x) = -x[1]+x[2]*log(x[1])-log(factorial(x[2]))

x = [.5,2.]
f(x) |> display

fd_grad1 =ForwardDiff.gradient(f, x)      # works
fd_grad1 |> display

try
  zd_grade1=Zygote.gradient(f, x)           #fails
catch e
  println(e)
end

poission_lpdf(x)
fd_grad2=ForwardDiff.gradient(poission_lpdf, x)      # works
fd_grad2 |> display

zd_grad2=Zygote.gradient(poission_lpdf, x)           #works
zd_grad2 |> display

fd_grad1 == fd_grad2 == zd_grad2[1]
