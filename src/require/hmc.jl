using .LogDensityProblems: logdensity, logdensity_and_gradient
#import .LogDensityProblems: logdensity, logdensity_and_gradient

using Distributions

# ### snippet 9.6

function HMC(model, grad, epsilon, L, current_q)
  q = current_q
  p = rand(Normal(0, 1), length(q)) # random flick - p is momentum
  #p = [0.96484367, -0.06740435]
  current_p = p
  # Make a half step for momentum at the beginning
  v, g = logdensity_and_gradient(grad, q)
  value_U = -v; grad_U = -g
  p = p - epsilon .* grad_U / 2.0
  # Initialize bookkeeping
  qtraj = zeros(L+1, length(q)+3)
  qtraj[1, :] = [q[1], q[2], value_U, grad_U[1], grad_U[2]]

  ptraj = zeros(L+1, length(q))
  ptraj[1, :] = p
  
  # ### snippet 9.7
  
  # Alternate full steps for position and momentum
  
  for i in 1:L
    # Full position step
    q = q + epsilon .* p
    # Full step for momentum,, except for last step
    if i !== L
      v, g = logdensity_and_gradient(grad, q)
      value_U = -v; grad_U = -g
      p = p - epsilon .* grad_U
      ptraj[i+1, :] = p
    end
    qtraj[i+1, :] = [q[1], q[2], value_U, grad_U[1], grad_U[2]]
  end
  
  # ### snippet 9.8
  
  # Make a halfstep for momentum at the end
  
  v, g = logdensity_and_gradient(grad, q)
  value_U = -v; grad_U = -g
  p = p - epsilon .* grad_U / 2.0
  ptraj[L+1, :] = p
  # Negate momentum to make proposal symmatric
  p = -p
  # Evaluate potential and kinetic energies ate beginning and end
  current_U = -logdensity(grad, [current_q[1], current_q[2]])
  current_K = sum(current_p .^ 2) / 2
  proposed_U = -logdensity(grad, [q[1], q[2]])
  proposed_K = sum(p .^ 2) / 2
  dH = proposed_U + proposed_K - current_U - current_K
  # Accept or reject the state at the end of trajectory
  # Return either position at the end or initial position
  local accept = 0
  local new_q
  if rand(Uniform(0, 1), 1)[1] < exp(dH)
    new_q = q # Accept
    accept = 1
  else
    new_q = current_q # Reject
  end
  
  (new_q, ptraj, qtraj, accept, dH)
  
end