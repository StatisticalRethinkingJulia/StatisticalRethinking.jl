# Load Julia packages (libraries) needed

using CmdStan, StanMCMCChain, MCMCChain, Distributions, Statistics, StatPlots, Plots
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

  global stanmodel, chn, sim, binomialdata, hpd_array
  
# Define the Stanmodel and set the output format to :mcmcchain.

  stanmodel = Stanmodel(name="binomial", monitors = ["theta"], model=binomialstanmodel,
    output_format=:mcmcchain)

# Make 5 cmdstan runs using 1, 4, 16, 64 and 256 data points to compare hpd regions

  hpd_array = Vector{MCMCChain.ChainSummary}(undef, 5)
  
  for j in 0:4
 
    N2 = 4^j
    d = Binomial(9, 0.66)
    n2 = Int.(9 * ones(Int, N2))
    #k2 = Int.(6 * ones(Int, N2))
    k2 = rand(d, N2)

# Input data for cmdstan

    binomialdata = [
      Dict("N" => length(n2), "n" => n2, "k" => k2)
    ]

# Sample using cmdstan
 
    rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
      CmdStanDir=CMDSTAN_HOME)

    if rc == 0
      println()
      p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
      x = 0:0.001:1
      for i in 1:4
        vals = convert.(Float64, chn.value[:, 1, i])
        @show res = fit_mle(Normal, vals)
        μ = round(res.μ, digits=2)
        σ = round(res.σ, digits=2)
        p[i] = density(vals, lab="Chain $i density", title="$(N2) data points")
        plot!(p[i], x, pdf.(Normal(res.μ, res.σ), x), lab="Fitted Normal($μ, $σ)")
      end
      plot(p..., layout=(4, 1))
      savefig("s2_8_$j.pdf") #src
    end
  
    println()
    display(binomialdata)
    describe(chn)
    hpd_array[j+1] = MCMCChain.hpd(chn)
  end
  
end # cd

# Show the hpd intervals

hpd_array