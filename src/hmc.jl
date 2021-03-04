using Distributions

# u() needs to return neg-log-probability
function u(q, x, y; a=0, b=1, k=0, d=1)

    # muy == q[1], mux == q[2]

    uval = sum(logpdf(Normal(q[1], 1), y)) + sum(logpdf(Normal(q[2], 1), x)) +
    logpdf(Normal(a, b), q[1]) + logpdf(Normal(k, d), q[2])
    -uval
end

# need vector of partial derivatives of U with respect to vector q
function ugrad( q, x, y; a=0 , b=1 , k=0 , d=1 )
 muy = q[1]
 mux = q[2]
 g1 = sum( y .- muy ) .+ (a - muy) / b^2  # dU/dmuy
 g2 = sum( x .- mux ) .+ (k - mux) / d^2  #d U/dmux
 [-g1 , -g2]                            # negative bc energy is neg-log-prob
end

function hmc(x, y, u, ugrad, eps, L, current_q)
  q = current_q
  p = rand(Normal(0, 1), length(q)) # random flick to momentum
  current_p = p

  # Make a half step for momentum at the beginning
  v = u(q, x, y)
  g = ugrad(q, x, y)
  p -= eps * g / 2

  # Initialize bookkeeping
  qtraj = zeros(L+1, length(q)+3)
  qtraj[1, :] = [q[1], q[2], v, g[1], g[2]]

  ptraj = zeros(L+1, length(q))
  ptraj[1, :] = p
  
  # Alternate full steps for position and momentum
  
  for i in 1:L
    # Full position step
    q += eps * p

    # Full step for momentum,, except for last step
    if i !== L
      v - u(q, x, y)
      g = ugrad(q, x, y)
      p -= eps .* g
      ptraj[i+1, :] = p
    end

    # Bookkeeping
    qtraj[i+1, :] = [q[1], q[2], v, g[1], g[2]]
  end
  
  # Make a halfstep for momentum at the end
  
  v = u(q, x, y)
  g = ugrad(q, x, y)
  p -= eps * g / 2

  ptraj[L+1, :] = p

  # Negate momentum to make proposal symmatric
  p = -p

  # Evaluate potential and kinetic energies at beginning and end
  current_U = u([current_q[1], current_q[2]], x, y)
  current_K = sum(current_p .^ 2) / 2
  proposed_U = u([q[1], q[2]], x, y)
  proposed_K = sum(p .^ 2) / 2
  dH = proposed_U + proposed_K - current_U - current_K
  # Accept or reject the state at the end of trajectory
  # Return either position at the end or initial position
  local accept = 0
  local new_q
  if rand(Uniform(0, 1)) < exp(dH)
    new_q = q # Accept
    accept = 1
  else
    new_q = current_q # Reject
  end
  
  (q=new_q, ptraj=ptraj, qtraj=qtraj, accept=accept, dh=dH)
  
end

export
  u, ugrad,
  hmc