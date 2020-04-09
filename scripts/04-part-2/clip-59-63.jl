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
    real a;
    real b;
    real<lower=0,upper=50> sigma;
}
model{
    vector[N] mu;
    sigma ~ uniform( 0 , 50 );
    b ~ normal( 0 , 1 );
    a ~ normal( 178 , 20 );
    for ( i in 1:N ) {
        mu[i] = a + b * weight[i];
    }
    height ~ normal( mu , sigma );
}
";

# Define the SampleModel.

sm = SampleModel("weights", weightsmodel);

# Input data.

heightsdata = Dict(
  "N" => size(df, 1), 
  "height" => df[:, :height_s], 
  "weight" => df[:, :weight_s],
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

  title = "Height vs. Weight, regions are" * "\nshowing 89% of predicted heights (lightgrey)" *
    "\nand 89% hpd interval around the mean line (darkgrey)"
  plotbounds(
    df, :weight, :height,
    dfa, [:a, :b];
    bounds=[:predicted, :hpdi],
    fig="$ProjDir/Fig-56-63.png",
    title=title,
    colors=[:lightgrey, :darkgrey]
  )

end

#end # cd .. do

# End of `04/clip-53-58.jl`
