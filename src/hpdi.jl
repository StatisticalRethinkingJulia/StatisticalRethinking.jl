"""

# hpdi

Compute high density region.

$(SIGNATURES)

Derived from `hpd` in MCMCChains.jl.

By default alpha=0.11 for a 2-sided tail area of p < 0.055% and p > 0.945%.

"""
function hpdi(x::Vector{T}; alpha=0.11) where {T<:Real}
    n = length(x)
    m = max(1, ceil(Int, alpha * n))

    y = sort(x)
    a = y[1:m]
    b = y[(n - m + 1):n]
    _, i = findmin(b - a)

    return [a[i], b[i]]
end

export
  hpdi