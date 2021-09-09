d = DataFrame(:a => [1,2,3], :b => [2,3,4])
x = 1:2
ref = [[3,5,7], [5,8,11]]
@test link(d, [:a, :b], x) == ref
