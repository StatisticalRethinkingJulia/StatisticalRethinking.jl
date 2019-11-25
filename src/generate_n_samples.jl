function generate_n_samples(model, grad;
  epsilon = 0.03, # Step size
  L = 11, # No of leapfrog steps
  pr = 0.3, # Plot range
  n_samples = 4, # No of samples
  q = [-0.1, 0.2]) # Initial position
  
  fig = plot(ylab="muy", xlab="mux", xlim=(-pr, pr), ylim=(-pr, pr), leg=false)
  
  for i in 1:n_samples
    q, ptraj, qtraj, accept, dH = HMC(model, grad, 0.03, 11, q)
    if n_samples < 10
      for j in 1:L
        K0 = sum(ptraj[j, :] .^ 2) / 2
        plot!(fig, [qtraj[j, 1], qtraj[j+1, 1]], [qtraj[j, 2], qtraj[j+1, 2]], leg=false)
        scatter!(fig, [(qtraj[j, 1], qtraj[j, 2])])
      end
    end
  end
  fig
  
end
