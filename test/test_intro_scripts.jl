using Random

Random.seed!(1234)
include("test_part_1.jl")
include("test_part_2.jl")
include("test_part_3.jl")
include("test_part_4.jl")
println()

@testset "Intro scripts" begin
  @test mean(dfsa[:, :theta]) ≈ 0.58 atol=0.01
  @test fits_mu[end] ≈ 0.58 atol=0.01
  @test fits_sigma[end] ≈ 0.04 atol=0.01
  @test bnds[1] ≈ 0.51 atol=0.02
  @test bnds[2] ≈ 0.65 atol=0.01
  @test optim_optim[1] ≈ 0.58 atol=0.01
  @test optim_optim[2] ≈ 0.04 atol=0.01
  @test mu_sigma_avg[1] ≈ 0.58 atol=0.01
  @test mu_sigma_avg[2] ≈ 0.04 atol=0.01
  @test optim_stan["theta"][end] ≈ 0.58 atol=0.01
end
