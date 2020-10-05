"""

# precis

$(SIGNATURES)

"""
function precis(nt::NamedTuple; io = stdout, digits = 2, depth = Inf, alpha = 0.11)
  post = rand(nt.distr, 10_000)
  df = DataFrame(post', [keys(nt.coef)...])
  precis(df)
end

"""

# precis

$(SIGNATURES)

"""
function precis(m::DynamicPPL.Model; io = stdout, digits = 2, depth = Inf, alpha = 0.11)
    chns = mapreduce(c -> sample(m, NUTS(0.65), 2000), chainscat, 1:4)
    df = DataFrame(chns)
    precis(df)
end
