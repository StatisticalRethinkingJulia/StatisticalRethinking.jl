"""

# precis

$(SIGNATURES)

"""
function precis(nt::NamedTuple; io = stdout, digits = 2, depth = Inf, alpha = 0.11)
  post = rand(nt.distr, 10_000)
  df = DataFrame(post', [keys(nt.coef)...])
  Text(precis(df; io=String))
end

"""

# precis

$(SIGNATURES)

"""
function precis(m::DynamicPPL.Model; 
  io = stdout, digits = 2, depth = Inf, alpha = 0.11,
  sampler=NUTS(0.65), nsamples=2000, nchains=4)
    chns = mapreduce(c -> sample(m, sampler, nsamples), chainscat, 1:nchains)
    df = DataFrame(Array(chns), names(chns, [:parameters]))
    Text(precis(df; io=String))
end
