function precis(df::DataFrame)
  m = zeros(length(names(df)), 5)
  for (indx, col) in enumerate(names(df))
    m[indx, 1] = mean(df[:, col])
    m[indx, 2] = std(df[:, col])
    q = quantile(df[:, col], [0.055, 0.5, 0.945])
    m[indx, 3] = q[1]
    m[indx, 4] = q[2]
    m[indx, 5] = q[3]
  end
  NamedArray(
    m, 
    (names(df), ["mean", "sd", "5.5%", "50%", "94.5%"]), 
    ("Rows", "Cols")
  )
end

function precis(m::SampleModel)
  precis(read_samples(m; output_format=:dataframe))
end

export
  precis
