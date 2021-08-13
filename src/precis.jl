const BARS = collect("▁▂▃▄▅▆▇█")

function unicode_histogram(data, nbins = 12)
    # @show data
    f = fit(Histogram, data, nbins = nbins)  # nbins: more like a guideline than a rule, really
    # scale weights between 1 and 8 (length(BARS)) to fit the indices in BARS
    # eps is needed so indices are in the interval [0, 8) instead of [0, 8] which could
    # result in indices 0:8 which breaks things
    scaled = f.weights .* (length(BARS) / maximum(f.weights) - eps())
    indices = floor.(Int, scaled) .+ 1
    return join((BARS[i] for i in indices))
end

"""

# precis

$(SIGNATURES)

"""
function precis(df::DataFrame; io = stdout, digits = 4, depth = Inf, alpha = 0.11)
    d = DataFrame()
    cols = collect.(skipmissing.(eachcol(df)))
    d.param = names(df)
    d.mean = mean.(cols)
    d.std = std.(cols)
    quants = quantile.(cols, ([alpha/2, 0.5, 1-alpha/2], ))
    quants = hcat(quants...)
    d[:, "5.5%"] = quants[1,:]
    d[:, "50%"] = quants[2,:]
    d[:, "94.5%"] = quants[3,:]
    d.histogram = unicode_histogram.(cols, min(size(df, 1), 12))

    for col in ["mean", "std", "5.5%", "50%", "94.5%"]
        d[:, col] .= round.(d[:, col], digits = digits)
    end

    pretty_table(io, d, nosubheader = true, vlines = [0, 1, 7])
end

export
  precis
