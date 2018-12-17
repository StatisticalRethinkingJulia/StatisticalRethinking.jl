var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#StatisticalRethinking-1",
    "page": "Home",
    "title": "StatisticalRethinking",
    "category": "section",
    "text": ""
},

{
    "location": "#Introduction-1",
    "page": "Home",
    "title": "Introduction",
    "category": "section",
    "text": "This package contains the Julia versions of the snippets contained in the R package \"rethinking\" associated with the book Statisticasl Rethinking by Richard McElreath."
},

{
    "location": "#Layout-of-the-package-1",
    "page": "Home",
    "title": "Layout of the package",
    "category": "section",
    "text": "Instead of having all snippets in a single file, the snippets are organized by chapter and grouped into clips of related snippets. E.g. chapter 0 of the R package rethinking has snippets 0.1 to 0.5. These are divided over 2 clips:clip_01_03.jl - contains snippets 0.1 through 0.3\nclip_04_05.jl - contains snippets 0.4 and 0.5.These 2 files are in chapters/00. These files are later on processed by Literate.jl to create 2 derived versions, e.g. from clip_01_03.jl in chapters/00:clip_01_03.md - which is stored in docs/src and included in the documentation\nclip_01_03.ipynb - stored in the notebooks directory for use in JupyterThe intention is that when needed clips with names such as clip_05_07t.jl, clip_05_07s.jl and clip_05_07m.jl will show up. These will contain mcmc implementations using Turing.jl, CmdStan.jl and Mamba.jl respectively. Examples have been added to chapter 2.Occasionally a clip contains a single snippet and will be refered to as clip_02.jl, e.g. in chapters/03"
},

{
    "location": "#Acknowledgements-1",
    "page": "Home",
    "title": "Acknowledgements",
    "category": "section",
    "text": "Richard Torkar has taken the lead in developing the Turing versions of the models from chapter 8 onwards.The TuringLang team and #turing contributors on Slack have been extremely helpful!The mcmc components are based on:TuringLang\nStanJulia\nMambaCurrentModule = StatisticalRethinking"
},

{
    "location": "#StatisticalRethinking.maximum_a_posteriori-Tuple{Any,Any,Any}",
    "page": "Home",
    "title": "StatisticalRethinking.maximum_a_posteriori",
    "category": "method",
    "text": "maximumaposterior\n\nCompute the maximumaposteriori of a model. \n\nMethod\n\nmaximum_a_posteriori(model, lower_bound, upper_bound)\n\nRequired arguments\n\n* `model::Turing model`\n* `lower_bound::Float64`\n\nReturn values\n\n* `result`                       : Maximum_a_posterior vector\n\nExamples\n\nSee ...\n\n\n\n\n\n"
},

{
    "location": "#maximum_a_posteriori-1",
    "page": "Home",
    "title": "maximum_a_posteriori",
    "category": "section",
    "text": "maximum_a_posteriori(model, lower_bound, upper_bound)"
},

{
    "location": "00/clip_01_03/#",
    "page": "clip_01_03",
    "title": "clip_01_03",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/00/clip_01_03.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(300, 300))"
},

{
    "location": "00/clip_01_03/#snippet-0.1-1",
    "page": "clip_01_03",
    "title": "snippet 0.1",
    "category": "section",
    "text": "println( \"All models are wrong, but some are useful.\" )"
},

{
    "location": "00/clip_01_03/#snippet-0.2-1",
    "page": "clip_01_03",
    "title": "snippet 0.2",
    "category": "section",
    "text": "This is a StepRange, not a vectorx = 1:3Below still preserves the StepRangex = x*10Broadcast log to steprange elements in x, this returms a vector! Notice the log.(x) notation.x = log.(x)We can sum the vector xx = sum(x)Etc.x = exp(x)\nx = x*10\nx = log(x)\nx = sum(x)\nx = exp(x)"
},

{
    "location": "00/clip_01_03/#snippet-0.3-1",
    "page": "clip_01_03",
    "title": "snippet 0.3",
    "category": "section",
    "text": "[log(0.01^200) 200 * log(0.01)]This page was generated using Literate.jl."
},

{
    "location": "00/clip_04_05/#",
    "page": "clip_04_04",
    "title": "clip_04_04",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/00/clip_04_05.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking, GLM\ngr(size=(300, 300))"
},

{
    "location": "00/clip_04_05/#snippet-0.4-1",
    "page": "clip_04_04",
    "title": "snippet 0.4",
    "category": "section",
    "text": "Below dataset(...) provides access to often used R datasets.cars = dataset(\"datasets\", \"cars\")If this is not a common R dataset, use e.g.: howell1 = CSV.read(joinpath(ProjDir, \"..\", \"..\",  \"data\", \"Howell1.csv\"), delim=\';\') df = convert(DataFrame, howell1)This reads the Howell1.csv dataset in the data subdirectory of this package,  StatisticalRethinking.jl. See also the chapter 4 snippets.Fit a linear regression of distance on speedm = lm(@formula(Dist ~ Speed), cars)estimated coefficients from the modelcoef(m)Plot residuals against speedscatter( cars[:Speed], residuals(m),\n  xlab=\"Speed\", ylab=\"Model residual values\", lab=\"Model residuals\")"
},

{
    "location": "00/clip_04_05/#snippet-0.5-is-replaced-by-above-using-StatisticalRethinking.-1",
    "page": "clip_04_04",
    "title": "snippet 0.5 is replaced by above using StatisticalRethinking.",
    "category": "section",
    "text": "This page was generated using Literate.jl."
},

{
    "location": "02/clip_01_02/#",
    "page": "clip_01_02",
    "title": "clip_01_02",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_01_02.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300))"
},

{
    "location": "02/clip_01_02/#snippet-2.1-1",
    "page": "clip_01_02",
    "title": "snippet 2.1",
    "category": "section",
    "text": "ways  = [0, 3, 8, 9, 0]ways/sum(ways)"
},

{
    "location": "02/clip_01_02/#snippet-2.2-1",
    "page": "clip_01_02",
    "title": "snippet 2.2",
    "category": "section",
    "text": "Create a distribution with n = 9 (e.g. tosses) and p = 0.5.d = Binomial(9, 0.5)Probability density for 6 waters holding n = 9 and p = 0.5.pdf(d, 6)This page was generated using Literate.jl."
},

{
    "location": "02/clip_03_05/#",
    "page": "clip_03_05",
    "title": "clip_03_05",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_03_05.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300))"
},

{
    "location": "02/clip_03_05/#snippet-2.3-1",
    "page": "clip_03_05",
    "title": "snippet 2.3",
    "category": "section",
    "text": "Define a gridN = 20\np_grid = range( 0 , stop=1 , length=N )Define the (uniform) priorprior = ones( 20 )Compute likelihood at each value in gridlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]Compute product of likelihood and priorunstd_posterior = likelihood .* priorStandardize the posterior, so it sums to 1posterior = unstd_posterior  ./ sum(unstd_posterior)"
},

{
    "location": "02/clip_03_05/#snippet-2.4-1",
    "page": "clip_03_05",
    "title": "snippet 2.4",
    "category": "section",
    "text": "p1 = plot( p_grid , posterior ,\n    xlab=\"probability of water\" , ylab=\"posterior probability\",\n    lab = \"interpolated\", title=\"20 points\" )\np2 = scatter!( p1, p_grid , posterior, lab=\"computed\" )"
},

{
    "location": "02/clip_03_05/#snippet-2.5-1",
    "page": "clip_03_05",
    "title": "snippet 2.5",
    "category": "section",
    "text": "prior1 = [p < 0.5 ? 0 : 1 for p in p_grid]\nprior2 = [exp( -5*abs( p - 0.5 ) ) for p in p_grid]\n\np3 = plot(p_grid, prior1,\n  xlab=\"probability of water\" , ylab=\"posterior probability\",\n  lab = \"semi_uniform\", title=\"Other priors\" )\nscatter!(p3, p_grid, prior1, lab = \"semi_uniform grid point\")\nplot!(p3, p_grid, prior2,  lab = \"double_exponential\" )\nscatter!(p3, p_grid, prior2,  lab = \"double_exponential grid point\" )This page was generated using Literate.jl."
},

{
    "location": "02/clip_06_07/#",
    "page": "clip_06_07",
    "title": "clip_06_07",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_06_07.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300))"
},

{
    "location": "02/clip_06_07/#snippet-2.6-(see-snippet-3_2-for-explanations)-1",
    "page": "clip_06_07",
    "title": "snippet 2.6 (see snippet 3_2 for explanations)",
    "category": "section",
    "text": "p_grid = range(0, step=0.001, stop=1)\nprior = ones(length(p_grid))\nlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]\nposterior = likelihood .* prior\nposterior = posterior / sum(posterior)\nsamples = sample(p_grid, Weights(posterior), length(p_grid))\n\np = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")\nplot(p..., layout=(1, 2))"
},

{
    "location": "02/clip_06_07/#snippet-2.7-1",
    "page": "clip_06_07",
    "title": "snippet 2.7",
    "category": "section",
    "text": "analytical calculationw = 6\nn = 9\nx = 0:0.01:1\nscatter( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationscatter!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")This page was generated using Literate.jl."
},

{
    "location": "02/clip_08t/#",
    "page": "clip_08t",
    "title": "clip_08t",
    "category": "page",
    "text": "Load Julia packages (libraries) neededusing StatisticalRethinking\nusing StatsFuns, Optim, Turing, Flux.Tracker\n\nTuring.setadbackend(:reverse_diff):reverse_diff"
},

{
    "location": "02/clip_08t/#snippet-2.8t-1",
    "page": "clip_08t",
    "title": "snippet 2.8t",
    "category": "section",
    "text": "Define the datak = 6; n = 9;Define the model@model globe_toss(n, k) = begin\n  theta ~ Beta(1, 1) # prior\n  k ~ Binomial(n, theta) # model\n  return k, theta\nend;Compute the \"maximumaposteriori\" valueSet search boundslb = [0.0]; ub = [1.0];Create (compile) the modelmodel = globe_toss(n, k);Compute the maximumaposterioriresult = maximum_a_posteriori(model, lb, ub)Results of Optimization Algorithm\n * Algorithm: Fminbox with L-BFGS\n * Starting Point: [0.4025469894808926]\n * Minimizer: [0.6666666665600872]\n * Minimum: 1.297811e+00\n * Iterations: 3\n * Convergence: true\n   * |x - x\'| ≤ 0.0e+00: false \n     |x - x\'| = 8.80e-08 \n   * |f(x) - f(x\')| ≤ 0.0e+00 |f(x)|: false\n     |f(x) - f(x\')| = 1.21e-13 |f(x)|\n   * |g(x)| ≤ 1.0e-08: true \n     |g(x)| = 3.57e-09 \n   * Stopped by an increasing objective: false\n   * Reached Maximum Number of Iterations: false\n * Objective Calls: 52\n * Gradient Calls: 52Use Turing mcmcchn = sample(model, NUTS(1000, 0.65));┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/support/hmc_core.jl:246\n[NUTS{Any}] found initial ϵ: 1.6\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/support/hmc_core.jl:291\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/core/ad.jl:114\n┌ Warning: grad = [NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/core/ad.jl:115\n┌ Info:  Adapted ϵ = 0.9229926068166693, std = [1.0]; 500 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 0.36302001400000006;\n  #lf / sample        = 0.006;\n  #evals / sample     = 7.195;\n  pre-cond. metric    = [1.0].Look at the generated draws (in chn)describe(chn[:theta])Summary Stats:\nMean:           0.632864\nMinimum:        0.116554\n1st Quartile:   0.549645\nMedian:         0.641930\n3rd Quartile:   0.726905\nMaximum:        0.958864\nLength:         1000\nType:           Float64Compute at hpd regionbnds = MCMCChain.hpd(chn[:theta], alpha=0.05);analytical calculationw = 6\nn = 9\nx = 0:0.01:1\nplot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab=\"Conjugate solution\")(Image: svg)quadratic approximationplot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")(Image: svg)Turing Chain &  89%hpd region boundariesdensity!(chn[:theta], lab=\"Turing chain\")\nvline!([bnds[1]], line=:dash, lab=\"hpd lower bound\")\nvline!([bnds[2]], line=:dash, lab=\"hpd upper bound\")(Image: svg)Show hpd regionprintln(\"hpd bounds = $bnds\\n\")hpd bounds = [0.388854, 0.856032]This notebook was generated using Literate.jl."
},

{
    "location": "02/clip_08m/#",
    "page": "clip_08m",
    "title": "clip_08m",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_08m.jl\"using Distributed, Gadfly\nusing MambaDataglobe_toss = Dict{Symbol, Any}(\n  :w => [6, 7, 5, 6, 6],\n  :n => [9, 9, 9, 9, 9]\n)\nglobe_toss[:N] = length(globe_toss[:w])Model Specificationmodel = Model(\n  w = Stochastic(1,\n    (n, p, N) ->\n      UnivariateDistribution[Binomial(n[i], p) for i in 1:N],\n    false\n  ),\n  p = Stochastic(() -> Beta(1, 1))\n);Initial Valuesinits = [\n  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => 0.5),\n  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => rand(Beta(1, 1)))\n]Sampling Schemescheme = [NUTS(:p)]\nsetsamplers!(model, scheme);MCMC Simulationssim = mcmc(model, globe_toss, inits, 10000, burnin=2500, thin=1, chains=2)Describe drawsdescribe(sim)This page was generated using Literate.jl."
},

{
    "location": "02/clip_08s/#",
    "page": "clip_08s",
    "title": "clip_08s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_08s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,800))CmdStan uses a tmp directory to store the output of cmdstanProjDir = @__DIR__\ncd(ProjDir) doDefine the Stan language model  binomialstanmodel = \"\n  // Inferring a Rate\n  data {\n    int N;\n    int<lower=0> k[N];\n    int<lower=1> n[N];\n  }\n  parameters {\n    real<lower=0,upper=1> theta;\n    real<lower=0,upper=1> thetaprior;\n  }\n  model {\n    // Prior Distribution for Rate Theta\n    theta ~ beta(1, 1);\n    thetaprior ~ beta(1, 1);\n\n    // Observed Counts\n    k ~ binomial(n, theta);\n  }\n  \"Make variables visible outisde the do loop  global stanmodel, chn, sim, binomialdataDefine the Stanmodel and set the output format to :mcmcchain.  stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n    output_format=:mcmcchain)Use 16 observations    N2 = 4^2\n    d = Binomial(9, 0.66)\n    n2 = Int.(9 * ones(Int, N2))\n    k2 = rand(d, N2)Input data for cmdstan    binomialdata = [\n      Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n    ]Sample using cmdstan    rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n      CmdStanDir=CMDSTAN_HOME)Describe the draws    describe(chn)Plot the 4 chains    if rc == 0\n      p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\n      x = 0:0.001:1\n      for i in 1:4\n        vals = convert.(Float64, chn.value[:, 1, i])\n        @show res = fit_mle(Normal, vals)\n        μ = round(res.μ, digits=2)\n        σ = round(res.σ, digits=2)\n        p[i] = density(vals, lab=\"Chain $i density\", title=\"$(N2) data points\")\n        plot!(p[i], x, pdf.(Normal(res.μ, res.σ), x), lab=\"Fitted Normal($μ, $σ)\")\n      end\n      plot(p..., layout=(4, 1))\n    end\n\nend # cdThis page was generated using Literate.jl."
},

{
    "location": "03/clip_01/#",
    "page": "clip_01",
    "title": "clip_01",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip_01.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300))"
},

{
    "location": "03/clip_01/#snippet-3.1-1",
    "page": "clip_01",
    "title": "snippet 3.1",
    "category": "section",
    "text": "PrPV = 0.95\nPrPM = 0.01\nPrV = 0.001\nPrP = PrPV*PrV + PrPM*(1-PrV)\nPrVP = PrPV*PrV / PrPThis page was generated using Literate.jl."
},

{
    "location": "03/clip_02_05/#",
    "page": "clip_02_05",
    "title": "clip_02_05",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip_02_05.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300))"
},

{
    "location": "03/clip_02_05/#snippet-3.2-1",
    "page": "clip_02_05",
    "title": "snippet 3.2",
    "category": "section",
    "text": "Grid of 1001 stepsp_grid = range(0, step=0.001, stop=1)all priors = 1.0prior = ones(length(p_grid))Binomial pdflikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]As Uniform priar has been used, unstandardized posterior is equal to likelihoodposterior = likelihood .* priorScale posterior such that they become probabilitiesposterior = posterior / sum(posterior)"
},

{
    "location": "03/clip_02_05/#snippet-3.3-1",
    "page": "clip_02_05",
    "title": "snippet 3.3",
    "category": "section",
    "text": "Sample using the computed posterior values as weightsIn this example we keep the number of samples equal to the length of p_grid, but that is not required.N = 10000\nsamples = sample(p_grid, Weights(posterior), N)\nfitnormal= fit_mle(Normal, samples)"
},

{
    "location": "03/clip_02_05/#snippet-3.4-1",
    "page": "clip_02_05",
    "title": "snippet 3.4",
    "category": "section",
    "text": "Create a vector to hold the plots so we can later combine themp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:N, samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")"
},

{
    "location": "03/clip_02_05/#snippet-3.5-1",
    "page": "clip_02_05",
    "title": "snippet 3.5",
    "category": "section",
    "text": "Analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")Add quadratic approximationplot!( p[2], x, pdf.(Normal( fitnormal.μ, fitnormal.σ ) , x ), lab=\"Normal approximation\")\nplot(p..., layout=(1, 2))This page was generated using Literate.jl."
},

{
    "location": "03/clip_05s/#",
    "page": "clip_05s",
    "title": "clip_05s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip_05s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,800))CmdStan uses a tmp directory to store the output of cmdstanProjDir = @__DIR__\ncd(ProjDir) doDefine the Stan language model  binomialstanmodel = \"\n  // Inferring a Rate\n  data {\n    int N;\n    int<lower=0> k[N];\n    int<lower=1> n[N];\n  }\n  parameters {\n    real<lower=0,upper=1> theta;\n    real<lower=0,upper=1> thetaprior;\n  }\n  model {\n    // Prior Distribution for Rate Theta\n    theta ~ beta(1, 1);\n    thetaprior ~ beta(1, 1);\n\n    // Observed Counts\n    k ~ binomial(n, theta);\n  }\n  \"Make variables visible outisde the do loop  global stanmodel, chnDefine the Stanmodel and set the output format to :mcmcchain.  stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n    output_format=:mcmcchain)Use 16 observations    N2 = 4^2\n    d = Binomial(9, 0.66)\n    n2 = Int.(9 * ones(Int, N2))\n    k2 = rand(d, N2)Input data for cmdstan    binomialdata = [\n      Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n    ]Sample using cmdstan    rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n      CmdStanDir=CMDSTAN_HOME)Describe the draws    describe(chn)Plot the 4 chains    if rc == 0\n      plot(chn)\n    end\n\nend # cdThis page was generated using Literate.jl."
},

{
    "location": "03/clip_06_16s/#",
    "page": "clip_06_16s",
    "title": "clip_06_16s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip_06_16s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,800))CmdStan uses a tmp directory to store the output of cmdstanProjDir = @__DIR__\ncd(ProjDir) doDefine the Stan language model  binomialstanmodel = \"\n  // Inferring a Rate\n  data {\n    int N;\n    int<lower=0> k[N];\n    int<lower=1> n[N];\n  }\n  parameters {\n    real<lower=0,upper=1> theta;\n    real<lower=0,upper=1> thetaprior;\n  }\n  model {\n    // Prior Distribution for Rate Theta\n    theta ~ beta(1, 1);\n    thetaprior ~ beta(1, 1);\n\n    // Observed Counts\n    k ~ binomial(n, theta);\n  }\n  \"Make variables visible outisde the do loop  global stanmodel, chnDefine the Stanmodel and set the output format to :mcmcchain.  stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n    output_format=:mcmcchain)Use 16 observations    N2 = 4\n    n2 = Int.(9 * ones(Int, N2))\n    k2 = [6, 5, 7, 6]Input data for cmdstan    binomialdata = [\n      Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n    ]Sample using cmdstan    rc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n      CmdStanDir=CMDSTAN_HOME)Describe the draws    describe(chn)Look at area of hpd    MCMCChain.hpd(chn)Plot the 4 chains    if rc == 0\n      mixeddensity(chn)\n      bnds = MCMCChain.hpd(convert(Vector{Float64}, chn.value[:,1,1]))\n      vline!([bnds[1]], line=:dash)\n      vline!([bnds[2]], line=:dash)\n    end\n\nend # cdThis page was generated using Literate.jl."
},

{
    "location": "04/clip_01_06/#",
    "page": "clip_01_06",
    "title": "clip_01_06",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_01_06.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300))"
},

{
    "location": "04/clip_01_06/#snippet-4.1-1",
    "page": "clip_01_06",
    "title": "snippet 4.1",
    "category": "section",
    "text": "No attempt has been made to condense this too fewer lines of codenoofsteps = 20;\nnoofwalks = 15;\npos = Array{Float64, 2}(rand(Uniform(-1, 1), noofsteps, noofwalks));\npos[1, :] = zeros(noofwalks);\ncsum = cumsum(pos, dims=1);\n\nf = Plots.font(\"DejaVu Sans\", 6)\nmx = minimum(csum) * 0.9Plot and annotate the random walksp1 = plot(csum, leg=false, title=\"Random walks ($(noofwalks))\")\nplot!(p1, csum[:, Int(floor(noofwalks/2))], leg=false, title=\"Random walks ($(noofwalks))\", color=:black)\nplot!(p1, [5], seriestype=\"vline\")\nannotate!(5, mx, text(\"step 4\", f, :left))\nplot!(p1, [9], seriestype=\"vline\")\nannotate!(9, mx, text(\"step 8\", f, :left))\nplot!(p1, [17], seriestype=\"vline\")\nannotate!(17, mx, text(\"step 16\", f, :left))Generate 3 plots of densities at 3 different step numbers (4, 8 and 16)p2 = Vector{Plots.Plot{Plots.GRBackend}}(undef, 3);\nplt = 1\nfor step in [4, 8, 16]\n  indx = step + 1 # We aadded the first line of zeros\n  global plt\n  fit = fit_mle(Normal, csum[indx, :])\n  x = (fit.μ-4*fit.σ):0.01:(fit.μ+4*fit.σ)\n  p2[plt] = density(csum[indx, :], legend=false, title=\"$(step) steps\")\n  plot!( p2[plt], x, pdf.(Normal( fit.μ , fit.σ ) , x ), fill=(0, .5,:orange))\n  plt += 1\nend\np3 = plot(p2..., layout=(1, 3))\n\nplot(p1, p3, layout=(2,1))"
},

{
    "location": "04/clip_01_06/#snippet-4.2-1",
    "page": "clip_01_06",
    "title": "snippet 4.2",
    "category": "section",
    "text": "prod(1 .+ rand(Uniform(0, 0.1), 10))"
},

{
    "location": "04/clip_01_06/#snippet-4.3-1",
    "page": "clip_01_06",
    "title": "snippet 4.3",
    "category": "section",
    "text": "growth = [prod(1 .+ rand(Uniform(0, 0.1), 10)) for i in 1:10000];\nfit = fit_mle(Normal, growth)\nplot(Normal(fit.μ , fit.σ ), fill=(0, .5,:orange), lab=\"Normal distribution\")\ndensity!(growth, lab=\"\'sample\' distribution\")"
},

{
    "location": "04/clip_01_06/#snippet-4.4-1",
    "page": "clip_01_06",
    "title": "snippet 4.4",
    "category": "section",
    "text": "big = [prod(1 .+ rand(Uniform(0, 0.5), 12)) for i in 1:10000];\nsmall = [prod(1 .+ rand(Uniform(0, 0.01), 12)) for i in 1:10000];\nfitb = fit_mle(Normal, big)\nfits = fit_mle(Normal, small)\np1 = plot(Normal(fitb.μ , fitb.σ ), lab=\"Big normal distribution\", fill=(0, .5,:orange))\np2 = plot(Normal(fits.μ , fits.σ ), lab=\"Small normal distribution\", fill=(0, .5,:orange))\ndensity!(p1, big, lab=\"\'big\' distribution\")\ndensity!(p2, small, lab=\"\'small\' distribution\")\nplot(p1, p2, layout=(1, 2))"
},

{
    "location": "04/clip_01_06/#snippet-4.5-1",
    "page": "clip_01_06",
    "title": "snippet 4.5",
    "category": "section",
    "text": "log_big = [log(prod(1 .+ rand(Uniform(0, 0.5), 12))) for i in 1:10000];\nfit = fit_mle(Normal, log_big)\nplot(Normal(fit.μ , fit.σ ), fill=(0, .5,:orange), lab=\"Normal distribution\")\ndensity!(log_big, lab=\"\'sample\' distribution\")"
},

{
    "location": "04/clip_01_06/#snippet-4.6-1",
    "page": "clip_01_06",
    "title": "snippet 4.6",
    "category": "section",
    "text": "Grid of 1001 stepsp_grid = range(0, step=0.001, stop=1);all priors = 1.0prior = ones(length(p_grid));Binomial pdflikelihood = [pdf(Binomial(9, p), 6) for p in p_grid];As Uniform priar has been used, unstandardized posterior is equal to likelihoodposterior = likelihood .* prior;Scale posterior such that they become probabilitiesposterior = posterior / sum(posterior);Sample using the computed posterior values as weights In this example we keep the number of samples equal to the length of p_grid, but that is not required.samples = sample(p_grid, Weights(posterior), length(p_grid));\np = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\", fill=(0, .5,:orange))\nplot(p..., layout=(1, 2))This page was generated using Literate.jl."
},

{
    "location": "04/clip_07.0s/#",
    "page": "clip_07.0s",
    "title": "clip_07.0s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_07.0s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,800))CmdStan uses a tmp directory to store the output of cmdstanProjDir = @__DIR__\ncd(ProjDir)"
},

{
    "location": "04/clip_07.0s/#snippet-4.7-1",
    "page": "clip_07.0s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)\nfemale_df = filter(row -> row[:male] == 0, df2)\nmale_df = filter(row -> row[:male] == 1, df2)Plot the densities.density(df2[:height], lab=\"All heights\")Is it bi-modal?density!(female_df[:height], lab=\"Female heights\")\ndensity!(male_df[:height], lab=\"Male heights\")Define the Stan language modelheightsmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  real<lower=0> h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=0,upper=250> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ normal(178, 20);\n  sigma ~ uniform( 0 , 50 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\"Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain)Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height])\n]Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME)Describe the drawsdescribe(chn)Plot the density of posterior drawsdensity(chn, lab=\"All heights\")This page was generated using Literate.jl."
},

{
    "location": "04/clip_07.1s/#",
    "page": "clip_07.1s",
    "title": "clip_07.1s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_07.1s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,800))CmdStan uses a tmp directory to store the output of cmdstanProjDir = @__DIR__\ncd(ProjDir)"
},

{
    "location": "04/clip_07.1s/#snippet-4.7-1",
    "page": "clip_07.1s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelheightsmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  real<lower=0> h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=0,upper=250> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ uniform(100, 250);\n  sigma ~ cauchy( 0 , 1 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\"Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain)Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height])\n]Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME)Describe the drawsdescribe(chn)Compare with previous resultclip_07s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean        SD      Naive SE      MCSE      ESS\nsigma   7.7641718 0.3055115 0.004830561 0.0047596714 1000\n   mu 154.6042417 0.4158242 0.006574758 0.0068304868 1000\n\nQuantiles:\n         2.5%       25.0%       50.0%      75.0%      97.5%\nsigma   7.198721   7.5573575   7.749435   7.960795   8.393317\n   mu 153.795975 154.3307500 154.610000 154.884000 155.391050\n\n\"Plot the density of posterior drawsdensity(chn)Close cd(ProjDir) do blockThis page was generated using Literate.jl."
},

{
    "location": "08/m8.1/#",
    "page": "m8.1.jl",
    "title": "m8.1.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/08/m8.1.jl\"m8.1stanm8.1stan is the first model in the Statistical Rethinking book (pp. 249) using Stan. Here we will use Turing\'s NUTS support, which is currently (2018) the original NUTS by Hoffman & Gelman, http://www.stat.columbia.edu/~gelman/research/published/nuts.pdf and not the one that\'s in Stan 2.18.2, i.e., Appendix A.5 in: https://arxiv.org/abs/1701.02434The StatisticalRethinking pkg uses, e.g., Turing, CSV, DataFramesusing StatisticalRethinking\n\nd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\",\n    \"rugged.csv\"), delim=\';\')\nsize(d) # Should be 234x51Apply log() to each element in rgdppc_2000 column and add it as a new columnd = hcat(d, map(log, d[Symbol(\"rgdppc_2000\")]))\nrename!(d, :x1 => :log_gdp) # Rename our col x1 => log_gdpNow we need to drop every row where rgdppc2000 == missing When this (https://github.com/JuliaData/DataFrames.jl/pull/1546) hits DataFrame it\'ll be conceptually easier: i.e., completecases!(d, :rgdppc2000)notisnan(e) = !ismissing(e)\ndd = d[map(notisnan, d[:rgdppc_2000]), :]\nsize(dd) # should equal 170 x 52\n\n@model m8_1stan(y, x₁, x₂) = begin\n    σ ~ Truncated(Cauchy(0, 2), 0, Inf)\n    βR ~ Normal(0, 10)\n    βA ~ Normal(0, 10)\n    βAR ~ Normal(0, 10)\n    α ~ Normal(0, 100)\n\n    for i ∈ 1:length(y)\n        y[i] ~ Normal(α + βR * x₁[i] + βA * x₂[i] + βAR * x₁[i] * x₂[i], σ)\n    end\nendTest to see that the model is sane. Use 2000 for now, as in the book. Need to set the same stepsize and adapt_delta as in Stan...posterior = sample(m8_1stan(dd[:,:log_gdp], dd[:,:rugged], dd[:,:cont_africa]),\n    Turing.NUTS(2000, 1000, 0.95))\ndescribe(posterior)Output reg. params of interest:        Mean           SD        Naive SE        MCSE         ESS α    9.2140454953  0.416410339 0.00931121825 0.0303436655  188.324543 βA  -1.9414588557  0.373885658 0.00836033746 0.0583949856   40.994586 βR  -0.1987645549  0.158902372 0.00355316505 0.0128657961  152.541295 σ    0.9722532977  0.440031013 0.00983939257 0.0203736871  466.473854 βAR  0.3951414223  0.187780491 0.00419889943 0.0276680621   46.062071Here\'s the map2stan output:        Mean StdDev lower 0.89 upper 0.89 n_eff Rhat a      9.24   0.14       9.03       9.47   291    1 bR    -0.21   0.08      -0.32      -0.07   306    1 bA    -1.97   0.23      -2.31      -1.58   351    1 bAR    0.40   0.13       0.20       0.63   350    1 sigma  0.95   0.05       0.86       1.03   566    1This page was generated using Literate.jl."
},

{
    "location": "08/m8.2/#",
    "page": "m8.2.jl",
    "title": "m8.2.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/08/m8.2.jl\"using StatisticalRethinkingIn Rethinking the model actually has priors that are U[-Inf, Inf], or as the Stan manual (2.17.0, pp. 127) tells us:\"A parameter declared without constraints is thus given a uniform prior on (−∞, ∞) ...\"But setting -Inf and Inf in Turing doesn\'t work. So the below works of course better since we\'ve restrained it to [-1,1]@model m8_2(y) = begin\n    σ ~ Uniform(-1, 1)\n    α ~ Uniform(-1, 1)\n\n    for i ∈ 1:length(y)\n        y[i] ~ Normal(α, σ)\n    end\nend\n\ny = [-1,1]\n\nposterior = sample(m8_2(y), Turing.NUTS(4000, 1000, 0.95))\ndescribe(posterior)This page was generated using Literate.jl."
},

{
    "location": "08/m8.3/#",
    "page": "m8.3.jl",
    "title": "m8.3.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/08/m8.3.jl\"using StatisticalRethinking\n\n@model m8_3(y) = begin\n    α ~ Normal(1, 10)\n    σ ~ Truncated(Cauchy(0, 1), 0, Inf)\n\n    for i ∈ 1:length(y)\n        y[i] ~ Normal(α, σ)\n    end\nend\n\ny = [-1,1]\n\nposterior = sample(m8_3(y), Turing.NUTS(4000, 1000, 0.95))\ndescribe(posterior)        Mean          SD         Naive SE        MCSE         ESSα       -1.075811343  1.334041836 0.02109305348 0.19866042331   45.093733 σ        2.137823169  1.466095174 0.02318100009 0.18324552293   64.011438According to Rethinking        Mean StdDev lower 0.89 upper 0.89 n_eff Rhat alpha -0.01   1.60      -1.98       2.37  1121    1 sigma  1.98   1.91       0.47       3.45  1077    1This page was generated using Literate.jl."
},

{
    "location": "08/m8.4/#",
    "page": "m8.4.jl",
    "title": "m8.4.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/08/m8.4.jl\"using StatisticalRethinkingCan\'t really set a U[-Inf,Inf] on \\sigma AFAICT so this will not be 1:1 w/ Rethinking@model m8_4(y) = begin\n    α₁ ~ Uniform(-Inf, Inf)\n    α₂ ~ Uniform(-Inf, Inf)\n    σ ~ Truncated(Cauchy(0,1), 0, Inf)\n\n    for i ∈ 1:length(y)\n        y[i] ~ Normal(α₁ + α₂, σ)\n    end\nend\n\ny = rand(Normal(0,1), 100)\n\nposterior = sample(m8_4(y), Turing.NUTS(4000, 1000, 0.95))\ndescribe(posterior)Rethinking         mean      sd     5.5%   94.5% n_eff Rhat a1    -861.15 558.17 -1841.89  -31.04     7 1.43 a2     861.26 558.17    31.31 1842.00     7 1.43 sigma    0.97   0.07     0.89    1.09     9 1.17This page was generated using Literate.jl."
},

{
    "location": "10/m10.3/#",
    "page": "m10.3.jl",
    "title": "m10.3.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/10/m10.3.jl\"using StatisticalRethinking\nusing StatsFuns #logistic() function\n\nd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\",\n    \"chimpanzees.csv\"), delim=\';\')\nsize(d) # Should be 504x8pulledleft, condition, prosocleft@model m10_3(y, x₁, x₂) = begin\n    α ~ Normal(0, 10)\n    βp ~ Normal(0, 10)\n    βpC ~ Normal(0, 10)\n\n    for i ∈ 1:length(y)\n        p = logistic(α + (βp + βpC * x₁[i]) * x₂[i])\n        y[i] ~ Binomial(1, p)\n    end\nend\n\nposterior = sample(m10_3(d[:,:pulled_left], d[:,:condition], d[:,:prosoc_left]),\n    Turing.NUTS(10000, 1000, 0.95))\ndescribe(posterior)Empirical Posterior Estimates:\n         Mean           SD        Naive SE       MCSE         ESSα           0.053228176  0.148432403 0.0033190494 0.0072162528  423.091170 βp          0.604297351  0.241527734 0.0054007243 0.0212696753  128.947312 βpC        -0.074156932  0.278219321 0.0062211731 0.0279932431   98.779800#StatisticalRethinking Mean StdDev lower 0.89 upper 0.89 n_eff Rhata    0.05   0.13      -0.15       0.25  3284    1 bp   0.62   0.22       0.28       0.98  3032    1 bpC -0.11   0.26      -0.53       0.29  3184    1This page was generated using Literate.jl."
},

{
    "location": "10/m10.4/#",
    "page": "m10.4.jl",
    "title": "m10.4.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/10/m10.4.jl\"using StatisticalRethinking\nusing StatsFuns #logistic() function\nusing Turing\n\nTuring.setadbackend(:reverse_diff)\n\nd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\",\n    \"chimpanzees.csv\"), delim=\';\')\nsize(d) # Should be 504x8pulledleft, actors, condition, prosocleft@model m10_4(y, actors, x₁, x₂) = beginNumber of unique actors in the data set    N_actor = length(unique(actors))Set an TArray for the priors/param    α = TArray{Any}(undef, N_actor)For each actor [1,..,7] set a prior    for i ∈ 1:length(α)\n        α[i] ~ Normal(0,10)\n    end\n\n    βp ~ Normal(0, 10)\n    βpC ~ Normal(0, 10)\n\n    for i ∈ 1:length(y)\n        p = logistic(α[actors[i]] + (βp + βpC * x₁[i]) * x₂[i])\n        y[i] ~ Binomial(1, p)\n    end\nend\n\nposterior = sample(m10_4(d[:,:pulled_left], d[:,:actor],d[:,:condition],\n    d[:,:prosoc_left]),\n    Turing.NUTS(2500, 500, 0.95))\ndescribe(posterior)         Mean           SD       Naive SE       MCSE         ESSβpC   -0.181394034  0.28946513 0.0057893027 0.0266018473  118.404696 α[1]   -0.750003835  0.29794860 0.0059589721 0.0278564821  114.401093 α[2]    9.372324757  4.49534602 0.0899069204 0.8306772626   29.286104 α[3]   -1.067303557  0.32767901 0.0065535802 0.0329610836   98.831248 α[4]   -1.060339791  0.27627393 0.0055254786 0.0298318788   85.766681 α[5]   -0.707040908  0.28169208 0.0056338417 0.0226231747  155.039440 α[6]    0.218884973  0.27572737 0.0055145474 0.0312307275   77.946310 α[7]    1.803365110  0.38459001 0.0076918002 0.0392945213   95.792607   βp    0.870271237  0.27987766 0.0055975532 0.0324186869   74.532489Rethinking       mean   sd  5.5% 94.5% n_eff Rhat a[1] -0.74 0.27 -1.17 -0.31  3838    1 a[2] 11.02 5.53  4.46 21.27  1759    1 a[3] -1.05 0.28 -1.50 -0.61  3784    1 a[4] -1.05 0.27 -1.48 -0.62  3761    1 a[5] -0.74 0.27 -1.18 -0.32  4347    1 a[6]  0.21 0.27 -0.23  0.66  3932    1 a[7]  1.81 0.39  1.19  2.46  4791    1 bp    0.84 0.26  0.42  1.26  2586    1 bpC  -0.13 0.30 -0.63  0.34  3508    1This page was generated using Literate.jl."
},

{
    "location": "11/m11_5/#",
    "page": "m11.5.jl",
    "title": "m11.5.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/11/m11_5.jl\"using StatisticalRethinking\nusing Turing\n\nTuring.setadbackend(:reverse_diff)\n\nd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\",\n    \"UCBadmit.csv\"), delim=\';\')\nsize(d) # Should be 12x5\n\n@model m11_5(admit, applications) = begin\n    N=length(applications)\n    θ ~ Truncated(Exponential(1), 0, Inf)\n    α ~ Normal(0,2)\n\n    for i ∈ 1:N\n        prob = logistic(α)alpha and beta for the BetaBinomial must be provided. The two parameterizations are related by alpha = prob * theta, and beta = (1-prob) * theta. See https://github.com/rmcelreath/rethinking/blob/master/man/dbetabinom.Rd        alpha = prob * θ\n        beta = (1 - prob) * θ\n\n        admit[i] ~ BetaBinomial(applications[i], alpha, beta)\n    end\nend\n\nposterior = sample(m11_5(d[:admit],d[:applications]), Turing.NUTS(4000, 1000, 0.9))\ndescribe(posterior)        Mean          SD         Naive SE         MCSE        ESS\n   α  -0.372382104 0.3119992723 0.004933141643 0.00613870681 2583.1723\n   θ   2.767996106 0.9897869845 0.015649906347 0.02305742759 1842.7303Rethinking        mean   sd  5.5% 94.5% n_eff Rhat theta  2.74 0.96  1.43  4.37  3583    1 a     -0.37 0.31 -0.87  0.12  3210    1This page was generated using Literate.jl."
},

{
    "location": "12/m12_1/#",
    "page": "m12.1.jl",
    "title": "m12.1.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/12/m12_1.jl\"using StatisticalRethinking\nusing Turing\n\nTuring.setadbackend(:reverse_diff)\n\nd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\",\n    \"reedfrogs.csv\"), delim=\';\')\nsize(d) # Should be 48x5Set number of tanksd[:tank] = 1:size(d,1)\n\n@model m12_1(density, tank, surv) = beginNumber of unique tanks in the data set    N_tank = length(tank)Set an TArray for the priors/param    a_tank = Vector{Real}(undef, N_tank)For each tank [1,..,48] set prior N(0,5)    a_tank ~ [Normal(0,5)]\n\n    logitp = [a_tank[tank[i]] for i = 1:N_tank]\n    surv ~ VecBinomialLogit(density, logitp)\nend\n\nposterior = sample(m12_1(Vector{Int64}(d[:density]), Vector{Int64}(d[:tank]),\n    Vector{Int64}(d[:surv])), Turing.NUTS(4000, 1000, 0.8))\ndescribe(posterior)            Mean           SD         Naive SE       MCSE         ESSatank[33]    3.7925121923  1.069473492 0.01690986065 0.0181583984 3468.84559  atank[2]    5.6619233751  2.661975386 0.04208952648 0.0984382340  731.27452 atank[44]   -0.4076755205  0.349650208 0.00552845521 0.0051973560 4000.00000 atank[40]    2.4882548674  0.642093720 0.01015239313 0.0087774011 4000.00000 atank[41]   -2.1368737936  0.588205639 0.00930034776 0.0091150511 4000.00000 atank[42]   -0.6773019465  0.370413780 0.00585675610 0.0052435688 4000.00000 atank[11]    0.9259845291  0.729448255 0.01153358961 0.0077243130 4000.00000 atank[16]    2.5669573506  1.256913239 0.01987354329 0.0240073491 2741.08301 atank[46]   -0.6654705830  0.370650246 0.00586049496 0.0058669658 3991.18148  atank[8]    2.5385573941  1.151976429 0.01821434663 0.0232427286 2456.47849 atank[14]    0.0006786356  0.680697609 0.01076277421 0.0069893413 4000.00000 atank[47]    2.1388988496  0.532096615 0.00841318620 0.0078518462 4000.00000 atank[43]   -0.5364419223  0.354074917 0.00559841600 0.0058512095 3661.83713 atank[24]    1.7486397297  0.597014797 0.00943963278 0.0071524317 4000.00000 atank[34]    2.9828401383  0.793129631 0.01254048056 0.0113862941 4000.00000  atank[9]   -0.4362986938  0.655848632 0.01036987739 0.0065852640 4000.00000 atank[28]   -0.5903300678  0.430889431 0.00681296010 0.0061191595 4000.00000 atank[31]   -0.7790724381  0.438852449 0.00693886648 0.0062867441 4000.00000 atank[29]    0.0892476063  0.403319027 0.00637703374 0.0065342700 3809.80961 atank[18]    2.5984354254  0.789739347 0.01248687547 0.0116099713 4000.00000  atank[1]    2.5169564861  1.202252233 0.01900927690 0.0261521039 2113.38159 atank[38]    6.5730591701  2.577397287 0.04075222931 0.0960321899  720.32596 atank[37]    2.1321270081  0.542445637 0.00857681860 0.0067553411 4000.00000 atank[30]    1.4436385748  0.510944886 0.00807874799 0.0061875938 4000.00000 atank[35]    2.9837870684  0.798955606 0.01263259732 0.0111689405 4000.00000 atank[20]    6.4209696786  2.614898794 0.04134518019 0.0934495614  782.98823 atank[15]    2.4852422308  1.182168671 0.01869172789 0.0235303705 2524.06980 atank[45]    0.5431043960  0.369638488 0.00584449767 0.0046883639 4000.00000 atank[26]    0.0840349555  0.395331366 0.00625073774 0.0067906853 3389.18550 atank[21]    2.6516314895  0.851902518 0.01346976151 0.0118211120 4000.00000 atank[48]   -0.0571820248  0.337815684 0.00534133495 0.0051459323 4000.00000 atank[10]    2.5310386381  1.157968533 0.01830909012 0.0251590089 2118.39263  atank[3]    0.9295620334  0.735176403 0.01162415958 0.0127307257 3334.85377  atank[7]    5.7185532309  2.796270760 0.04421292278 0.1047192286  713.02634  atank[6]    2.5050631208  1.183397045 0.01871115019 0.0243016893 2371.30836 atank[25]   -1.2007745016  0.470201538 0.00743453910 0.0071826339 4000.00000 atank[32]   -0.4234910116  0.414945560 0.00656086537 0.0060452516 4000.00000  atank[5]    2.5286171889  1.207469316 0.01909176622 0.0250131147 2330.32587 atank[13]    0.9170279823  0.723356937 0.01143727741 0.0091140235 4000.00000 atank[19]    2.1126922998  0.642028977 0.01015136946 0.0086040212 4000.00000 atank[12]    0.4476884510  0.682975434 0.01079878979 0.0070550762 4000.00000  atank[4]    5.5617118510  2.607791677 0.04123280681 0.1041546582  626.88574 atank[17]    3.4763818329  1.091795631 0.01726280467 0.0199830235 2985.10977 atank[27]   -1.7411510659  0.578372766 0.00914487638 0.0085613085 4000.00000 atank[22]    2.6038964868  0.779764455 0.01232915859 0.0107305461 4000.00000 atank[23]    2.6217848846  0.808680221 0.01278635699 0.0105079615 4000.00000 atank[36]    2.1205525264  0.557014163 0.00880716721 0.0077309477 4000.00000 atank[39]    2.9653158635  0.795061058 0.01257101910 0.0110571371 4000.00000Rethinking             mean   sd  5.5% 94.5% neff Rhat atank[1]   2.49 1.16  0.85  4.53  1079    1 atank[2]   5.69 2.75  2.22 10.89  1055    1 atank[3]   0.89 0.75 -0.23  2.16  1891    1 atank[4]   5.71 2.70  2.21 10.85   684    1 atank[5]   2.52 1.14  0.92  4.42  1640    1 atank[6]   2.49 1.13  0.94  4.52  1164    1 atank[7]   5.74 2.71  2.25 10.86   777    1 atank[8]   2.52 1.19  0.95  4.42  1000    1 atank[9]  -0.46 0.69 -1.62  0.55  2673    1 atank[10]  2.53 1.19  0.93  4.59  1430    1 atank[11]  0.93 0.72 -0.17  2.11  1387    1 atank[12]  0.47 0.74 -0.63  1.70  1346    1 atank[13]  0.91 0.76 -0.25  2.30  1559    1 atank[14]  0.00 0.66 -1.04  1.06  2085    1 atank[15]  2.50 1.19  0.95  4.40  1317    1 atank[16]  2.50 1.14  0.98  4.31  1412    1 atank[17]  3.49 1.12  1.94  5.49   945    1 atank[18]  2.59 0.75  1.50  3.81  1561    1 atank[19]  2.11 0.64  1.15  3.15  1712    1 atank[20]  6.40 2.57  3.11 11.04   996    1 atank[21]  2.59 0.74  1.54  3.93  1233    1 atank[22]  2.63 0.79  1.49  4.01  1184    1 atank[23]  2.64 0.83  1.45  4.13  1379    1 atank[24]  1.74 0.59  0.85  2.72  1736    1 atank[25] -1.19 0.45 -1.90 -0.50  2145    1 atank[26]  0.09 0.41 -0.53  0.78  2167    1 atank[27] -1.75 0.56 -2.65 -0.88  1666    1 atank[28] -0.58 0.43 -1.25  0.08  1567    1 atank[29]  0.08 0.39 -0.54  0.71  3053    1 atank[30]  1.43 0.49  0.66  2.24  2754    1 atank[31] -0.79 0.44 -1.50 -0.12  1299    1 atank[32] -0.42 0.41 -1.12  0.23  1661    1 atank[33]  3.84 1.08  2.31  5.70   808    1 atank[34]  3.00 0.85  1.83  4.36  1038    1 atank[35]  2.96 0.82  1.82  4.25  1578    1 atank[36]  2.14 0.55  1.31  3.08  1734    1 atank[37]  2.12 0.56  1.31  3.04  1131    1 atank[38]  6.72 2.62  3.45 11.44   706    1 atank[39]  2.95 0.73  1.85  4.08  1509    1 atank[40]  2.48 0.65  1.53  3.61  1731    1 atank[41] -2.15 0.57 -3.11 -1.29  1231    1 atank[42] -0.67 0.35 -1.22 -0.14  1444    1 atank[43] -0.54 0.35 -1.12  0.03  1776    1 atank[44] -0.43 0.34 -1.00  0.10  1735    1 atank[45]  0.54 0.36 -0.04  1.14  1376    1 atank[46] -0.67 0.34 -1.25 -0.15  1619    1 atank[47]  2.14 0.55  1.31  3.04  1916    1 a_tank[48] -0.06 0.35 -0.61  0.50  1932    1This page was generated using Literate.jl."
},

{
    "location": "12/m12_2/#",
    "page": "m12.2.jl",
    "title": "m12.2.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/12/m12_2.jl\"using StatisticalRethinking\nusing Turing\n\nTuring.setadbackend(:reverse_diff)\n\nd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\",\n    \"reedfrogs.csv\"), delim=\';\')\nsize(d) # Should be 48x5Set number of tanksd[:tank] = 1:size(d,1)Thanks to Kai Xu!@model m12_2(density, tank, surv) = beginSeparate priors on α and σ for each tank    σ ~ Truncated(Cauchy(0, 1), 0, Inf)\n    α ~ Normal(0, 1)Number of unique tanks in the data set    N_tank = length(tank)vector for the priors for each tank    a_tank = Vector{Real}(undef, N_tank)For each tank [1,..,48] set a prior. Note the [] around Normal().    a_tank ~ [Normal(α, σ)]Observation    logitp = [a_tank[tank[i]] for i = 1:N_tank]\n    surv ~ VecBinomialLogit(density, logitp)\n\nend\n\nposterior = sample(m12_2(Vector{Int64}(d[:density]), Vector{Int64}(d[:tank]),\n    Vector{Int64}(d[:surv])), Turing.NUTS(4000, 1000, 0.8))\ndescribe(posterior)            Mean           SD        Naive SE       MCSE         ESS\n σ       1.6165979235  0.254350155 0.0040216291 0.0056943516 1995.14955\n α       1.2953176604  0.246773278 0.0039018281 0.0042788414 3326.16566atank[33]   3.1850173180  0.768681132 0.0121539159 0.0130009524 3495.76401 atank[2]    3.0295132611  1.097786749 0.0173575326 0.0255811814 1841.59774 atank[41]   -1.8040414452  0.488303695 0.0077207593 0.0051973681 4000.00000 atank[44]   -0.3348510394  0.346054656 0.0054716045 0.0046467452 4000.00000 atank[40]    2.3463288839  0.573923956 0.0090745345 0.0101900002 3172.19822 atank[42]   -0.5694094170  0.358234605 0.0056641864 0.0046935532 4000.00000 atank[11]    1.0007489783  0.663737508 0.0104946115 0.0117422973 3195.11562 atank[16]    2.1088413933  0.872132839 0.0137896310 0.0168742768 2671.25251 atank[46]   -0.5794564306  0.362646534 0.0057339452 0.0050212654 4000.00000 atank[8]    2.0875919106  0.883745348 0.0139732409 0.0162842279 2945.23491 atank[14]    0.1964596710  0.617296433 0.0097603136 0.0075173911 4000.00000 atank[47]    2.0547681207  0.509187915 0.0080509678 0.0071101438 4000.00000 atank[43]   -0.4487646777  0.339582585 0.0053692721 0.0049577724 4000.00000 atank[24]    1.6974144465  0.541970319 0.0085693032 0.0061834892 4000.00000 atank[34]    2.6936725440  0.628597382 0.0099389973 0.0087708320 4000.00000 atank[9]   -0.1874117115  0.633287204 0.0100131499 0.0079473202 4000.00000 atank[28]   -0.4681636985  0.416090181 0.0065789634 0.0057151179 4000.00000 atank[31]   -0.6356923902  0.433795689 0.0068589121 0.0041842682 4000.00000 atank[29]    0.1624613393  0.401316555 0.0063453719 0.0046974312 4000.00000 atank[18]    2.3913830070  0.671420136 0.0106160845 0.0111601737 3619.48527 atank[1]    2.1144841871  0.873765594 0.0138154471 0.0134103108 4000.00000 atank[38]    3.8893717797  0.978631940 0.0154735296 0.0231402831 1788.55144 atank[37]    2.0558293650  0.514694473 0.0081380342 0.0071845468 4000.00000 atank[30]    1.4416152688  0.479794721 0.0075862206 0.0059017454 4000.00000 atank[35]    2.6925880675  0.651873334 0.0103070224 0.0085287006 4000.00000 atank[20]    3.6134226610  0.970193501 0.0153401062 0.0238161118 1659.49138 atank[15]    2.1272566988  0.876804950 0.0138635035 0.0199621939 1929.25417 atank[26]    0.1630585993  0.405131249 0.0064056875 0.0045865339 4000.00000 atank[45]    0.5823296893  0.349822119 0.0055311734 0.0046059843 4000.00000 atank[21]    2.3968425342  0.661596555 0.0104607600 0.0104431077 4000.00000 atank[48]    0.0030622025  0.331573461 0.0052426367 0.0038034443 4000.00000 atank[10]    2.1097053742  0.872430009 0.0137943296 0.0190694321 2093.07926 atank[3]    0.9966593638  0.662195640 0.0104702324 0.0082308854 4000.00000 atank[7]    3.0314959227  1.071425974 0.0169407321 0.0228591199 2196.87491 atank[6]    2.1263090050  0.875040776 0.0138356095 0.0138610403 3985.33589 atank[25]   -1.0097610188  0.451706567 0.0071421079 0.0056360736 4000.00000 atank[32]   -0.3105658507  0.393426518 0.0062206195 0.0047667754 4000.00000 atank[5]    2.1067240289  0.847313335 0.0133972002 0.0174789494 2349.94357 atank[13]    0.9934721312  0.673907169 0.0106554079 0.0087754899 4000.00000 atank[19]    2.0027362510  0.581472256 0.0091938836 0.0085476353 4000.00000 atank[12]    0.5757662524  0.635809034 0.0100530235 0.0078502186 4000.00000 atank[4]    3.0344422538  1.075560077 0.0170060980 0.0278349168 1493.10205 atank[17]    2.8901636458  0.786143265 0.0124300164 0.0154722829 2581.63357 atank[27]   -1.4285276117  0.504504387 0.0079769148 0.0047850541 4000.00000 atank[22]    2.3972696703  0.660728612 0.0104470366 0.0092144017 4000.00000 atank[23]    2.3939166498  0.653360543 0.0103305372 0.0085971078 4000.00000 atank[36]    2.0544595646  0.536312030 0.0084798378 0.0062225461 4000.00000 atank[39]    2.6940908508  0.641144454 0.0101373839 0.0089230656 4000.00000#Rethinking       mean   sd  5.5% 94.5% n_eff Rhata           1.30 0.25  0.90  1.70 11662    1 sigma       1.62 0.22  1.30  1.99  6556    1 atank[1]   2.12 0.88  0.84  3.60 16091    1 atank[2]   3.05 1.10  1.52  4.92 10962    1 atank[3]   1.00 0.66 -0.02  2.10 18175    1 atank[4]   3.05 1.11  1.47  4.96 10181    1 atank[5]   2.13 0.87  0.85  3.62 13720    1 atank[6]   2.12 0.86  0.86  3.59 11628    1 atank[7]   3.07 1.13  1.47  5.03 10315    1 atank[8]   2.13 0.87  0.86  3.60 13754    1 atank[9]  -0.18 0.60 -1.14  0.76 18218    1 atank[10]  2.11 0.86  0.83  3.58 15121    1 atank[11]  1.00 0.67 -0.04  2.09 17390    1 atank[12]  0.58 0.62 -0.41  1.60 17209    1 atank[13]  0.99 0.66 -0.04  2.09 15225    1 atank[14]  0.19 0.62 -0.79  1.20 18293    1 atank[15]  2.13 0.89  0.83  3.63 12445    1 atank[16]  2.11 0.87  0.87  3.61 12385    1 atank[17]  2.89 0.80  1.76  4.29 12583    1 atank[18]  2.38 0.66  1.43  3.49 14437    1 atank[19]  2.00 0.58  1.12  2.99 13959    1 atank[20]  3.67 1.03  2.20  5.44 10629    1 atank[21]  2.38 0.65  1.42  3.47 15309    1 atank[22]  2.39 0.66  1.42  3.49 13614    1 atank[23]  2.40 0.67  1.41  3.53 11868    1 atank[24]  1.69 0.52  0.90  2.55 18468    1 atank[25] -1.00 0.45 -1.74 -0.30 18153    1 atank[26]  0.16 0.40 -0.47  0.81 21895    1 atank[27] -1.44 0.50 -2.28 -0.69 16718    1 atank[28] -0.47 0.41 -1.15  0.17 20160    1 atank[29]  0.15 0.40 -0.48  0.80 19401    1 atank[30]  1.44 0.49  0.70  2.24 15407    1 atank[31] -0.64 0.42 -1.33 -0.01 15356    1 atank[32] -0.31 0.40 -0.95  0.32 19130    1 atank[33]  3.18 0.78  2.06  4.55 10894    1 atank[34]  2.70 0.66  1.75  3.84 13573    1 atank[35]  2.69 0.64  1.74  3.78 13876    1 atank[36]  2.06 0.53  1.26  2.92 16329    1 atank[37]  2.06 0.51  1.29  2.91 14672    1 atank[38]  3.88 0.97  2.52  5.57  9349    1 atank[39]  2.70 0.64  1.77  3.78 13444    1 atank[40]  2.34 0.56  1.49  3.31 14966    1 atank[41] -1.82 0.48 -2.61 -1.10 14214    1 atank[42] -0.58 0.36 -1.16 -0.02 17203    1 atank[43] -0.46 0.35 -1.02  0.08 17762    1 atank[44] -0.34 0.34 -0.90  0.20 16740    1 atank[45]  0.58 0.35  0.02  1.14 18946    1 atank[46] -0.57 0.34 -1.13 -0.03 19761    1 atank[47]  2.05 0.51  1.30  2.90 15122    1 atank[48]  0.00 0.33 -0.53  0.53 18236    1This page was generated using Literate.jl."
},

{
    "location": "12/m12_3/#",
    "page": "m12.3.jl",
    "title": "m12.3.jl",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/12/m12_3.jl\"using StatisticalRethinking\nusing Turing\n\nTuring.setadbackend(:reverse_diff)\n\nμ = 1.4\nσ = 1.5\nnponds = 60\nni = repeat([5,10,25,35], inner=15)\n\na_pond = rand(Normal(μ, σ), nponds)\n\ndsim = DataFrame(pond = 1:nponds, ni = ni, true_a = a_pond)\n\nprob = logistic.(Vector{Real}(dsim[:true_a]))\n\ndsim[:si] = [rand(Binomial(ni[i], prob[i])) for i = 1:nponds]Used only in the continuation of this exampledsim[:p_nopool] = dsim[:si] ./ dsim[:ni]\n\n@model m12_3(pond, si, ni) = beginSeparate priors on μ and σ for each pond    σ ~ Truncated(Cauchy(0, 1), 0, Inf)\n    μ ~ Normal(0, 1)Number of ponds in the data set    N_ponds = length(pond)vector for the priors for each pond    a_pond = Vector{Real}(undef, N_ponds)For each pond set a prior. Note the [] around Normal(), i.e.,    a_pond ~ [Normal(μ, σ)]Observation    logitp = [a_pond[pond[i]] for i = 1:N_ponds]\n    si ~ VecBinomialLogit(ni, logitp)\n\nend\n\nposterior = sample(m12_3(Vector{Int64}(dsim[:pond]), Vector{Int64}(dsim[:si]),\n    Vector{Int64}(dsim[:ni])), Turing.NUTS(10000, 1000, 0.8))\ndescribe(posterior)            Mean           SD        Naive SE        MCSE         ESSapond[13]    0.0177228141  0.841956449 0.0084195645 0.00771496194 10000.0000 apond[39]    0.0066110725  0.403509812 0.0040350981 0.00300378764 10000.0000 apond[12]   -0.6879306819  0.887142394 0.0088714239 0.00983038264  8144.1511 apond[33]    1.0230070658  0.440802431 0.0044080243 0.00340565683 10000.0000 apond[40]   -0.4710107332  0.397151811 0.0039715181 0.00287378746 10000.0000          μ    1.4171959646  0.247164994 0.0024716499 0.00279659983  7811.1193 apond[52]   -0.1075137501  0.334424028 0.0033442403 0.00304380214 10000.0000 apond[48]    0.2270466468  0.340522575 0.0034052258 0.00288072684 10000.0000 apond[31]   -0.3116943388  0.406497387 0.0040649739 0.00327039672 10000.0000 apond[21]   -0.5664379565  0.649981939 0.0064998194 0.00531522292 10000.0000 apond[14]   -0.6980794242  0.863848603 0.0086384860 0.00834117683 10000.0000 apond[26]    1.5157188342  0.746372296 0.0074637230 0.00689302178 10000.0000 apond[35]   -0.3104176671  0.400246807 0.0040024681 0.00351529487 10000.0000 apond[53]    2.3656224490  0.570317605 0.0057031760 0.00514104769 10000.0000 apond[45]    3.7602403329  1.040583568 0.0104058357 0.01371112136  5759.8076 apond[27]    3.1787683092  1.143238040 0.0114323804 0.01676903058  4647.9069 apond[10]    2.7440414813  1.264526612 0.0126452661 0.01600961219  6238.7032 apond[19]    3.1606479454  1.166461112 0.0116646111 0.01482980989  6186.8468 apond[58]    3.2339626006  0.791995574 0.0079199557 0.00801476020  9764.8245  apond[5]    0.7262878590  0.875745952 0.0087574595 0.00740596596 10000.0000 apond[36]    0.8278459525  0.433666591 0.0043366659 0.00340041538 10000.0000 apond[22]   -0.9954707978  0.698527821 0.0069852782 0.00639152189 10000.0000  apond[2]    1.5514073486  0.973915502 0.0097391550 0.01111824521  7673.0859 apond[59]    3.9781779304  1.018961505 0.0101896150 0.01278245028  6354.5870 apond[46]    2.0703897434  0.515233417 0.0051523342 0.00470261856 10000.0000          σ    1.6843877698  0.243610374 0.0024361037 0.00421903982  3333.9901 apond[47]    3.9862598194  1.020488268 0.0102048827 0.01240672087  6765.5329 apond[57]    2.0741920322  0.509608416 0.0050960842 0.00391260407 10000.0000 apond[23]   -0.9989820391  0.681962640 0.0068196264 0.00642167767 10000.0000 apond[51]    2.7344759539  0.649587763 0.0064958776 0.00648076189 10000.0000 apond[20]    0.5764910930  0.625086947 0.0062508695 0.00506310281 10000.0000  apond[8]    2.7496005216  1.272989569 0.0127298957 0.01733946864  5389.8679 apond[18]    3.1900259466  1.171811970 0.0117181197 0.01440863531  6614.0909 apond[54]    3.2291234955  0.784255555 0.0078425556 0.00820057334  9145.9069 apond[11]    2.7535202736  1.237297764 0.0123729776 0.01757842164  4954.3730 apond[16]    2.2007440950  0.916943320 0.0091694332 0.00992638854  8533.0137         lp -214.2598610993  7.211089559 0.0721108956 0.13728259285  2759.1215 apond[44]    1.4579671233  0.494609207 0.0049460921 0.00415623790 10000.0000  apond[7]    1.5544027763  0.979190641 0.0097919064 0.01106135909  7836.4168     lfeps    0.0806304543  0.025824042 0.0002582404 0.00087843406   864.2315 apond[50]    1.2646118079  0.396937728 0.0039693773 0.00301671654 10000.0000 apond[1]    2.7358650934  1.256841000 0.0125684100 0.01628364652  5957.4080   epsilon    0.0806304543  0.025824042 0.0002582404 0.00087843406   864.2315 apond[55]    1.6194868499  0.449848512 0.0044984851 0.00337126412 10000.0000 apond[56]    0.4636724052  0.333661394 0.0033366139 0.00317090692 10000.0000 apond[9]   -1.5582336653  1.054033998 0.0105403400 0.01325783842  6320.6799  evalnum  140.7574000000 49.461823586 0.4946182359 1.04675890947  2232.7851 apond[38]    2.4213667923  0.669981340 0.0066998134 0.00670341721  9989.2507 apond[41]    2.9441756245  0.805063431 0.0080506343 0.00777409335 10000.0000    lfnum    0.0002000000  0.020000000 0.0002000000 0.00020000000 10000.0000 apond[42]    1.0189318364  0.450896154 0.0045089615 0.00353871779 10000.0000 apond[6]    0.7172274132  0.875913940 0.0087591394 0.00921226138  9040.4568 apond[37]    1.2311086658  0.467581916 0.0046758192 0.00370489273 10000.0000 apond[17]    2.1840208942  0.885232595 0.0088523259 0.01005752459  7746.9827 apond[34]    3.7647116451  1.070577317 0.0107057732 0.01454992135  5413.9568 apond[25]    0.1983088389  0.595635693 0.0059563569 0.00423421680 10000.0000 apond[49]    3.2308198064  0.783408432 0.0078340843 0.00741996001 10000.0000 apond[29]    0.5869977398  0.641031578 0.0064103158 0.00596687017 10000.0000   elapsed    0.2124224895  0.091334338 0.0009133434 0.00277238819  1085.3257 apond[3]    2.7351595176  1.252877992 0.0125287799 0.01650408216  5762.8167 apond[43]    1.4589068954  0.502713246 0.0050271325 0.00419773751 10000.0000 apond[4]   -0.6955128978  0.886643420 0.0088664342 0.00892026440  9879.6722 apond[28]    3.1799658392  1.190210605 0.0119021061 0.01598221933  5545.9182 apond[15]    1.5668531946  1.015083021 0.0101508302 0.01066654407  9056.4014 apond[24]    1.0178669471  0.671538554 0.0067153855 0.00534254055 10000.0000 apond[32]    0.4829825423  0.408095990 0.0040809599 0.00290615908 10000.0000 apond[30]    2.1782787743  0.892245915 0.0089224591 0.00878540719 10000.0000 apond[60]    2.7321739924  0.664559051 0.0066455905 0.00632100816 10000.0000 Rethinking             mean   sd  5.5% 94.5% neff Rhat a           1.30 0.23  0.94  1.67  8064    1 sigma       1.55 0.21  1.24  1.92  3839    1 apond[1]   2.57 1.17  0.85  4.57  9688    1 apond[2]   2.58 1.19  0.83  4.56  9902    1 apond[3]   2.56 1.16  0.84  4.57 12841    1 apond[4]   1.49 0.92  0.12  3.03 15532    1 apond[5]   1.51 0.95  0.07  3.09 14539    1 apond[6]   0.72 0.84 -0.59  2.08 13607    1 apond[7]   2.56 1.16  0.86  4.51 12204    1 apond[8]   1.50 0.93  0.07  3.05 19903    1 apond[9]   2.56 1.15  0.86  4.51 11054    1 apond[10]  1.49 0.95  0.05  3.09 14134    1 apond[11] -0.64 0.86 -2.06  0.70 15408    1 apond[12]  2.56 1.16  0.86  4.53 11512    1 apond[13]  1.49 0.95  0.05  3.10 16270    1 apond[14]  0.71 0.84 -0.59  2.07 17077    1 apond[15]  1.50 0.93  0.10  3.05 16996    1 apond[16]  2.98 1.07  1.45  4.84  9033    1 apond[17]  2.09 0.84  0.85  3.54 14636    1 apond[18]  1.01 0.66  0.00  2.10 12971    1 apond[19]  1.01 0.68 -0.03  2.13 12598    1 apond[20]  1.48 0.72  0.38  2.67 15500    1 apond[21]  2.96 1.09  1.42  4.87 11204    1 apond[22] -2.04 0.87 -3.53 -0.75  9065    1 apond[23]  0.99 0.67 -0.04  2.11 15365    1 apond[24]  1.48 0.72  0.41  2.67 14879    1 apond[25]  2.10 0.85  0.85  3.53 13298    1 apond[26]  1.00 0.65  0.01  2.06 18583    1 apond[27]  3.00 1.08  1.44  4.86  9312    1 apond[28]  0.98 0.66 -0.03  2.09 14703    1 apond[29]  0.21 0.61 -0.76  1.19 15554    1 apond[30]  2.95 1.05  1.45  4.73  9816    1 apond[31]  1.70 0.53  0.89  2.59 19148    1 apond[32]  0.82 0.42  0.17  1.51 13556    1 apond[33]  0.32 0.40 -0.33  0.96 19388    1 apond[34] -0.15 0.40 -0.79  0.48 18684    1 apond[35]  3.57 0.98  2.19  5.26  8769    1 apond[36]  0.16 0.40 -0.46  0.80 17595    1 apond[37]  2.00 0.58  1.13  2.99 14669    1 apond[38] -1.41 0.49 -2.22 -0.65 12957    1 apond[39]  1.21 0.46  0.49  1.97 14185    1 apond[40] -1.18 0.46 -1.95 -0.48 16142    1 apond[41]  2.86 0.78  1.73  4.18 10508    1 apond[42]  0.00 0.39 -0.61  0.63 16138    1 apond[43]  1.43 0.48  0.70  2.24 17100    1 apond[44]  2.86 0.77  1.75  4.15 12002    1 apond[45] -1.40 0.49 -2.21 -0.66 14292    1 apond[46]  0.12 0.33 -0.40  0.66 20425    1 apond[47] -0.56 0.36 -1.14  0.00 18981    1 apond[48]  1.11 0.38  0.52  1.73 14176    1 apond[49]  3.81 0.95  2.47  5.45  8841    1 apond[50]  2.05 0.50  1.31  2.88 15898    1 apond[51] -1.40 0.41 -2.08 -0.76 17188    1 apond[52] -0.11 0.34 -0.65  0.43 17158    1 apond[53]  1.61 0.44  0.94  2.36 15132    1 apond[54]  2.05 0.50  1.30  2.89 15799    1 apond[55]  3.14 0.75  2.08  4.40 12702    1 apond[56]  3.13 0.74  2.07  4.41 11143    1 apond[57]  1.26 0.40  0.65  1.92 14587    1 apond[58]  1.11 0.38  0.51  1.74 21740    1 apond[59]  2.33 0.56  1.50  3.25 13116    1 apond[60]  1.27 0.40  0.66  1.91 15611    1           Mean          SD        Naive SE        MCSE         ESS\n     α   -1.43756402  0.167281208 0.0016728121 0.00210877863  6292.63192\n     σ    0.94572510  0.159509660 0.0015950966 0.00292977115  2964.19373apond[13]   -0.96409032  0.695682000 0.0069568200 0.00712009032  9546.63960 apond[39]   -2.16432055  0.560230451 0.0056023045 0.00401929327 10000.00000 apond[12]   -0.98211221  0.700132015 0.0070013202 0.00719599345  9466.25839 apond[33]   -1.89716948  0.507094638 0.0050709464 0.00393759633 10000.00000 apond[40]   -2.15927404  0.553498230 0.0055349823 0.00525989968 10000.00000 apond[52]   -1.95778572  0.468392293 0.0046839229 0.00295136724 10000.00000 apond[48]   -2.17567314  0.487971067 0.0048797107 0.00325138185 10000.00000 apond[31]   -1.65553570  0.479752516 0.0047975252 0.00309756598 10000.00000 apond[21]   -1.46693217  0.634848584 0.0063484858 0.00548329380 10000.00000 apond[14]   -0.51655733  0.697560885 0.0069756089 0.00693184327 10000.00000 apond[26]   -1.11415242  0.579221588 0.0057922159 0.00497058099 10000.00000 apond[35]   -2.16959658  0.546408662 0.0054640866 0.00487151680 10000.00000 apond[53]   -2.17290466  0.499898730 0.0049989873 0.00381882101 10000.00000 apond[45]   -1.65831075  0.475684574 0.0047568457 0.00282288126 10000.00000 apond[27]   -1.47390856  0.625904201 0.0062590420 0.00597555549 10000.00000 apond[10]   -0.06470584  0.709512539 0.0070951254 0.00810899930  7655.71265 apond[19]   -1.47611448  0.619367365 0.0061936736 0.00573498517 10000.00000 apond[58]   -1.96067155  0.471148496 0.0047114850 0.00310756256 10000.00000  apond[5]   -0.51301911  0.693083568 0.0069308357 0.00766059211  8185.52478 apond[36]   -2.16398901  0.552362190 0.0055236219 0.00423015168 10000.00000 apond[22]   -0.79183001  0.562682452 0.0056268245 0.00395177756 10000.00000  apond[2]   -0.07065260  0.723388535 0.0072338853 0.00837009596  7469.34241 apond[59]   -3.04846657  0.659338141 0.0065933814 0.00767658576  7377.00686 apond[46]   -2.41950226  0.530010130 0.0053001013 0.00447275751 10000.00000 apond[47]   -2.41940262  0.529600266 0.0052960027 0.00495650076 10000.00000 apond[57]   -2.42196906  0.545199651 0.0054519965 0.00421172829 10000.00000 apond[23]   -1.47836307  0.626164879 0.0062616488 0.00546703424 10000.00000 apond[51]   -1.95865755  0.453931725 0.0045393173 0.00323782050 10000.00000 apond[20]   -1.87882953  0.685389064 0.0068538906 0.00691600262  9821.18842  apond[8]   -0.51278872  0.698168747 0.0069816875 0.00674015806 10000.00000 apond[18]   -0.79464713  0.570683666 0.0057068367 0.00517526089 10000.00000 apond[54]   -2.17663143  0.486692179 0.0048669218 0.00357970522 10000.00000 apond[11]   -0.52002272  0.700422488 0.0070042249 0.00758407273  8529.33523 apond[16]   -2.35154693  0.748462872 0.0074846287 0.01009234165  5499.92332 apond[44]   -2.16190756  0.555077841 0.0055507784 0.00464353670 10000.00000  apond[7]   -0.07294353  0.722895184 0.0072289518 0.00933609743  5995.42414 apond[50]   -1.76719334  0.433238573 0.0043323857 0.00301606024 10000.00000  apond[1]   -0.07479566  0.715498813 0.0071549881 0.00821909124  7578.27275 apond[55]   -1.95861084  0.462566383 0.0046256638 0.00326122131 10000.00000 apond[56]   -1.95767294  0.451852167 0.0045185217 0.00336244216 10000.00000  apond[9]   -0.97174862  0.706466469 0.0070646647 0.00685957974 10000.00000 apond[38]   -1.65719327  0.477253975 0.0047725397 0.00357994187 10000.00000 apond[41]   -2.47295206  0.610429423 0.0061042942 0.00555558551 10000.00000 apond[42]   -1.65879054  0.487850118 0.0048785012 0.00420032610 10000.00000  apond[6]   -0.51322197  0.699819483 0.0069981948 0.00837828549  6976.88795 apond[37]   -1.89163219  0.514164120 0.0051416412 0.00396572368 10000.00000 apond[17]   -0.48373615  0.562778997 0.0056277900 0.00445855972 10000.00000 apond[34]   -1.89391017  0.517579732 0.0051757973 0.00449881473 10000.00000 apond[25]   -0.48483903  0.564804766 0.0056480477 0.00432604358 10000.00000 apond[49]   -1.95877851  0.456040949 0.0045604095 0.00251026103 10000.00000 apond[29]   -1.47041681  0.615401982 0.0061540198 0.00516784541 10000.00000  apond[3]   -0.52147126  0.688164420 0.0068816442 0.00702386169  9599.14444 apond[43]   -1.65667827  0.476433792 0.0047643379 0.00374622975 10000.00000  apond[4]   -0.97038449  0.704920197 0.0070492020 0.00798856637  7786.49863 apond[28]   -1.11670032  0.594046332 0.0059404633 0.00481138686 10000.00000 apond[15]   -0.97643818  0.702064283 0.0070206428 0.00627008271 10000.00000 apond[24]   -0.78700355  0.580971213 0.0058097121 0.00463692344 10000.00000 apond[32]   -1.66143918  0.481944799 0.0048194480 0.00375554807 10000.00000 apond[30]   -0.79075103  0.573147275 0.0057314727 0.00550557273 10000.00000 apond[60]   -2.17672820  0.503739378 0.0050373938 0.00376315154 10000.00000This page was generated using Literate.jl."
},

]}
