using Distributions, Optim, Plots
gr(size=(400,400))

obs = rand(Normal(5, 2), 5)
println()

loglik1(x) = -sum(log.(pdf.(Normal(x[1], x[2]), obs)))

x0 = [ mean(obs), std(obs)]
lower = [-10.0, 0.0]
upper = [10.0, 10.0]

inner_optimizer = GradientDescent()

optimize(loglik1, lower, upper, x0, Fminbox(inner_optimizer)) |> display
println()

loglik2(x) = -sum(log.(pdf.(Normal(x[1], x[2]), obs)) .+ log.(pdf.(Normal(3, 2), x[1])))
optimize(loglik2, lower, upper, x0, Fminbox(inner_optimizer))

obs2 = rand(Normal(5, 2), 100)
loglik3(x) = -sum(log.(pdf.(Normal(x[1], x[2]), obs2)) .+ log.(pdf.(Normal(3, 2), x[1])))

x0 = [ mean(obs2), std(obs2)]

res3 = optimize(loglik3, lower, upper, x0, Fminbox(inner_optimizer))
res3 |> display

vec3 = Optim.minimizer(res3)

loglik4(x) = -sum(log.(pdf.(Normal(x[1], x[2]), obs2)) .+ log.(pdf.(Normal(2, 2), x[1])))

res4 = optimize(loglik4, lower, upper, x0, Fminbox(inner_optimizer))
res4 |> display

vec4 = Optim.minimizer(res4)

loglik5(x) = -sum(log.(pdf.(Normal(x[1], x[2]), obs2)) .+ log.(pdf.(Normal(2, 5), x[1])))

res5 = optimize(loglik5, lower, upper, x0, Fminbox(inner_optimizer))
res5 |> display

vec5 = Optim.minimizer(res2)
x = range(0.0, 10.0, length=100)
plot(x, pdf.(Normal(vec3[1], vec3[2]), x))
plot!(x, pdf.(Normal(vec4[1], vec4[2]), x))
plot!(x, pdf.(Normal(vec5[1], vec5[2]), x))
