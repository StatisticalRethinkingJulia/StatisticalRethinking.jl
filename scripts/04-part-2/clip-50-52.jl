# Load Julia packages (libraries) needed for clip

using StatisticalRethinking

ProjDir = @__DIR__
cd(ProjDir) #do

# ### Preliminary snippets

df = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')

# Use only adults

df = filter(row -> row[:age] >= 18, df);

# Center weight and store as weight_c

scale!(df, [:height, :weight])
first(df, 5)

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

  sdf =read_summary(sm)
  sdf |> display
  println()

  global dfa = read_samples(sm; output_format=:dataframe)

  # ### Snippet 4.47

  # Show first 5 draws of correlated parameter values in chain 1

  println()
  dfa[1:5,:] |> display
  println()

  # ### Snippets 4.50

  xbar = mean(df[:, :weight])
  ybar = mean(df[:, :height])

  mu_at_50 = link(dfa, [:alpha, :beta], [50], xbar)[1];
  hpd_bounds = hpdi(mu_at_50, alpha=0.055)
  println("\nhpd_bounds = $(hpdi(mu_at_50))\n")
  density(mu_at_50, title="mu at 50", lab="mu")
  vline!(hpd_bounds, lab="hpdi(..., alpha=0.055)")
  vline!(quantile(mu_at_50, [0.055, 0.945]), lab="quantile(...,[0.055, 0.945])")
  savefig("$ProjDir/fig-50-52.1.png")

  # ### Snippet 4.54

  # Show posterior density for 6 mu_bar values

  xvals = [20, 30, 40, 50, 60, 70]
  mu = link(dfa, [:alpha, :beta], xvals, xbar);

  q = Vector{Plots.Plot{Plots.GRBackend}}(undef, size(mu, 1))
  for i in 1:size(mu, 1)
    q[i] = density(mu[i], ylim=(0.0, 1.0), xlims=(130,180),
      leg=false, title="mu_at_$(xvals[i])")
    vline!(q[i], hpdi(mu[i]))
  end
  plot(q..., layout=(3, 2), ticks=(3))
  savefig("$ProjDir/Fig-50-52.2.png")

end

#end # cd .. do

# End of `04/clip-48-54.jl`
