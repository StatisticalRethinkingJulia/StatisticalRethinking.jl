using StatisticalRethinking, Test

@testset "Array constructor tests" begin
  
  include("samplechain.jl")
  
  d, p, c = size(chns.value.data)

  @test size(Array(chns)) == (d*c, p)
  @test size(Array(chns, [:parameters])) == (d*c, 3)
  @test size(Array(chns, [:parameters, :internals])) == (d*c, p)
  @test size(Array(chns, [:internals])) == (d*c, 7)
  @test size(Array(chns, append_chains=true)) == (d*c, p)
  @test size(Array(chns, append_chains=false)) == (4,)
  @test size(Array(chns, append_chains=false)[1]) == (d, p)
  @test typeof(Array(chns, append_chains=true)) == Array{Float64, 2}
  @test size(Array(chns, remove_missing_union=false)) == (d*c, p)
  @test size(Array(chns, append_chains=false, remove_missing_union=false)) == (4,)
  @test size(Array(chns, append_chains=false, remove_missing_union=false)[1]) == (d, p)
  @test typeof(Array(chns, append_chains=true, remove_missing_union=false)) == 
    Array{Float64, 2}
  @test size(Array(chns[:sigma])) == (d*c,)

  Array(chns)
  Array(chns[:alpha])
  Array(chns, [:parameters])
  Array(chns, [:parameters, :internals])
  
end