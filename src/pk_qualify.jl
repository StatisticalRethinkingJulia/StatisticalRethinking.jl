function pk_qualify(pk::Vector{Float64})
    pk_good = sum(pk .<= 0.5)
    pk_ok = length(pk[pk .<= 0.7]) - pk_good
    pk_bad = length(pk[pk .<= 1]) - pk_good - pk_ok
    (good=pk_good, ok=pk_ok, bad=pk_bad, very_bad=sum(pk .> 1))
end
    