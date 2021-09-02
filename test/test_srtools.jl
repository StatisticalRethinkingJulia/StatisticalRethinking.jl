@testset "PI" begin
    r = PI(1:100)
    @test r ≈ [6.445, 94.555]
    
    r = PI(1:100, 0.1)
    @test r ≈ [45.55, 55.45]
end
