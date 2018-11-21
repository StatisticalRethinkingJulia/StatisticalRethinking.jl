using Optim

ll(p) = -pdf(Binomial(9, p[1]), 6)

optimize(x->ll(first(x)), 0.0, 1.0)
