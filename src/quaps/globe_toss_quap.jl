using StatisticalRethinking, Parameters

struct globe_toss{TO <: AbstractVector}
  # Observations of water
  w::TO
  # Number of tosses
  n::Int
end

function (problem::globe_toss)(theta)
  @unpack w, n = problem
  ll = 0.0
  ll += sum(log.(pdf.(Beta(1, 1), theta[1])))
  ll += sum(log.(pdf.(Binomial(n[1], theta[1]), w)))
  -ll
end

n = 9        # Total number of tosses
w = [6]     # Water in n tosses

llf = globe_toss(w, n);
theta = [0.5]
llf(theta)

# Compute the MAP (maximum_a_posteriori) estimate

x0 = [0.5]
lower = [0.0]
upper = [1.0]

(qmap, opt) = quap(llf, x0, lower, upper)
