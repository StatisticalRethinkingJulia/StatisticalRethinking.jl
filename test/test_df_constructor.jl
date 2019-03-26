using StatisticalRethinking, Test

@testset "DataFrame constructor tests" begin
  
  include("samplechain.jl")
    
  df = DataFrame(chns)
  @test size(df) == (4000, 10)
  
  df1 = DataFrame(chns, [:parameters])
  @test size(df1) == (4000, 3)
  
  df2 = DataFrame(chns, [:internals, :parameters])
  @test size(df2) == (4000, 10)
  
  df3 = DataFrame(chns[:sigma]) 
  @test size(df3) == (4000, 1)
  
  df4 = DataFrame(chns[:lp__])  
  @test size(df4) == (4000, 1)
  
  df5 = DataFrame(chns, [:parameters], append_chains=false)  
  @test size(df5) == (4, )
  @test size(df5[1]) == (1000, 3)

  df6 = DataFrame(chns, [:parameters, :internals], append_chains=false)  
  @test size(df6) == (4, )
  @test size(df6[1]) == (1000, 10)

  df7 = DataFrame(chns, [:parameters, :internals], remove_missing_union=false)  
  @test size(df7) == (4000, 10)

  df8 = DataFrame(chns, [:parameters, :internals], remove_missing_union=false,
    append_chains=false)  
  @test size(df8) == (4, )
  @test size(df8[1]) == (1000, 10)

end