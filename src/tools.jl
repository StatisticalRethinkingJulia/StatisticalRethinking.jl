function zscore_transform(data)
    μ = mean(data)
    σ = std(data)
    z(d) = (d .- μ) ./ σ
    unz(d) = d .* σ .+ μ
    return z, unz
end

function meanlowerupper(data, PI = (0.055, 0.945))
    m = mean.(eachrow(data))
    lower = quantile.(eachrow(data), PI[1])
    upper = quantile.(eachrow(data), PI[2])
    return (mean = m,
            lower = lower,
            upper = upper,
            raw = data)
end

function estimparam(data, PI = (0.055, 0.945))
    m = mean.(eachcol(data))
    lower = quantile.(eachcol(data), PI[1])
    upper = quantile.(eachcol(data), PI[2])
    return m, lower, upper
end

function lin(a, b, c, x...)
    result = @. a + b * c
    for i in 1:2:length(x)
        @. result += x[i] * x[i+1]
    end
    return result
end


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

function precis(df::DataFrame; io = stdout, digits = 2, depth = Inf, alpha = 0.11)
    d = DataFrame()
    d.param = names(df)
    d.mean = mean.(eachcol(df))
    d.std = std.(eachcol(df))
    d[:, "5.5%"] = quantile.(eachcol(df), alpha/2)
    d[:, "50%"] = quantile.(eachcol(df), 0.5)
    d[:, "94.5%"] = quantile.(eachcol(df), 1 - alpha/2)
    u = unicode_histogram.(eachcol(df))
    d.histogram = unicode_histogram.(eachcol(df))

    for col in ["mean", "std", "5.5%", "50%", "94.5%"]
        d[:, col] .= round.(d[:, col], digits = digits)
    end

    pretty_table(io, d, nosubheader = true, vlines = [0, 1, 7])
end
