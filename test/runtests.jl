using StatisticalRethinking
using Test

@testset "Array constructor tests" begin
  
  tests = [
    "test_array_constructor.jl",
    "test_df_constructor.jl",
    "test_mcmcchains.jl",
    "test_sampling.jl"
  ]

  for test in tests
    include(test)
  end

  println("More tests are executed in docs job.")

end
