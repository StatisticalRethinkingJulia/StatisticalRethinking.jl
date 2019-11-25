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

# MAP estimate and associated sd:

optim_optim =[Optim.minimizer(res)[1], std(dfsa[:, :theta], mean=mean(dfsa[:, :theta]))]

# MLE of mean and sd:

mu_sigma_avg = [mu_avg, sigma_avg]

# End of `intro/intro_part_3.jl`
