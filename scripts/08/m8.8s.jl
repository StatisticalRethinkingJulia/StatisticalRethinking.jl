# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

# ### snippet 8.25

N = 100                                                    # individuals
height  = rand(Normal(10,2), N) ;              # sim total height of each
leg_prop = rand(Uniform(0.4,0.5), N);      # leg as proportion of height

# sim left leg as proportion + error
leg_left = leg_prop .* height .+  rand(Normal( 0 , 0.02 ), N);
# sim right leg as proportion + error
leg_right = leg_prop .* height .+  rand(Normal( 0 , 0.02 ), N);

# combine into data frame

df =  DataFrame(height=height, leg_left = leg_left, leg_right = leg_right);

# Show first 5 rows

first(df, 5)

# Define the Stan language model

m_5_8_model = "
data{
    int N;
    real height[N];
    real leg_right[N];
    real leg_left[N];
}
parameters{
    real a;
    real bl;
    real br;
    real sigma;
}
model{
    vector[N] mu;
    sigma ~ cauchy( 0 , 1 );
    br ~ normal( 2 , 10 );
    bl ~ normal( 2 , 10 );
    a ~ normal( 10 , 100 );
    for ( i in 1:100 ) {
        mu[i] = a + bl * leg_left[i] + br * leg_right[i];
    }
    height ~ normal( mu , sigma );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m_5_8_model", monitors = ["a", "br", "bl", "sigma"],
  model=m_5_8_model, output_format=:mcmcchain);

# Input data for cmdstan

m_8_8_data = Dict("N" => size(df, 1), "height" => df[:height],
    "leg_left" => df[:leg_left], "leg_right" => df[:leg_right]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m_8_8_data, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

# Plot the density of posterior draws

plot(chn)

# Autocorrelation

autocorplot(chn)

# End of `08/m8.8s.jl`
