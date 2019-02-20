using Optim, StatsFuns

function quap(obs, loglik, lower, upper, x0)
  res = optimize(loglik, lower, upper, x0, Fminbox(GradientDescent()))
  (Optim.minimizer(res), res)
end  
  
  