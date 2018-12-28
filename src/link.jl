function link(xrange, chain, vars, xbar) 
  res = [chain.value[:, vars[1], :] + chain.value[:, vars[2], :] * (x - xbar) for x in xrange]
end

