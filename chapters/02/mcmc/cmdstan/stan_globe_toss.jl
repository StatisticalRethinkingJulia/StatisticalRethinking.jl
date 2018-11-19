## Binomial Example ####
## Note: Adapted from the Rate_4 example in Bayesian Cognitive Modeling
## https://github.com/stan-dev/example-models/tree/master/Bayesian_Cognitive_Modeling

using CmdStan, StanDataFrames, Distributions, Statistics, StatPlots, Plots
gr(size=(500,800))

ProjDir = @__DIR__
cd(ProjDir) do

  binomialstanmodel = "
  // Inferring a Rate
  data {
    int<lower=1> n;
    int<lower=0> k;
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
  generated quantities {
    int<lower=0> postpredk;
    int<lower=0> priorpredk;
    postpredk <- binomial_rng(n, theta);
    priorpredk <- binomial_rng(n, thetaprior);
  }
  "

  global stanmodel, rc, sim
  stanmodel = Stanmodel(name="binomial", model=binomialstanmodel, output_format=:dataframe)

  binomialdata = [
    Dict("n" => 9, "k" => 6)
  ]

  global df
  rc, df, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,
              CmdStanDir=CMDSTAN_HOME)

  if rc == 0
    println()
    p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)
    x = 0:0.01:1
    for i in 1:4
      @show res = fit_mle(Normal, df[i][:theta])
      μ = round(res.μ, digits=2)
      σ = round(res.σ, digits=2)
      p[i] = @df df[i] density(:theta, lab="Chain $i density")
      plot!(p[i], x, pdf.(Normal(res.μ, res.σ), x), lab="Fitted Normal($μ, $σ)")
    end
    plot(p..., layout=(4, 1))
    savefig("s2_8.pdf")
  end
  
end # cd
