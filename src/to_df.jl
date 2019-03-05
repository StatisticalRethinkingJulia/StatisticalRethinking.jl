function to_df(chain::MCMCChains.AbstractChains)
  d, p, c = size(chain.value)
  df = DataFrame()
  a3d = zeros(d*c, p);
  indx = 1
  for name in Symbol.(keys(chain))
    a3d[:,  indx] = reshape(convert(Array{Float64}, chain[name]), d*c)
    indx += 1
  end
  cnames = keys(chain)
  snames = [Symbol(cnames[i]) for i in 1: length(cnames)]
  DataFrame(a3d[:,:], snames)
end
