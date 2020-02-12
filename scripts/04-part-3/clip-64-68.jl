# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking, StanSample, CSV
using DataFrames, StatsPlots, Statistics

ProjDir = @__DIR__
cd(ProjDir) #do

# ### Preliminary snippets

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
scale!(df, [:height, :weight])
df[!, :weight_sq_s] = df[:, :weight_s].^2
#scale!(df, [:weight_sq])


# Define the Stan language model

weightsmodel = "
data{
    int N;
    vector[N] height;
    vector[N] weight;
    vector[N] weight_sq;
}
parameters{
    real alpha;
    real beta1;
    real beta2;
    real<lower=0,upper=50> sigma;
}
model{
    vector[N] mu;
    sigma ~ uniform( 0 , 50 );
    beta1 ~ lognormal( 0 , 1 );
    beta2 ~ normal( 0 , 1 );
    alpha ~ normal( 178 , 20 );
    mu = alpha + beta1 * weight + beta2 * weight_sq;
    height ~ normal( mu , sigma );
}
";

# Define the SampleModel.

sm = SampleModel("weights", weightsmodel);

# Input data.

heightsdata = Dict(
  "N" => size(df, 1), 
  "height" => df[:, :height], 
  "weight" => df[:, :weight_s],
  "weight_sq" => df[:, :weight_sq_s]
);

# Sample using stan

rc = stan_sample(sm, data=heightsdata);

rethinking = "
        mean   sd   5.5%  94.5%
a     146.06 0.37 145.47 146.65
b1     21.73 0.29  21.27  22.19
b2     -7.80 0.27  -8.24  -7.36
sigma   5.77 0.18   5.49   6.06
"

if success(rc)

  sdf = read_summary(sm)
  sdf[8:11, :] |> display
  println()

  # ### Snippet 4.53

  dfa = read_samples(sm; output_format=:dataframe)

  function link_poly(dfa::DataFrame, xrange)
    vars = names(dfa)
    [dfa[:, vars[1]] + dfa[:, vars[2]] * x +  dfa[:, vars[3]] * x^2 for x in xrange]
  end
  
  mu_range = -2:0.1:2

  # ### Snippet 4.54
  xbar = mean(df[:, :weight])
  mu = link_poly(dfa, mu_range);

  # ### Snippet 4.67

  plot(xlab="weight_s", ylab="height")
  for (indx, mu_val) in enumerate(mu_range)
    for j in 1:length(mu_range)
      scatter!([mu_val], [mu[indx][j]], leg=false, color=:lightblue)
    end
  end
  scatter!(df[:, :weight_s], df[:, :height])
  savefig("$(ProjDir)/Fig-64-68.png")

end

#end # cd .. do

# End of `04/clip-53-58.jl`
