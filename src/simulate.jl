function simulate(df, coefs, var_seq)
  m_sim = zeros(size(df, 1), length(var_seq));
  for j in 1:size(df, 1)
    for i in 1:length(var_seq)
      d = Normal(df[j, coefs[1]] + df[j, coefs[2]] * var_seq[i], df[j, :sigma_M])
      m_sim[j, i] = rand(d, 1)[1]
    end
  end
  m_sim
end  

function simulate(df, coefs, var_seq, coefs_ext)
  m_sim = simulate(df, coefs, var_seq)
  d_sim = zeros(size(df, 1), length(var_seq));
  for j in 1:size(df, 1)
    for i in 1:length(var_seq)
      d = Normal(df[j, coefs[1]] + df[j, coefs[2]] * var_seq[i] +
        df[j, :bM] * m_sim[j, i], df[j, :sigma])
      d_sim[j, i] = rand(d, 1)[1]
    end
  end
  (m_sim, d_sim)
end

export
  simulate