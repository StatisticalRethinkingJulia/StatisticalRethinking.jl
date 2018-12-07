# Load Julia packages (libraries) needed

using StatisticalRethinking
using CmdStan, StanMCMCChain, MCMCChain, Distributions, Statistics, StatPlots, Plots
gr(size=(500,800))

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = @__DIR__
cd(ProjDir) #do

# Define the Stan language model

d = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data",
    "reedfrogs.csv"), delim=';')
size(d) # Should be 48x5

# Set number of tanks
d[:tank] = 1:size(d,1)

m12_2_model = "
  data{
      int<lower=1> N;
      int<lower=1> N_tank;
      int surv[N];
      int density[N];
      int tank[N];
  }
  parameters{
      vector[N_tank] a_tank;
      real a;
      real<lower=0> sigma;
  }
  model{
      vector[N] p;
      sigma ~ cauchy( 0 , 1 );
      a ~ normal( 0 , 1 );
      a_tank ~ normal( a , sigma );
      for ( i in 1:N ) {
          p[i] = a_tank[tank[i]];
      }
      surv ~ binomial_logit( density , p );
  }
  generated quantities{
      vector[N] p;
      for ( i in 1:N ) {
          p[i] = a_tank[tank[i]];
      }
  }
"

# Make variables visible outisde the do loop

global stanmodel, chn, sim, m12_2_data
  
# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m12_2", model=m12_2_model,
    output_format=:mcmcchain)

# Input data for cmdstan

    m12_2_data = [
      Dict(
        "N" => size(d, 1), 
        "N_tank" => size(d, 1), 
        "surv" => d[:surv],
        "density" => d[:density],
        "tank" => d[:tank]
        )
    ]

# Sample using cmdstan
 
rc, chn, cnames = stan(stanmodel, m12_2_data, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME)

describe(chn)  

end # cd

