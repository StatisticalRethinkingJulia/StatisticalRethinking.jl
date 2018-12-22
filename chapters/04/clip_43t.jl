using StatisticalRethinking
gr(size=(500,500));

Turing.setadbackend(:reverse_diff)

ProjDir = rel_path("..", "chapters", "04")
cd(ProjDir)

# ### snippet 4.43

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);

# Center the weight observations and add a column to df2

mean_weight = mean(df2[:weight])
df2 = hcat(df2, df2[:weight] .- mean_weight)
rename!(df2, :x1 => :weight_c) # Rename our col x1 => log_gdp

# Extract variables for Turing model

y = convert(Vector{Float64}, df2[:height]);
x = convert(Vector{Float64}, df2[:weight_c]);

# Define the regression model

@model line(y, x) = begin
    #priors
    alpha ~ Normal(178.0, 100.0)
    beta ~ Normal(0.0, 10.0)
    s ~ Uniform(0, 50)

    #model
    mu = alpha .+ beta*x
    for i in 1:length(y)
      y[i] ~ Normal(mu[i], s)
    end
end;

# Draw the samples

chn = sample(line(y, x), Turing.NUTS(1000, 0.65));

# Describe the chain result

describe(chn)

# Compare with a previous result

clip_43s_example_output = "

Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
         Mean        SD       Naive SE       MCSE      ESS
alpha 154.597086 0.27326431 0.0043206882 0.0036304132 1000
 beta   0.906380 0.04143488 0.0006551430 0.0006994720 1000
sigma   5.106643 0.19345409 0.0030587777 0.0032035103 1000

Quantiles:
          2.5%       25.0%       50.0%       75.0%       97.5%
alpha 154.0610000 154.4150000 154.5980000 154.7812500 155.1260000
 beta   0.8255494   0.8790695   0.9057435   0.9336445   0.9882981
sigma   4.7524368   4.9683400   5.0994450   5.2353100   5.5090128
";

# Example result for Turing with centered weights (appears biased)

clip_43t_example_output = "

Iterations = 1:1000
Thinning interval = 1
Chains = 1
Samples per chain = 1000

Empirical Posterior Estimates:
              Mean            SD        Naive SE        MCSE         ESS    
   alpha   153.14719937  10.810424888 0.3418556512  1.4582064846   54.960095
    beta     0.90585034   0.079704618 0.0025204813  0.0016389693 1000.000000
  lf_num     0.00200000   0.063245553 0.0020000000  0.0020000000 1000.000000
       s     6.00564996   5.329796821 0.1685429742  0.8996190097   35.099753
 elapsed     0.09374649   0.099242518 0.0031383240  0.0055587373  318.744897
 epsilon     0.07237568   0.136671220 0.0043219234  0.0087528107  243.814242
      lp -1112.05625117 171.984325602 5.4386219075 28.3846353549   36.712258
eval_num    20.27200000  20.520309430 0.6489091609  1.1679058181  308.711044
  lf_eps     0.07237568   0.136671220 0.0043219234  0.0087528107  243.814242

";

# Plot the regerssion line and observations

xi = -15.0:0.1:15.0
yi = mean(chn[:alpha]) .+ mean(chn[:beta])*xi

scatter(x, y, lab="Observations", xlab="weight", ylab="height")
plot!(xi, yi, lab="Regression line")

# End of `clip_43t.jl`
