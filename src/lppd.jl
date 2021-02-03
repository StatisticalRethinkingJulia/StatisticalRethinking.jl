lppd(ll) =
    [logsumexp(ll[:, i]) - log(size(ll, 1)) for i in 1:size(ll, 2)]

export
    lppd