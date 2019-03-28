using StatisticalRethinking
using Test

@testset "DataFrame sampling tests" begin
  
  tests = [
    "test_sampling.jl"
  ]

  for test in tests
    include(test)
  end

  println("More tests are executed in docs job.")

end
