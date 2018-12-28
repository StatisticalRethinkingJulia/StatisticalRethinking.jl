using StatisticalRethinking


# Define the model.
mf(vi, sampler; x=[1.5, 2.0]) = begin
  # Assume s has an InverseGamma distribution.
  s = Turing.assume(sampler,
                    InverseGamma(2, 3),
                    Turing.VarName(vi, [:c_s, :s], ""),

  # Assume m has a Normal distribution.
  m = Turing.assume(sampler,
                    Normal(0,sqrt(s)),
                    Turing.VarName(vi, [:c_m, :m], ""),
                    vi),
  for i = 1:2
    # Observe each value of x[i], according to a
    # Normal distribution.
    Turing.observe(sampler,
                   Normal(m, sqrt(s)),
                   x[i],
                   vi)
  end
  )
vi
end

# Instantiate our model.
mf() = mf(Turing.VarInfo(), nothing)

# Sample from the model.
sample(mf, HMC(1000, 0.1, 5))
