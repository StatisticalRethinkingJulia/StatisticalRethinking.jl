# Load Julia packages (libraries) needed for clip

using StatisticalRethinking
using StatsPlots

ProjDir = @__DIR__
cd(ProjDir) #do

# ### Preliminary snippets

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = filter(row -> row[:age] >= 18, df);
scale!(df, [:height, :weight])

# Define the Stan language model

weightsmodel = "
data{
    int N;
    real xbar;
    vector[N] height;
    vector[N] weight;
}
parameters{
    real alpha;
    real beta;
    real<lower=0,upper=50> sigma;
}
model{
    vector[N] mu;
    sigma ~ uniform( 0 , 50 );
    beta ~ normal( 0 , 1 );
    alpha ~ normal( 178 , 20 );
    for ( i in 1:N ) {
        mu[i] = alpha + beta * (weight[i] - xbar);
    }
    height ~ normal( mu , sigma );
}
";

# Define the SampleModel.

sm = SampleModel("weights", weightsmodel);

# Input data.

heightsdata = Dict(
  "N" => size(df, 1), 
  "height" => df[:, :height], 
  "weight" => df[:, :weight],
  "xbar" => mean(df[:, :weight])
);

# Sample using stan

rc = stan_sample(sm, data=heightsdata);

rethinking = "
        mean   sd   5.5%  94.5%
a     154.60 0.27 154.17 155.03
b       0.90 0.04   0.84   0.97
sigma   5.07 0.19   4.77   5.38
"

if success(rc)

  sdf = read_summary(sm)
  sdf |> display
  println()

  # ### Snippet 4.53

  dfa = read_samples(sm; output_format=:dataframe)

  mu_range = 30:1:60

  # ### Snippet 4.54
  xbar = mean(df[:, :weight])
  mu = link(dfa, [:alpha, :beta], mu_range, xbar);

  # ### Snippet 4.55

  q = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)
  q[1] = plot(xlab="weight", ylab="height")
  for (indx, mu_val) in enumerate(mu_range)
    for j in 1:length(mu_range)
      scatter!(q[1], [mu_val], [mu[indx][j]], markersize=3, leg=false, color=:lightblue)
    end
  end

  # ### Snippets 4.56

  mu_range = 30:0.1:60
  xbar = mean(df[:, :weight])
  mu = link(dfa, [:alpha, :beta], mu_range, xbar);
  q[2] = plot(xlab="weight", ylab="height", legend=:topleft)
  scatter!(q[2], df[:, :weight], df[:, :height], markersize=2, lab="Observations")
  for (ind, m) in enumerate(mu_range)
    plot!(q[2], [m, m], quantile(mu[ind], [0.055, 0.945]), color=:grey, leg=false)
  end
  plot!(q[2], mu_range, [mean(mu[i]) for i in 1:length(mu_range)], color=:red, lab="Means of mu")

  plot(q..., layout=(2,1))
  savefig("$(ProjDir)/Fig-53-58.png")

end

#end # cd .. do

# End of `04/clip-53-58.jl`
