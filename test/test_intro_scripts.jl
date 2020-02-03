using Random, Test

Random.seed!(1234)
include("test_part_1.jl")
include("test_part_2.jl")
println()

@testset "Intro scripts" begin
  @test mean(df[:, :theta]) ≈ 0.58 atol=0.05
  @test fits_mu[end] ≈ 0.58 atol=0.05
  @test fits_sigma[end] ≈ 0.04 atol=0.03
  @test mu_sigma[1] ≈ 0.58 atol=0.05
  @test mu_sigma[2] ≈ 0.04 atol=0.03
  @test optim_stan["theta"][end] ≈ 0.58 atol=0.05
end
