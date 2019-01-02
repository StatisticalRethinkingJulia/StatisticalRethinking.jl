var documenterSearchIndex = {"docs": [

{
    "location": "intro/#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "intro/#StatisticalRethinking-1",
    "page": "Home",
    "title": "StatisticalRethinking",
    "category": "section",
    "text": "This package will contain Julia versions of selected code snippets contained in the R package \"rethinking\" associated with the book Statistical Rethinking by Richard McElreath.In the book and associated R package rethinking, statistical models are defined as illustrated below:m4.3 <- map(\n    alist(\n        height ~ dnorm( mu , sigma ) ,\n        mu <- a + b*weight ,\n        a ~ dnorm( 156 , 100 ) ,\n        b ~ dnorm( 0 , 10 ) ,\n        sigma ~ dunif( 0 , 50 )\n    ) ,\n    data=d2\n)The author of the book states: \"If that (the statistical model) doesn\'t make much sense, good. ... you\'re holding the right textbook, since this book teaches you how to read and write these mathematical descriptions\"  (page 77).This package is intended to allow experimenting with this learning process using 3 available mcmc options in Julia."
},

{
    "location": "layout/#",
    "page": "Layout",
    "title": "Layout",
    "category": "page",
    "text": ""
},

{
    "location": "layout/#Layout-of-the-package-1",
    "page": "Layout",
    "title": "Layout of the package",
    "category": "section",
    "text": "Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:clip_01_03.jl - contains snippets 0.1 through 0.3\nclip_04_05.jl - contains snippets 0.4 and 0.5.These 2 files are in chapters/00. These files are later on processed by Literate.jl to create 2 derived versions, e.g. from clip_01_03.jl in chapters/00:clip_01_03.md - included in the documentation\nclip_01_03.ipynb - stored in the notebooks directory for use in JupyterOccasionally a clip will contain just a single snippet and will be referred to as 03/clip_02.jl. Clips with names such as 02/clip_08t.jl, clip_08s.jl and clip_08m.jl contain mcmc implementations using Turing.jl, CmdStan.jl and Mamba.jl respectively. Examples have been added to chapter 2.From chapter 8 onwards, the Turing versions of the mcmc models are available as e.g. chapters/08/m8.1t.jl. Equivalent CmdStan versions and, in a few cases Mamba models, are provided as well.Almost identical clips are named e.g. 04/clip_07.0s.jl and 04/clip_07.1s.jl. In that specific example just the priors differ."
},

{
    "location": "acknowledgements/#",
    "page": "Acknowledgements",
    "title": "Acknowledgements",
    "category": "page",
    "text": ""
},

{
    "location": "acknowledgements/#Acknowledgements-1",
    "page": "Acknowledgements",
    "title": "Acknowledgements",
    "category": "section",
    "text": "Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8.The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer have been a great help and followed closely in several example scripts.The mcmc components are based on:TuringLang\nStanJulia\nMambaAt least 2 other mcmc options are available for mcmc in Julia:DynamicHMC\nKlaraTime constraints prevents inclusion of those right now, although e.g. the example chapters/04/clip_38.1m.jl almost begs for a clip_38d.jl. For now the linear regression example in  DynamicHMCExamples is a good starting point.The Mamba examples should really use @everywhere using Mamba in stead of using Mamba. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode.The  documentation has been generated using Literate.jl based on several ideas demonstrated by Tamas Papp in above mentioned  DynamicHMCExamples.jl."
},

{
    "location": "references/#",
    "page": "References",
    "title": "References",
    "category": "page",
    "text": ""
},

{
    "location": "references/#References-1",
    "page": "References",
    "title": "References",
    "category": "section",
    "text": "There is no shortage of good books on Bayesian statistics. A few of my favorites are:Bolstad: Introduction to Bayesian statistics\nBolstad: Understanding Computational Bayesian Statistics\nGelman, Hill: Data Analysis using regression and multileve,/hierachical models\nMcElreath: Statistical Rethinking\nGelman, Carlin, and others: Bayesian Data Analysis\nLee, Wagenmakers: Bayesian Cognitive Modeling\nKruschke:Doing Bayesian Data Analysisand a great read (and implementation in DynamicHMC.jl):Betancourt: A Conceptual Introduction to Hamiltonian Monte Carlo"
},

{
    "location": "00/clip-01-03/#",
    "page": "clip-01-03",
    "title": "clip-01-03",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/00/clip-01-03.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking"
},

{
    "location": "00/clip-01-03/#snippet-0.1-1",
    "page": "clip-01-03",
    "title": "snippet 0.1",
    "category": "section",
    "text": "println( \"All models are wrong, but some are useful.\" );"
},

{
    "location": "00/clip-01-03/#snippet-0.2-1",
    "page": "clip-01-03",
    "title": "snippet 0.2",
    "category": "section",
    "text": "This is a StepRange, not a vectorx = 1:3Below still preserves the StepRangex = x*10Broadcast log to steprange elements in x, this returms a vector! Notice the log.(x) notation.x = log.(x)We can sum the vector xx = sum(x)Etc.x = exp(x)\nx = x*10\nx = log(x)\nx = sum(x)\nx = exp(x)"
},

{
    "location": "00/clip-01-03/#snippet-0.3-1",
    "page": "clip-01-03",
    "title": "snippet 0.3",
    "category": "section",
    "text": "[log(0.01^200) 200 * log(0.01)]This page was generated using Literate.jl."
},

{
    "location": "00/clip-04-05/#",
    "page": "clip-04-05",
    "title": "clip-04-05",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/00/clip-04-05.jl\"Load Julia packages (libraries) needed"
},

{
    "location": "00/clip-04-05/#snippet-0.5-is-replaced-by-below-using-StatisticalRethinking.-1",
    "page": "clip-04-05",
    "title": "snippet 0.5 is replaced by below using StatisticalRethinking.",
    "category": "section",
    "text": "using StatisticalRethinking, GLM\ngr(size=(500, 500));"
},

{
    "location": "00/clip-04-05/#snippet-0.4-1",
    "page": "clip-04-05",
    "title": "snippet 0.4",
    "category": "section",
    "text": "Below dataset(...) provides access to often used R datasets.cars = dataset(\"datasets\", \"cars\")If this is not a common R dataset, use e.g.: howell1 = CSV.read(joinpath(ProjDir, \"..\", \"..\",  \"data\", \"Howell1.csv\"), delim=\';\') df = convert(DataFrame, howell1)This reads the Howell1.csv dataset in the data subdirectory of this package,  StatisticalRethinking.jl. See also the chapter 4 snippets.Fit a linear regression of distance on speedm = lm(@formula(Dist ~ Speed), cars)estimated coefficients from the modelcoef(m)Plot residuals against speedscatter( cars[:Speed], residuals(m),\n  xlab=\"Speed\", ylab=\"Model residual values\", lab=\"Model residuals\")End of clip_04_05.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-01-02/#",
    "page": "clip-01-02",
    "title": "clip-01-02",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip-01-02.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking"
},

{
    "location": "02/clip-01-02/#snippet-2.1-1",
    "page": "clip-01-02",
    "title": "snippet 2.1",
    "category": "section",
    "text": "ways  = [0, 3, 8, 9, 0]ways/sum(ways)"
},

{
    "location": "02/clip-01-02/#snippet-2.2-1",
    "page": "clip-01-02",
    "title": "snippet 2.2",
    "category": "section",
    "text": "Create a distribution with n = 9 (e.g. tosses) and p = 0.5.d = Binomial(9, 0.5)Probability density for 6 waters holding n = 9 and p = 0.5.pdf(d, 6)End of clip_01_02.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-03-05/#",
    "page": "clip-03-05",
    "title": "clip-03-05",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip-03-05.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300));"
},

{
    "location": "02/clip-03-05/#snippet-2.3-1",
    "page": "clip-03-05",
    "title": "snippet 2.3",
    "category": "section",
    "text": "Define a gridN = 20\np_grid = range( 0 , stop=1 , length=N )Define the (uniform) priorprior = ones( 20 );Compute likelihood at each value in gridlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]Compute product of likelihood and priorunstd_posterior = likelihood .* prior;Standardize the posterior, so it sums to 1posterior = unstd_posterior  ./ sum(unstd_posterior);"
},

{
    "location": "02/clip-03-05/#snippet-2.4-1",
    "page": "clip-03-05",
    "title": "snippet 2.4",
    "category": "section",
    "text": "p1 = plot( p_grid , posterior ,\n    xlab=\"probability of water\" , ylab=\"posterior probability\",\n    lab = \"interpolated\", title=\"20 points\" )\np2 = scatter!( p1, p_grid , posterior, lab=\"computed\" )"
},

{
    "location": "02/clip-03-05/#snippet-2.5-1",
    "page": "clip-03-05",
    "title": "snippet 2.5",
    "category": "section",
    "text": "prior1 = [p < 0.5 ? 0 : 1 for p in p_grid]\nprior2 = [exp( -5*abs( p - 0.5 ) ) for p in p_grid]\n\np3 = plot(p_grid, prior1,\n  xlab=\"probability of water\" , ylab=\"posterior probability\",\n  lab = \"semi_uniform\", title=\"Other priors\" )\nscatter!(p3, p_grid, prior1, lab = \"semi_uniform grid point\")\nplot!(p3, p_grid, prior2,  lab = \"double_exponential\" )\nscatter!(p3, p_grid, prior2,  lab = \"double_exponential grid point\" )End of clip_03_05.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-06-07/#",
    "page": "clip-06-07",
    "title": "clip-06-07",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip-06-07.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300));"
},

{
    "location": "02/clip-06-07/#snippet-2.6-(see-snippet-3_2-for-explanations)-1",
    "page": "clip-06-07",
    "title": "snippet 2.6 (see snippet 3_2 for explanations)",
    "category": "section",
    "text": "p_grid = range(0, step=0.001, stop=1)\nprior = ones(length(p_grid))\nlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]\nposterior = likelihood .* prior\nposterior = posterior / sum(posterior)\nsamples = sample(p_grid, Weights(posterior), length(p_grid))\n\np = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")\nplot(p..., layout=(1, 2))"
},

{
    "location": "02/clip-06-07/#snippet-2.7-1",
    "page": "clip-06-07",
    "title": "snippet 2.7",
    "category": "section",
    "text": "analytical calculationw = 6; n = 9; x = 0:0.01:1\nscatter( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationscatter!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")End of clip_06_07.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-08m/#",
    "page": "clip-08m",
    "title": "clip-08m",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip-08m.jl\"using Distributed, Gadfly\nusing MambaDataglobe_toss = Dict{Symbol, Any}(\n  :w => [6, 7, 5, 6, 6],\n  :n => [9, 9, 9, 9, 9]\n)\nglobe_toss[:N] = length(globe_toss[:w]);Model Specificationmodel = Model(\n  w = Stochastic(1,\n    (n, p, N) ->\n      UnivariateDistribution[Binomial(n[i], p) for i in 1:N],\n    false\n  ),\n  p = Stochastic(() -> Beta(1, 1))\n);Initial Valuesinits = [\n  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => 0.5),\n  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => rand(Beta(1, 1)))\n];Sampling Schemescheme = [NUTS(:p)]\nsetsamplers!(model, scheme);MCMC Simulationssim = mcmc(model, globe_toss, inits, 10000, burnin=2500, thin=1, chains=2)Describe drawsdescribe(sim)End of clip_08m.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-08s/#",
    "page": "clip-08s",
    "title": "clip-08s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip-08s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,800));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"02\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4^2\nd = Binomial(9, 0.66)\nn2 = Int.(9 * ones(Int, N2));Show (generated) observationsk2 = rand(d, N2)Input data for cmdstanbinomialdata = [\n  Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Allocate array of Normal fitsfits = Vector{Normal{Float64}}(undef, 4)\nfor i in 1:4\n  fits[i] = fit_mle(Normal, convert.(Float64, chn.value[:, 1, i]))\n  println(fits[i])\nendPlot the 4 chainsif rc == 0\n  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\n  x = 0:0.001:1\n  for i in 1:4\n    vals = convert.(Float64, chn.value[:, 1, i])\n    μ = round(fits[i].μ, digits=2)\n    σ = round(fits[i].σ, digits=2)\n    p[i] = density(vals, lab=\"Chain $i density\",\n       xlim=(0.45, 1.0), title=\"$(N2) data points\")\n    plot!(p[i], x, pdf.(Normal(fits[i].μ, fits[i].σ), x), lab=\"Fitted Normal($μ, $σ)\")\n  end\n  plot(p..., layout=(4, 1))\nendEnd of clip_08s.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-08t/#",
    "page": "clip-08t",
    "title": "clip-08t",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip-08t.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\nusing StatsFuns, Optim, Turing, Flux.Tracker\ngr(size=(600,300));\n\nTuring.setadbackend(:reverse_diff)"
},

{
    "location": "02/clip-08t/#snippet-2.8t-1",
    "page": "clip-08t",
    "title": "snippet 2.8t",
    "category": "section",
    "text": "Define the datak = 6; n = 9;Define the model@model globe_toss(n, k) = begin\n  theta ~ Beta(1, 1) # prior\n  k ~ Binomial(n, theta) # model\n  return k, theta\nend;Compute the \"maximumaposteriori\" valueSet search boundslb = [0.0]; ub = [1.0];Create (compile) the modelmodel = globe_toss(n, k);Compute the maximumaposterioriresult = maximum_a_posteriori(model, lb, ub)Use Turing mcmcTuring.turnprogress(false)\nchn = sample(model, NUTS(2000, 1000, 0.65));Look at the generated draws (in chn)describe(chn)Look at the mean and sdprintln(\"\\ntheta = $(mean_and_std(chn[:theta][1001:2000]))\\n\")Compute at hpd regionbnds = MCMCChain.hpd(chn[:theta], alpha=0.06);analytical calculationw = 6; n = 9; x = 0:0.01:1\nplot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab=\"Conjugate solution\")quadratic approximationplot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")Turing Chain &  89%hpd region boundariesdensity!(chn[:theta], lab=\"Turing chain\")\nvline!([bnds[1]], line=:dash, lab=\"hpd lower bound\")\nvline!([bnds[2]], line=:dash, lab=\"hpd upper bound\")Show hpd regionprintln(\"hpd bounds = $bnds\\n\")End of clip_08t.jlThis page was generated using Literate.jl."
},

{
    "location": "03/clip-01/#",
    "page": "clip-01",
    "title": "clip-01",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip-01.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300))"
},

{
    "location": "03/clip-01/#snippet-3.1-1",
    "page": "clip-01",
    "title": "snippet 3.1",
    "category": "section",
    "text": "PrPV = 0.95\nPrPM = 0.01\nPrV = 0.001\nPrP = PrPV*PrV + PrPM*(1-PrV)\nPrVP = PrPV*PrV / PrPEnd of clip_01.jlThis page was generated using Literate.jl."
},

{
    "location": "03/clip-02-05/#",
    "page": "clip-02-05",
    "title": "clip-02-05",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip-02-05.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300))"
},

{
    "location": "03/clip-02-05/#snippet-3.2-1",
    "page": "clip-02-05",
    "title": "snippet 3.2",
    "category": "section",
    "text": "Grid of 1001 stepsp_grid = range(0, step=0.001, stop=1)all priors = 1.0prior = ones(length(p_grid));Binomial pdflikelihood = [pdf(Binomial(9, p), 6) for p in p_grid];As Uniform priar has been used, unstandardized posterior is equal to likelihoodposterior = likelihood .* prior;Scale posterior such that they become probabilitiesposterior = posterior / sum(posterior)"
},

{
    "location": "03/clip-02-05/#snippet-3.3-1",
    "page": "clip-02-05",
    "title": "snippet 3.3",
    "category": "section",
    "text": "Sample using the computed posterior values as weightsIn this example we keep the number of samples equal to the length of p_grid, but that is not required.N = 10000\nsamples = sample(p_grid, Weights(posterior), N)\nfitnormal= fit_mle(Normal, samples)"
},

{
    "location": "03/clip-02-05/#snippet-3.4-1",
    "page": "clip-02-05",
    "title": "snippet 3.4",
    "category": "section",
    "text": "Create a vector to hold the plots so we can later combine themp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:N, samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")"
},

{
    "location": "03/clip-02-05/#snippet-3.5-1",
    "page": "clip-02-05",
    "title": "snippet 3.5",
    "category": "section",
    "text": "Analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")Add quadratic approximationplot!( p[2], x, pdf.(Normal( fitnormal.μ, fitnormal.σ ) , x ), lab=\"Normal approximation\")\nplot(p..., layout=(1, 2))End of clip_02_05.jlThis page was generated using Literate.jl."
},

{
    "location": "03/clip-05s/#",
    "page": "clip-05s",
    "title": "clip-05s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip-05s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,800));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"03\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4^2\nd = Binomial(9, 0.66)\nn2 = Int.(9 * ones(Int, N2))\nk2 = rand(d, N2);Input data for cmdstanbinomialdata = [\n  Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the 4 chainsif rc == 0\n  plot(chn)\nendEnd of clip_05s.jlThis page was generated using Literate.jl."
},

{
    "location": "03/clip-06-16s/#",
    "page": "clip-06-16s",
    "title": "clip-06-16s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip-06-16s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"03\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4\nn2 = Int.(9 * ones(Int, N2))\nk2 = [6, 5, 7, 6]Input data for cmdstanbinomialdata = [\n  Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Look at area of hpdMCMCChain.hpd(chn)Plot the 4 chainsif rc == 0\n  mixeddensity(chn, xlab=\"height [cm]\", ylab=\"density\")\n  bnds = MCMCChain.hpd(convert(Vector{Float64}, chn.value[:,1,1]))\n  vline!([bnds[1]], line=:dash)\n  vline!([bnds[2]], line=:dash)\nendEnd of clip_06_16s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-01-06/#",
    "page": "clip-01-06",
    "title": "clip-01-06",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip-01-06.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300));"
},

{
    "location": "04/clip-01-06/#snippet-4.1-1",
    "page": "clip-01-06",
    "title": "snippet 4.1",
    "category": "section",
    "text": "No attempt has been made to condense this too fewer lines of codenoofsteps = 20;\nnoofwalks = 15;\npos = Array{Float64, 2}(rand(Uniform(-1, 1), noofsteps, noofwalks));\npos[1, :] = zeros(noofwalks);\ncsum = cumsum(pos, dims=1);\n\nf = Plots.font(\"DejaVu Sans\", 6)\nmx = minimum(csum) * 0.9Plot and annotate the random walksp1 = plot(csum, leg=false, title=\"Random walks ($(noofwalks))\")\nplot!(p1, csum[:, Int(floor(noofwalks/2))], leg=false, title=\"Random walks ($(noofwalks))\", color=:black)\nplot!(p1, [5], seriestype=\"vline\")\nannotate!(5, mx, text(\"step 4\", f, :left))\nplot!(p1, [9], seriestype=\"vline\")\nannotate!(9, mx, text(\"step 8\", f, :left))\nplot!(p1, [17], seriestype=\"vline\")\nannotate!(17, mx, text(\"step 16\", f, :left))Generate 3 plots of densities at 3 different step numbers (4, 8 and 16)p2 = Vector{Plots.Plot{Plots.GRBackend}}(undef, 3);\nplt = 1\nfor step in [4, 8, 16]\n  indx = step + 1 # We aadded the first line of zeros\n  global plt\n  fit = fit_mle(Normal, csum[indx, :])\n  x = (fit.μ-4*fit.σ):0.01:(fit.μ+4*fit.σ)\n  p2[plt] = density(csum[indx, :], legend=false, title=\"$(step) steps\")\n  plot!( p2[plt], x, pdf.(Normal( fit.μ , fit.σ ) , x ), fill=(0, .5,:orange))\n  plt += 1\nend\np3 = plot(p2..., layout=(1, 3))\n\nplot(p1, p3, layout=(2,1))"
},

{
    "location": "04/clip-01-06/#snippet-4.2-1",
    "page": "clip-01-06",
    "title": "snippet 4.2",
    "category": "section",
    "text": "prod(1 .+ rand(Uniform(0, 0.1), 10))"
},

{
    "location": "04/clip-01-06/#snippet-4.3-1",
    "page": "clip-01-06",
    "title": "snippet 4.3",
    "category": "section",
    "text": "growth = [prod(1 .+ rand(Uniform(0, 0.1), 10)) for i in 1:10000];\nfit = fit_mle(Normal, growth)\nplot(Normal(fit.μ , fit.σ ), fill=(0, .5,:orange), lab=\"Normal distribution\")\ndensity!(growth, lab=\"\'sample\' distribution\")"
},

{
    "location": "04/clip-01-06/#snippet-4.4-1",
    "page": "clip-01-06",
    "title": "snippet 4.4",
    "category": "section",
    "text": "big = [prod(1 .+ rand(Uniform(0, 0.5), 12)) for i in 1:10000];\nsmall = [prod(1 .+ rand(Uniform(0, 0.01), 12)) for i in 1:10000];\nfitb = fit_mle(Normal, big)\nfits = fit_mle(Normal, small)\np1 = plot(Normal(fitb.μ , fitb.σ ), lab=\"Big normal distribution\", fill=(0, .5,:orange))\np2 = plot(Normal(fits.μ , fits.σ ), lab=\"Small normal distribution\", fill=(0, .5,:orange))\ndensity!(p1, big, lab=\"\'big\' distribution\")\ndensity!(p2, small, lab=\"\'small\' distribution\")\nplot(p1, p2, layout=(1, 2))"
},

{
    "location": "04/clip-01-06/#snippet-4.5-1",
    "page": "clip-01-06",
    "title": "snippet 4.5",
    "category": "section",
    "text": "log_big = [log(prod(1 .+ rand(Uniform(0, 0.5), 12))) for i in 1:10000];\nfit = fit_mle(Normal, log_big)\nplot(Normal(fit.μ , fit.σ ), fill=(0, .5,:orange), lab=\"Normal distribution\")\ndensity!(log_big, lab=\"\'sample\' distribution\")"
},

{
    "location": "04/clip-01-06/#snippet-4.6-1",
    "page": "clip-01-06",
    "title": "snippet 4.6",
    "category": "section",
    "text": "Grid of 1001 stepsp_grid = range(0, step=0.001, stop=1);all priors = 1.0prior = ones(length(p_grid));Binomial pdflikelihood = [pdf(Binomial(9, p), 6) for p in p_grid];As Uniform priar has been used, unstandardized posterior is equal to likelihoodposterior = likelihood .* prior;Scale posterior such that they become probabilitiesposterior = posterior / sum(posterior);Sample using the computed posterior values as weights In this example we keep the number of samples equal to the length of p_grid, but that is not required.samples = sample(p_grid, Weights(posterior), length(p_grid));\np = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\", fill=(0, .5,:orange))\nplot(p..., layout=(1, 2))End of clip_01_06.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-07.0s/#",
    "page": "clip-07.0s",
    "title": "clip-07.0s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip-07.0s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-07.0s/#snippet-4.7-1",
    "page": "clip-07.0s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)\nfemale_df = filter(row -> row[:male] == 0, df2)\nmale_df = filter(row -> row[:male] == 1, df2)Plot the densities.density(df2[:height], lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")Is it bi-modal?density!(female_df[:height], lab=\"Female heights\")\ndensity!(male_df[:height], lab=\"Male heights\")Define the Stan language modelheightsmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  real<lower=0> h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=0,upper=250> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ normal(178, 20);\n  sigma ~ uniform( 0 , 50 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the density of posterior drawsdensity(chn, lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")End of clip_07.0s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-38.0m/#",
    "page": "clip-38.0m",
    "title": "clip-38.0m",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip-38.0m.jl\"using StatisticalRethinking, Distributed, JLD\nusing Mamba\n\n# Data\nline = Dict{Symbol, Any}()\n\nhowell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);\nline[:x] = convert(Array{Float64,1}, df2[:weight]);\nline[:y] = convert(Array{Float64,1}, df2[:height]);\nline[:xmat] = convert(Array{Float64,2}, [ones(length(line[:x])) line[:x]])\n\n# Model Specification\nmodel = Model(\n  y = Stochastic(1,\n    (xmat, beta, s2) -> MvNormal(xmat * beta, sqrt(s2)),\n    false\n  ),\n  beta = Stochastic(1, () -> MvNormal([178, 0], [sqrt(10000), sqrt(100)])),\n  s2 = Stochastic(() -> Uniform(0, 50))\n)\n\n# Initial Values\ninits = [\n  Dict{Symbol, Any}(\n    :y => line[:y],\n    :beta => [rand(Normal(178, 100)), rand(Normal(0, 10))],\n    :s2 => rand(Uniform(0, 50))\n  )\n  for i in 1:3\n]\n\n# Tuning Parameters\nscale1 = [0.5, 0.25]\nsummary1 = identity\neps1 = 0.5\n\nscale2 = 0.5\nsummary2 = x -> [mean(x); sqrt(var(x))]\neps2 = 0.1\n\n# Define sampling scheme\n\nscheme = [\n  Mamba.NUTS([:beta]),\n  Mamba.Slice([:s2], 10)\n]\n\nsetsamplers!(model, scheme)\n\n# MCMC Simulation\n\nsim = mcmc(model, line, inits, 10000, burnin=1000, chains=3)Show draws summarydescribe(sim)End of clip_38.0m.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-38.0s/#",
    "page": "clip-38.0s",
    "title": "clip-38.0s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip-38.0s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-38.0s/#snippet-4.38-1",
    "page": "clip-38.0s",
    "title": "snippet 4.38",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Compare with a previous resultclip_38s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean         SD       Naive SE       MCSE     ESS\nalpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000\n beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000\nsigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750\n beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574\nsigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417\n\n\";Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = 30.0:0.1:65.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df2[:weight], df2[:height], lab=\"Observations\",\n  xlab=\"weight [kg]\", ylab=\"height [cm]\")\nplot!(xi, yi, lab=\"Regression line\")End of clip_38.0s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-38.7s/#",
    "page": "clip-38.7s",
    "title": "clip-38.7s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip-38.7s.jl\""
},

{
    "location": "04/clip-38.7s/#Linear-Regression-1",
    "page": "clip-38.7s",
    "title": "Linear Regression",
    "category": "section",
    "text": ""
},

{
    "location": "04/clip-38.7s/#Added-snippet-used-as-a-reference-for-all-models-1",
    "page": "clip-38.7s",
    "title": "Added snippet used as a reference for all models",
    "category": "section",
    "text": "This model is based on the TuringTutorial example LinearRegression by Cameron Pfiffer.Turing is powerful when applied to complex hierarchical models, but it can also be put to task at common statistical procedures, like linear regression. This tutorial covers how to implement a linear regression model in Turing.We begin by importing all the necessary libraries.using StatisticalRethinking, CmdStan, StanMCMCChain, GLM\ngr(size=(500,500))\n\nProjDir = rel_path(\"..\", \"chapters\", \"00\")\ncd(ProjDir)Import the dataset.howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdata = filter(row -> row[:age] >= 18, df)Show the first six rows of the dataset.first(data, 6)The next step is to get our data ready for testing. We\'ll split the mtcars dataset into two subsets, one for training our model and one for evaluating our model. Then, we separate the labels we want to learn (MPG, in this case) and standardize the datasets by subtracting each column\'s means and dividing by the standard deviation of that column.The resulting data is not very familiar looking, but this standardization process helps the sampler converge far easier. We also create a function called unstandardize, which returns the standardized values to their original form. We will use this function later on when we make predictions.Split our dataset 70%/30% into training/test sets.train, test = MLDataUtils.splitobs(shuffleobs(data), at = 0.7);Save dataframe versions of our dataset.train_cut = DataFrame(train)\ntest_cut = DataFrame(test)Create our labels. These are the values we are trying to predict.train_label = train[:, :height]\ntest_label = test[:, :height]Get the list of columns to keep.remove_names = filter(x->!in(x, [:height, :age, :male]), names(data))Filter the test and train sets.train = Matrix(train[:, remove_names]);\ntest = Matrix(test[:, remove_names]);A handy helper function to rescale our dataset.function standardize(x)\n    return (x .- mean(x, dims=1)) ./ std(x, dims=1), x\nendAnother helper function to unstandardize our datasets.function unstandardize(x, orig)\n    return x .* std(orig, dims=1) .+ mean(orig, dims=1)\nendStandardize our dataset.(train, train_orig) = standardize(train)\n(test, test_orig) = standardize(test)\n(train_label, train_l_orig) = standardize(train_label)\n(test_label, test_l_orig) = standardize(test_label);Design matrixdmat = [ones(size(train, 1)) train]Bayesian linear regression.lrmodel = \"\ndata {\n  int N; //the number of observations\n  int K; //the number of columns in the model matrix\n  real y[N]; //the response\n  matrix[N,K] X; //the model matrix\n}\nparameters {\n  vector[K] beta; //the regression parameters\n  real sigma; //the standard deviation\n}\ntransformed parameters {\n  vector[N] linpred;\n  linpred <- X*beta;\n}\nmodel {\n  beta[1] ~ cauchy(0,10); //prior for the intercept following Gelman 2008\n\n  for(i in 2:K)\n   beta[i] ~ cauchy(0,2.5);//prior for the slopes following Gelman 2008\n\n  y ~ normal(linpred,sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"linear_regression\",\n  monitors = [\"beta.1\", \"beta.2\", \"sigma\"],\n  model=lrmodel);Input data for cmdstanlrdata = [\n  Dict(\"N\" => size(train, 1), \"K\" => size(dmat, 2), \"y\" => train_label, \"X\" => dmat)\n];Sample using cmdstanrc, sim, cnames = stan(stanmodel, lrdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Convert to a MCMCChain Chain objectcnames = [\"intercept\", \"beta[1]\", \"sigma\"]\nchain = convert_a3d(sim, cnames, Val(:mcmcchain))Describe the chains.describe(chain)Perform multivariate OLS.ols = lm(@formula(height ~ weight), train_cut)Store our predictions in the original dataframe.train_cut.OLSPrediction = predict(ols);\ntest_cut.OLSPrediction = predict(ols, test_cut);Make a prediction given an input vector.function prediction(chain, x)\n    α = chain[:, 1, :].value\n    β = [chain[:, i, :].value for i in 2:2]\n    return  mean(α) .+ x * mean.(β)\nendCalculate the predictions for the training and testing sets.train_cut.BayesPredictions = unstandardize(prediction(chain, train), train_l_orig);\ntest_cut.BayesPredictions = unstandardize(prediction(chain, test), test_l_orig);\n#train_cut.BayesPredictions = prediction(chain, train);\n#test_cut.BayesPredictions = prediction(chain, test);Show the first side rows of the modified dataframe.remove_names = filter(x->!in(x, [:age, :male]), names(test_cut))\ntest_cut = test_cut[remove_names]\nfirst(test_cut, 6) |> display\n\nbayes_loss1 = sum((train_cut.BayesPredictions - train_cut.height).^2)\nols_loss1 = sum((train_cut.OLSPrediction - train_cut.height).^2)\n\nbayes_loss2 = sum((test_cut.BayesPredictions - test_cut.height).^2)\nols_loss2 = sum((test_cut.OLSPrediction - test_cut.height).^2)\n\nprintln(\"\\nTraining set:\")\nprintln(\"  Bayes loss: $bayes_loss1\")\nprintln(\"  OLS loss: $ols_loss1\")\n\nprintln(\"Test set:\")\nprintln(\"  Bayes loss: $bayes_loss2\")\nprintln(\"  OLS loss: $ols_loss2\")Plot the chains.plot(chain)This page was generated using Literate.jl."
},

{
    "location": "04/clip-43s/#",
    "page": "clip-43s",
    "title": "clip-43s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip-43s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-43s/#snippet-4.7-1",
    "page": "clip-43s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)\nmean_weight = mean(df2[:weight])\ndf2[:weight] = convert(Vector{Float64}, df2[:weight]) .- mean_weight ;Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME)Describe the drawsdescribe(chn)Compare with a previous resultclip_38s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean         SD       Naive SE       MCSE     ESS\nalpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000\n beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000\nsigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750\n beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574\nsigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417\n\n\";Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = -16.0:0.1:18.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df2[:weight], df2[:height], lab=\"Observations\",\n  ylab=\"height [cm]\", xlab=\"weight[kg]\")\nplot!(xi, yi, lab=\"Regression line\")End of clip_43s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-45-47s/#",
    "page": "clip-45-47s",
    "title": "clip-45-47s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip-45-47s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-45-47s/#snippet-4.7-1",
    "page": "clip-45-47s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME)Show first 5 individual draws of correlated parameter values in chain 1chn.value[1:5,:,1]Plot estimates using the N = [10, 50, 150, 352] observationsp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\nnvals = [10, 50, 150, 352]\n\nfor i in 1:length(nvals)\n  N = nvals[i]\n  heightsdataN = [\n    Dict(\"N\" => N, \"height\" => df2[1:N, :height], \"weight\" => df2[1:N, :weight])\n  ]\n  rc, chnN, cnames = stan(stanmodel, heightsdataN, ProjDir, diagnostics=false,\n    summary=false, CmdStanDir=CMDSTAN_HOME)\n\n  xi = 30.0:0.1:65.0\n  rws, vars, chns = size(chnN[:, 1, :])\n  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))\n  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))\n\n  p[i] = scatter(df2[1:N, :weight], df2[1:N, :height], leg=false, xlab=\"weight\")\n  for j in 1:N\n    yi = alpha_vals[j] .+ beta_vals[j]*xi\n    plot!(p[i], xi, yi, title=\"N = $N\")\n  end\nend\nplot(p..., layout=(2, 2))End of clip_45_47s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-48-54s/#",
    "page": "clip-48-54s",
    "title": "clip-48-54s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip-48-54s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-48-54s/#Preliminary-snippets-1",
    "page": "clip-48-54s",
    "title": "Preliminary snippets",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Center weight and store as weight_cmean_weight = mean(df2[:weight])\ndf2 = hcat(df2, df2[:weight] .- mean_weight)\nrename!(df2, :x1 => :weight_c); # Rename our col :x1 => :weight_c\ndf2Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstan.heightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight_c])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);"
},

{
    "location": "04/clip-48-54s/#Snippet-4.47-1",
    "page": "clip-48-54s",
    "title": "Snippet 4.47",
    "category": "section",
    "text": "Show first 5 individual draws of correlated parameter values in chain 1chn.value[1:5,:,1]"
},

{
    "location": "04/clip-48-54s/#Snippets-4.48-and-4.49-1",
    "page": "clip-48-54s",
    "title": "Snippets 4.48 & 4.49",
    "category": "section",
    "text": "Plot estimates using the N = [10, 50, 150, 352] observationsnvals = [10, 50, 150, 352];Create the 4 nvals plotsp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\nfor i in 1:length(nvals)\n  N = nvals[i]\n  heightsdataN = [\n    Dict(\"N\" => N, \"height\" => df2[1:N, :height], \"weight\" => df2[1:N, :weight_c])\n  ]\n  rc, chnN, cnames = stan(stanmodel, heightsdataN, ProjDir, diagnostics=false,\n    summary=false, CmdStanDir=CMDSTAN_HOME)\n\n  rws, vars, chns = size(chnN[:, 1, :])\n  xi = -15.0:0.1:15.0\n  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))\n  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))\n\n  p[i] = scatter(df2[1:N, :weight_c], df2[1:N, :height], leg=false, xlab=\"weight_c\")\n  for j in 1:N\n    yi = alpha_vals[j] .+ beta_vals[j]*xi\n    plot!(p[i], xi, yi, title=\"N = $N\")\n  end\nend\nplot(p..., layout=(2, 2))"
},

{
    "location": "04/clip-48-54s/#Snippet-4.50-1",
    "page": "clip-48-54s",
    "title": "Snippet 4.50",
    "category": "section",
    "text": "Get dimensions of chainsrws, vars, chns = size(chn[:, 1, :])\nmu_at_50 = link(50:10:50, chn, [1, 2], mean_weight);\ndensity(mu_at_50)"
},

{
    "location": "04/clip-48-54s/#Snippet-4.54-1",
    "page": "clip-48-54s",
    "title": "Snippet 4.54",
    "category": "section",
    "text": "Show posterior density for 6 mu_bar valuesmu = link(25:10:75, chn, [1, 2], mean_weight);\n\nq = Vector{Plots.Plot{Plots.GRBackend}}(undef, size(mu, 1))\nfor i in 1:size(mu, 1)\n  q[i] = density(mu[i], ylim=(0.0, 1.5),\n    leg=false, title=\"mu_bar = $(round(mean(mu[i]), digits=1))\")\nend\n\nplot(q..., layout=(2, 3), ticks=(3))End of clip_48_54s.jlThis page was generated using Literate.jl."
},

{
    "location": "05/clip-01s/#",
    "page": "clip-01s",
    "title": "clip-01s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/05/clip-01s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"05\")\ncd(ProjDir)"
},

{
    "location": "05/clip-01s/#snippet-5.1-1",
    "page": "clip-01s",
    "title": "snippet 5.1",
    "category": "section",
    "text": "wd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\",\n  \"data\", \"WaffleDivorce.csv\"), delim=\';\')\ndf = convert(DataFrame, wd);\nmean_ma = mean(df[:MedianAgeMarriage])\ndf[:MedianAgeMarriage] = convert(Vector{Float64},\n  df[:MedianAgeMarriage]) .- mean_ma;Define the Stan language modelad_model = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] divorce; // Predictor\n vector[N] median_age; // Outcome\n}\n\nparameters {\n real a; // Intercept\n real bA; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\ntransformed parameters {\n  vector[N] mu; // Intermediate mu\n  for (i in 1:N)\n    mu[i] = a + bA*median_age[i];\n}\n\nmodel {priors  a ~ normal(10, 10);\n  bA ~ normal(0, 1);\n  sigma ~ uniform(0, 10);model  divorce ~ normal(mu , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"MedianAgeDivorce\", monitors = [\"a\", \"bA\", \"sigma\"],\n  model=ad_model, output_format=:mcmcchain);Input data for cmdstanmaddata = [\n  Dict(\"N\" => length(df[:Divorce]), \"divorce\" => df[:Divorce],\n    \"median_age\" => df[:MedianAgeMarriage])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, maddata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = -3.0:0.1:3.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df[:MedianAgeMarriage], df[:Divorce], lab=\"Observations\",\n  xlab=\"Median age of marriage\", ylab=\"divorce\")\nplot!(xi, yi, lab=\"Regression line\")Plot estimates using the N = [10, 50, 150, 352] observationsp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\nnvals = [10, 20, 35, 50]\n\nfor i in 1:length(nvals)\n  N = nvals[i]\n  maddataN = [\n    Dict(\"N\" => N, \"divorce\" => df[1:N, :Divorce],\n      \"median_age\" => df[1:N, :MedianAgeMarriage])\n  ]\n  rc, chnN, cnames = stan(stanmodel, maddataN, ProjDir, diagnostics=false,\n    summary=false, CmdStanDir=CMDSTAN_HOME)\n\n  xi = -3.0:0.1:3.0\n  rws, vars, chns = size(chnN[:, 1, :])\n  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))\n  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))\n\n  p[i] = scatter(df[1:N, :MedianAgeMarriage], df[1:N, :Divorce],\n    leg=false, xlab=\"Median age of marriage\")\n  for j in 1:N\n    yi = alpha_vals[j] .+ beta_vals[j]*xi\n    plot!(p[i], xi, yi, title=\"N = $N\")\n  end\nend\nplot(p..., layout=(2, 2))End of 05/clip_01s.jlThis page was generated using Literate.jl."
},

{
    "location": "#",
    "page": "Functions",
    "title": "Functions",
    "category": "page",
    "text": "CurrentModule = StatisticalRethinking"
},

{
    "location": "#StatisticalRethinking.maximum_a_posteriori-Tuple{Any,Any,Any}",
    "page": "Functions",
    "title": "StatisticalRethinking.maximum_a_posteriori",
    "category": "method",
    "text": "maximumaposterior\n\nCompute the maximumaposteriori of a model. \n\nMethod\n\nmaximum_a_posteriori(model, lower_bound, upper_bound)\n\nRequired arguments\n\n* `model::Turing model`\n* `lower_bound::Float64`\n* `upper_bound::Float64`\n\nReturn values\n\n* `result`                       : Maximum_a_posterior vector\n\nExamples\n\nSee 02/clip_08t.jl\n\n\n\n\n\n"
},

{
    "location": "#maximum_a_posteriori-1",
    "page": "Functions",
    "title": "maximum_a_posteriori",
    "category": "section",
    "text": "maximum_a_posteriori(model, lower_bound, upper_bound)"
},

{
    "location": "#StatisticalRethinking.rel_path-Tuple",
    "page": "Functions",
    "title": "StatisticalRethinking.rel_path",
    "category": "method",
    "text": "rel_path\n\nRelative path using the StatisticalRethinking src/ directory. Copied from DynamicHMCExamples.jl\n\nExample to get access to the data subdirectory\n\nrel_path(\"..\", \"data\")\n\n\n\n\n\n"
},

{
    "location": "#rel_path-1",
    "page": "Functions",
    "title": "rel_path",
    "category": "section",
    "text": "rel_path(parts...)"
},

]}
