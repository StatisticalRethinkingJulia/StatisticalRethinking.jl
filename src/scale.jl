import StatsBase: standardize
import Distributions: scale

function standardize(x::AbstractArray)
  x = convert(Vector{Float64}, (x .- mean(x)))/std(x)
end

scale(x) = standardize(x)
