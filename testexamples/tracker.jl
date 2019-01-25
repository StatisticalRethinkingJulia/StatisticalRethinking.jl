using Flux
using Flux.Tracker: Tracker, gradient, update!, Params

f(x) = 3x^2 + 2x + 1

df(x) = Tracker.gradient(f, x)[1]

@show df(4)

d2f(x) = Tracker.gradient(df, x; nest=true)

#@show d2f(4) # Fails ?????

W = rand(2, 5)
b = rand(2)

predict(x) = W*x .+ b

function loss(x, y)
  yhat = predict(x)
  sum((y-yhat).^2)
end

x, y = rand(5), rand(2) # Dummy data

@show loss(x, y)

W = param(W)
b = param(b)

grads = Tracker.gradient(() -> loss(x, y), Params([W, b]))

del = grads[W]

update!(W, -0.1del)

@show loss(x, y)

using Flux.Optimise: Descent

η = 0.1 # Learning Rate
for p in (W, b)
  update!(p, -η * grads[p])
end

@show loss(x, y)

opt = Descent(η) # Gradient descent with learning rate 0.1

for p in (W, b)
  update!(opt, p, -η * grads[p])
end

@show loss(x, y)
