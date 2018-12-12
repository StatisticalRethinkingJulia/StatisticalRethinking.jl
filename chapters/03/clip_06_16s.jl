# Load Julia packages (libraries) needed

using StatisticalRethinking
gr(size=(500,800))

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = @__DIR__
cd(ProjDir) do

# Define the Stan language model

  binomialstanmodel = "
  // Inferring a Rate
  data {
    int N;
    int<lower=0> k[N];
    int<lower=1> n[N];
  }
  parameters {
    real<lower=0,upper=1> theta;
    real<lower=0,upper=1> thetaprior;
  }
  model {
    // Prior Distribution for Rate Theta
    theta ~ beta(1, 1);
    thetaprior ~ beta(1, 1);

    // Observed Counts
    k ~ binomial(n, theta);
  }
  "

# Make variables visible outisde the do loop

  global stanmodel, chn
  
# Define the Stanmodel and set the output format to :mcmcchain.

  stanmodel = Stanmodel(name="binomial", monitors = ["theta"], model=binomialstanmodel,
    output_format=:mcmcchain)

# Use 16 observations

    N2 = 4
    n2 = Int.(9 * ones(Int, N2))
    k2 = [6, 5, 7, 6]

# Input data for cmdstan

    binomialdata = [
      Dict("N" => length(n2), "n" => n2, "k" => k2)
    ]

# Sample using cmdstan
 
    rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
      CmdStanDir=CMDSTAN_HOME)

# Describe the draws

    describe(chn)

# Look at area of hpd

    MCMCChain.hpd(chn)

# Plot the 4 chains

    if rc == 0
      mixeddensity(chn)
      bnds = MCMCChain.hpd(convert(Vector{Float64}, chn.value[:,1,1]))
      vline!([bnds[1]], line=:dash)
      vline!([bnds[2]], line=:dash)
    end

end # cd

