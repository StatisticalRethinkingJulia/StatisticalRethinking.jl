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

export
    zscore_transform,
    meanlowerupper,
    estimparam,
    lin
