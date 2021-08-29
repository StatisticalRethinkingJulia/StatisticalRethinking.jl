function sample(qm::NamedTuple; nsamples=4000)
  df = DataFrame()
  p = Particles(nsamples, qm.distr)
  for (indx, coef) in enumerate(qm.params)
    if length(qm.params) == 1
      df[!, coef] = p.particles
    else
      df[!, coef] = p[indx].particles
    end
  end
  df
end
