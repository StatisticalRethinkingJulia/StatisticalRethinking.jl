using StatsBase

function precis(df::DataFrame; digits=3, depth=Inf, alpha=0.11)
  m = zeros(length(names(df)), 5)
  for (indx, col) in enumerate(names(df))
    m[indx, 1] = mean(df[:, col])
    m[indx, 2] = std(df[:, col])
    q = quantile(df[:, col], [alpha/2, 0.5, 1-alpha/2])
    m[indx, 3] = q[1]
    m[indx, 4] = q[2]
    m[indx, 5] = q[3]
  end

  # kwarg `depth` is intended to allow filtering of levels,
  # e.g. if α[1], α[2], depth=1 would suppress printing of α.

  # Is PrettyTables useful here?

  # pretty_table(df, 
  #  formatters = ft_printf("%.2f", [2, 3, 5]), 
  #  highlighters = (hl_lt(0.2), hl_gt(0.8)))

  # Is Unicode.histogram useful here?

  # for col in eachcol(df)
  #   printprintln(unicode_histogram(col))
  # end

  # if printsummary=true, print line by line?

  NamedArray(
    round.(m, digits=digits), 
    (names(df), ["mean", "sd", "5.5%", "50%", "94.5%"]), 
    ("Rows", "Cols")
  )
end


function precis(m::SampleModel)
  precis(read_samples(m; output_format=:dataframe))
end


const BARS = collect("▁▂▃▄▅▆▇█")

function unicode_histogram(data, nbins = 12)
  f = fit(Histogram, data, nbins = nbins)  # nbins: more like a guideline than a rule, really
  # scale weights between 1 and 8 (length(BARS)) to fit the indices in BARS
  # eps is needed so indices are in the interval [0, 8) instead of [0, 8] which could
  # result in indices 0:8 which breaks things
  scaled = f.weights .* (length(BARS) / maximum(f.weights) - eps())
  indices = floor.(Int, scaled) .+ 1
  return join((BARS[i] for i in indices))
end


export
  precis
