using StatisticalRethinking
gr(size=(300,300))

Turing.setadbackend(:reverse_diff)

ProjDir = rel_path("..", "chapters", "04")
cd(ProjDir)

# ### snippet 4.38

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);
y = df2[:height];
x = df2[:weight];

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

clip_38s_example_output = "

Samples were drawn using hmc with nuts.
For each parameter, N_Eff is a crude measure of effective sample size,
and R_hat is the potential scale reduction factor on split chains (at
convergence, R_hat=1).

Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
          Mean         SD       Naive SE       MCSE     ESS
alpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000
 beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000
sigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000

Quantiles:
          2.5%       25.0%       50.0%       75.0%       97.5%
alpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750
 beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574
sigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417

";

# Turing is currently returning (incorrect)

clip_38t_example_output = "

Iterations = 1:1000
Thinning interval = 1
Chains = 1
Samples per chain = 1000

Empirical Posterior Estimates:
               Mean              SD            Naive SE         MCSE          ESS    
   alpha    74.363569906    3.37453074×10¹   1.06712031742  11.1507976352    9.158301
    beta     1.754367972  7.319759414×10⁻¹   0.02314711167   0.2358332318    9.633489
  lf_num     0.013000000  4.110960958×10⁻¹   0.01300000000   0.0130000000 1000.000000
       s    20.852963164    2.79693784×10²   8.84469404557  13.3848300322  436.656478
 elapsed     0.362446980  3.809130792×10⁻¹   0.01204552921   0.0373272039  104.135990
 epsilon     0.016109714 1.7512979575×10⁻²   0.00055380904   0.0023304432   56.473283
      lp -1798.287815276    1.09496867×10⁴ 346.25949595383 598.8111824483  334.367133
eval_num    71.005000000    7.23590133×10¹   2.28819291184   6.6659811731  117.830333
  lf_eps     0.016109714 1.7512979575×10⁻²   0.00055380904   0.0023304432   56.473283

";

# Plot the regerssion line and observations

xi = 30.0:0.1:70.0
yi = mean(chn[:alpha]) .+ mean(chn[:beta])*xi

scatter(x, y, lab="Observations")
plot!(xi, yi, lab="Regression line")

# End of `clip_38t.jl`
