using StatsBase, Turing, MCMCChain

@model binary(x) = begin
    num_values = length(x)

    # Allocate state probability vector.
    state_probability = Vector{Real}(undef, num_values)
    for i in 1:num_values
        state_probability[i] ~ Beta(0.5, 0.5)
    end

    # Observe given data.
    for i in 1:num_values
        x[i] ~ Bernoulli(state_probability[i])
    end
end

x = [1.0,0.0,1.0,0.0,1.0,0.0,0.0,0.0,1.0];
@time chn = sample(binary(x), NUTS(10000,1000, 0.65));

describe(chn)

for var in ["state_probability[$i]" for i in 1:9]
  println("$var = ",  mean_and_std(chn[Symbol(var)][1001:2000]))
end
