using Optim, StatsFuns

function quap(loglikf, x0, lower, upper)
  res = optimize(loglikf, lower, upper, x0, Fminbox(GradientDescent()))
  (Optim.minimizer(res), res)
end  

