# quadratic approximation

# Compute MAP, compare with CmndStan & MLE

using Optim

x0 = [0.5]
lower = [0.2]
upper = [1.0]

inner_optimizer = GradientDescent()

function loglik(x)
  ll = 0.0
  ll += log.(pdf.(Beta(1, 1), x[1]))
  ll += sum(log.(pdf.(Binomial(9, x[1]), k)))
  -ll
end

res = optimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))
#display(res)

# Summarize mean and sd estimates

# StanSample mean and sd:

println("\nMean and std estimates, using all draws in 4 chains:\n")
display([mean(dfsa[:, :theta]), std(dfsa[:, :theta])])

# MAP estimate and associated sd:

println("\nMAP estimates of mean and std:\n")
display([Optim.minimizer(res)[1], std(dfsa[:, :theta], mean=mean(dfsa[:, :theta]))])

# MLE of mean and sd:

println("\nMLE estimates of mean and std:\n")
display([mu_avg, sigma_avg])

# Turing Chain &  89% hpd region boundaries

plot( x, pdf.(Normal( mu_avg , sigma_avg  ) , x ),
xlim=(0.0, 1.2), lab="Normal approximation using MLE")
plot!( x, pdf.(Normal( Optim.minimizer(res)[1] , std(dfsa[:, :theta], mean=mean(chn.value))) , x),
lab="Normal approximation using MAP")
density!(dfsa[:, :theta], lab="StanSample chain")
vline!([bnds[1]], line=:dash, lab="hpd lower bound")
vline!([bnds[2]], line=:dash, lab="hpd upper bound")
savefig("$ProjDir/Fig-part_3.pdf")

# End of `intro/intro_part_3.jl`
