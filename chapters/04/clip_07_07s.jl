# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain, MCMCChain, Distributions, Statistics, StatPlots, Plots
gr(size=(500,800))

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = @__DIR__
cd(ProjDir) #do

# ### snippet 4.7

howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1)

# Use only adults

df2 = filter(row -> row[:age] >= 18, df)

# Define the Stan language model

  heightsmodel = "
  // Inferring a Rate
  data {
    int N;
    real<lower=0> h[N];
  }
  parameters {
    real<lower=0> sigma;
    real<lower=0,upper=250> mu;
  }
  model {
    // Priors for mu and sigma
    mu ~ uniform(100, 250);
    sigma ~ cauchy( 0 , 1 );

    // Observed heights
    h ~ normal(mu, sigma);
  }
  "

# Make variables visible outisde the do loop

  global stanmodel, chn
  
# Define the Stanmodel and set the output format to :mcmcchain.

  stanmodel = Stanmodel(name="heights", monitors = ["mu", "sigma"],model=heightsmodel,
    output_format=:mcmcchain)

# Input data for cmdstan

    heightsdata = [
      Dict("N" => length(df2[:height]), "h" => df2[:height])
    ]

# Sample using cmdstan

    rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
      CmdStanDir=CMDSTAN_HOME)

# Describe the draws

    describe(chn)

