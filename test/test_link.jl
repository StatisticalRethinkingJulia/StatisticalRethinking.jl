using DataFrames

d = DataFrame(:a => [1,2,3], :b => [2,3,4])
ref = [[3,5,7], [5,8,11]]
@test link(d, [:a, :b], 1:2) == ref

@test link(d, (r,x) -> r.a + r.b * x, 1:2) == ref
