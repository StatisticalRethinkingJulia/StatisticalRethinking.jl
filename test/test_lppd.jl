d = DataFrame(:mu => [0.0, 0.1, 0.2], :sigma => [0.1, 0.1, 0.1])

@test lppd(d, (r, x) -> Normal(r.mu + x, r.sigma), 1:4, 4:-1:1) ≈ [-391.7149657288782, -31.71476226597971, -49.71493819252957, -449.71496572887867]