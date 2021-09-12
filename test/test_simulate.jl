d = DataFrame(:mu => [1.0, 2.0], :sigma => [0.1, 0.2])
res = [
    [1.0297287984535461, 2.0382395967790607],
    [1.8804731046543537, 2.997910951072525]
]

res_dist = [
    [Normal(1.0, 0.1), Normal(2.0, 0.1)],
    [Normal(2.0, 0.2), Normal(3.0, 0.2)],
]

fun = (r, x) -> Normal(r.mu + x, r.sigma)

@test simulate(d, fun, 0:1, seed=1) ≈ res atol=0.6
@test simulate(d, fun, 0:1, seed=1, return_dist=true) == res_dist
