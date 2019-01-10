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
    "text": "Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:clip-01-03.jl - contains snippets 0.1 through 0.3\nclip-04-05.jl - contains snippets 0.4 and 0.5.These 2 files are in scripts/00 and later on processed by Literate.jl to create 3 derived versions, e.g. from clip_01_03.jl in scripts/00:clip-01-03.md - included in the documentation\nclip-01-03.ipynb - stored in the notebooks/chapter directory\nclip-01-03.jl - stored in the chapters/chapter directoryOccasionally lines in scripts are suppressed when Literate processes input source files, e.g. in Turing scripts the statement #nb Turing.turnprogress(false); is only inserted in the generated notebook but not in the corresponding chapter .jl script.A single snippet clip will be referred to as 03/clip-02.jl. Clips with names such as 02/clip-08t.jl, clip_08s.jl and clip_08m.jl contain mcmc implementations using Turing.jl, CmdStan.jl and Mamba.jl respectively. Examples have been added to chapter 2.The Turing versions of the mcmc models are available as e.g. chapters/08/m8.1t.jl. Equivalent CmdStan versions and, in a few cases Mamba models, are provided as well.Almost identical clips are named e.g. 04/clip-07.0s.jl and 04/clip-07.1s.jl. In that specific example just the priors differ.Scripts using Turing, Mamba or CmdStan need to import those, see the examples in scripts/02.In the src directory is a file scriptentry.jl which defines an object script_dict which is used to control the generation of documentation, notebooks and .jl scripts in chapters and testing of the notebooks. Output of CmdStan and Mamba scripts is automatically inserted in the documentation. For Turing scripts this needs to be done manually by executing the notebook, exporting the results as .md files (and .svg files if graphics are generated) and copy these to docs/src/nn, where nn is the chapter. See ?ScriptEntry or enter e.g. script_dict[\"02\"] in the REPL."
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/00/clip-01-03.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking"
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/00/clip-04-05.jl\"Load Julia packages (libraries) needed"
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
    "text": "Below dataset(...) provides access to often used R datasets. If this is not a common R dataset, see the chapter 4 snippets.cars = dataset(\"datasets\", \"cars\");\nfirst(cars, 5)Fit a linear regression of distance on speedm = lm(@formula(Dist ~ Speed), cars)estimated coefficients from the modelcoef(m)Plot residuals against speedscatter( cars[:Speed], residuals(m),\n  xlab=\"Speed\", ylab=\"Model residual values\", lab=\"Model residuals\")End of clip_04_05.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-01-02/#",
    "page": "clip-01-02",
    "title": "clip-01-02",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/02/clip-01-02.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking"
},

{
    "location": "02/clip-01-02/#snippet-2.1-1",
    "page": "clip-01-02",
    "title": "snippet 2.1",
    "category": "section",
    "text": "ways  = [0, 3, 8, 9, 0];ways/sum(ways)"
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/02/clip-03-05.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300));"
},

{
    "location": "02/clip-03-05/#snippet-2.3-1",
    "page": "clip-03-05",
    "title": "snippet 2.3",
    "category": "section",
    "text": "Define a gridN = 20\np_grid = range( 0 , stop=1 , length=N )Define the (uniform) priorprior = ones( 20 );Compute likelihood at each value in gridlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]\nlikelihood[1:5]Compute product of likelihood and priorunstd_posterior = likelihood .* prior;Standardize the posterior, so it sums to 1posterior = unstd_posterior  ./ sum(unstd_posterior);"
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/02/clip-06-07.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300));"
},

{
    "location": "02/clip-06-07/#snippet-2.6-(see-snippet-3_2-for-explanations)-1",
    "page": "clip-06-07",
    "title": "snippet 2.6 (see snippet 3_2 for explanations)",
    "category": "section",
    "text": "p_grid = range(0, step=0.001, stop=1)\nprior = ones(length(p_grid))\nlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]\nposterior = likelihood .* prior\nposterior = posterior / sum(posterior)\nsamples = sample(p_grid, Weights(posterior), length(p_grid));\nsamples[1:5]p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")\nplot(p..., layout=(1, 2))"
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/02/clip-08m.jl\"using MambaDataglobe_toss = Dict{Symbol, Any}(\n  :w => [6, 7, 5, 6, 6],\n  :n => [9, 9, 9, 9, 9]\n)\nglobe_toss[:N] = length(globe_toss[:w]);Model Specificationmodel = Model(\n  w = Stochastic(1,\n    (n, p, N) ->\n      UnivariateDistribution[Binomial(n[i], p) for i in 1:N],\n    false\n  ),\n  p = Stochastic(() -> Beta(1, 1))\n);Initial Valuesinits = [\n  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => 0.5),\n  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => rand(Beta(1, 1)))\n];Sampling Schemescheme = [NUTS(:p)]\nsetsamplers!(model, scheme);MCMC Simulationssim = mcmc(model, globe_toss, inits, 10000, burnin=2500, thin=1, chains=2);Describe drawsdescribe(sim)End of clip_08m.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-08s/#",
    "page": "clip-08s",
    "title": "clip-08s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/02/clip-08s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,800));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"02\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4^2\nd = Binomial(9, 0.66)\nn2 = Int.(9 * ones(Int, N2));Show first 5 (generated) observationsk2 = rand(d, N2);\nk2[1:5]Input data for cmdstanbinomialdata = Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2);Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Allocate array of Normal fitsfits = Vector{Normal{Float64}}(undef, 4)\nfor i in 1:4\n  fits[i] = fit_mle(Normal, convert.(Float64, chn.value[:, 1, i]))\n  println(fits[i])\nendPlot the 4 chainsif rc == 0\n  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\n  x = 0:0.001:1\n  for i in 1:4\n    vals = convert.(Float64, chn.value[:, 1, i])\n    μ = round(fits[i].μ, digits=2)\n    σ = round(fits[i].σ, digits=2)\n    p[i] = density(vals, lab=\"Chain $i density\",\n       xlim=(0.45, 1.0), title=\"$(N2) data points\")\n    plot!(p[i], x, pdf.(Normal(fits[i].μ, fits[i].σ), x), lab=\"Fitted Normal($μ, $σ)\")\n  end\n  plot(p..., layout=(4, 1))\nendEnd of clip_08s.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-08t/#",
    "page": "clip-08t",
    "title": "clip-08t",
    "category": "page",
    "text": "Load Julia packages (libraries) neededusing StatisticalRethinking\nusing Optim, Turing, Flux.Tracker\ngr(size=(600,300));\n\nTuring.setadbackend(:reverse_diff)loaded\n\n\n┌ Warning: Package Turing does not have CmdStan in its dependencies:\n│ - If you have Turing checked out for development and have\n│   added CmdStan as a dependency but haven\'t updated your primary\n│   environment\'s manifest file, try `Pkg.resolve()`.\n│ - Otherwise you may need to report an issue with Turing\n│ Loading CmdStan into Turing from project dependency, future warnings for Turing are suppressed.\n└ @ nothing nothing:840\nWARNING: using CmdStan.Sample in module Turing conflicts with an existing identifier.\n\n\n\n\n\n:reverse_diff"
},

{
    "location": "02/clip-08t/#snippet-2.8t-1",
    "page": "clip-08t",
    "title": "snippet 2.8t",
    "category": "section",
    "text": "Define the datak = 6; n = 9;Define the model@model globe_toss(n, k) = begin\n  theta ~ Beta(1, 1) # prior\n  k ~ Binomial(n, theta) # model\n  return k, theta\nend;Compute the \"maximumaposteriori\" valueSet search boundslb = [0.0]; ub = [1.0];Create (compile) the modelmodel = globe_toss(n, k);Compute the maximumaposterioriresult = maximum_a_posteriori(model, lb, ub)Results of Optimization Algorithm\n * Algorithm: Fminbox with L-BFGS\n * Starting Point: [0.7074651788576896]\n * Minimizer: [0.6666666666346246]\n * Minimum: 1.297811e+00\n * Iterations: 3\n * Convergence: true\n   * |x - x\'| ≤ 0.0e+00: false \n     |x - x\'| = 1.36e-08 \n   * |f(x) - f(x\')| ≤ 0.0e+00 |f(x)|: false\n     |f(x) - f(x\')| = 2.91e-15 |f(x)|\n   * |g(x)| ≤ 1.0e-08: true \n     |g(x)| = 5.49e-10 \n   * Stopped by an increasing objective: false\n   * Reached Maximum Number of Iterations: false\n * Objective Calls: 40\n * Gradient Calls: 40Use Turing mcmcTuring.turnprogress(false)\nchn = sample(model, NUTS(2000, 1000, 0.65));┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/Turing.jl:81\n┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:246\n[NUTS{Turing.FluxTrackerAD,Union{}}] found initial ϵ: 1.6\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:291\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:154\n┌ Warning: grad = [NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:155\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:154\n┌ Warning: grad = [NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:155\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:154\n┌ Warning: grad = [NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:155\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:154\n┌ Warning: grad = [NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:155\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:154\n┌ Warning: grad = [NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:155\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:154\n┌ Warning: grad = [NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:155\n┌ Info:  Adapted ϵ = 0.9578390791627754, std = [1.0]; 1000 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 5.0150662429999855;\n  #lf / sample        = 0.003;\n  #evals / sample     = 6.861;\n  pre-cond. metric    = [1.0].Look at the generated draws (in chn)describe(chn)Iterations = 1:2000\nThinning interval = 1\nChains = 1\nSamples per chain = 2000\n\nEmpirical Posterior Estimates:\n              Mean          SD       Naive SE       MCSE         ESS   \n  lf_num  0.0030000000 0.134164079 0.0030000000 0.0030000000 2000.00000\n elapsed  0.0025075331 0.076118594 0.0017020635 0.0021953340 1202.20989\n epsilon  1.1224381138 1.169459120 0.0261499009 0.0493105061  562.45939\n   theta  0.6360030739 0.141416742 0.0031621745 0.0051225094  762.14241\n      lp -3.3190592140 0.784351311 0.0175386285 0.0269713545  845.69885\neval_num  6.8610000000 4.105375263 0.0917989816 0.1380253600  884.68354\n  lf_eps  1.1224381138 1.169459120 0.0261499009 0.0493105061  562.45939\n\nQuantiles:\n              2.5%           25.0%         50.0%        75.0%          97.5%    \n  lf_num  0.00000000000  0.00000000000  0.000000000  0.0000000000  0.00000000000\n elapsed  0.00015128197  0.00015763575  0.000171609  0.0004108415  0.00092276617\n epsilon  0.37088676482  0.95783907916  0.957839079  1.0079548635  2.57305557179\n   theta  0.33883816330  0.54280720291  0.646171490  0.7438412205  0.87079519843\n      lp -5.35598404924 -3.51435734171 -3.037441877 -2.8405070850 -2.78040346743\neval_num  4.00000000000  4.00000000000  4.000000000 10.0000000000 22.00000000000\n  lf_eps  0.37088676482  0.95783907916  0.957839079  1.0079548635  2.57305557179Look at the mean and sdprintln(\"\\ntheta = $(mean_and_std(chn[:theta][1001:2000]))\\n\")theta = (0.6451384410698796, 0.1396889134652362)Compute at hpd regionbnds = MCMCChain.hpd(chn[:theta], alpha=0.06);analytical calculationw = 6; n = 9; x = 0:0.01:1\nplot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab=\"Conjugate solution\")(Image: svg)quadratic approximationplot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")(Image: svg)Turing Chain &  89%hpd region boundariesdensity!(chn[:theta], lab=\"Turing chain\")\nvline!([bnds[1]], line=:dash, lab=\"hpd lower bound\")\nvline!([bnds[2]], line=:dash, lab=\"hpd upper bound\")(Image: svg)Show hpd regionprintln(\"hpd bounds = $bnds\\n\")hpd bounds = [0.38923, 0.899449]End of clip_08t.jlThis notebook was generated using Literate.jl."
},

{
    "location": "03/clip-01/#",
    "page": "clip-01",
    "title": "clip-01",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/03/clip-01.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking"
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/03/clip-02-05.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300))"
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/03/clip-05s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,800));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"03\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4^2\nd = Binomial(9, 0.66)\nn2 = Int.(9 * ones(Int, N2))\nk2 = rand(d, N2);Input data for cmdstanbinomialdata = Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2);Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the 4 chainsif rc == 0\n  plot(chn)\nendEnd of clip_05s.jlThis page was generated using Literate.jl."
},

{
    "location": "03/clip-06-16s/#",
    "page": "clip-06-16s",
    "title": "clip-06-16s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/03/clip-06-16s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"03\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4\nn2 = Int.(9 * ones(Int, N2))\nk2 = [6, 5, 7, 6]Input data for cmdstanbinomialdata = Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2);Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Look at area of hpdMCMCChain.hpd(chn)Plot the 4 chainsif rc == 0\n  mixeddensity(chn, xlab=\"height [cm]\", ylab=\"density\")\n  bnds = MCMCChain.hpd(convert(Vector{Float64}, chn.value[:,1,1]))\n  vline!([bnds[1]], line=:dash)\n  vline!([bnds[2]], line=:dash)\nendEnd of clip_06_16s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-01-06/#",
    "page": "clip-01-06",
    "title": "clip-01-06",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-01-06.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300));"
},

{
    "location": "04/clip-01-06/#snippet-4.1-1",
    "page": "clip-01-06",
    "title": "snippet 4.1",
    "category": "section",
    "text": "No attempt has been made to condense this too fewer lines of codenoofsteps = 20;\nnoofwalks = 15;\npos = Array{Float64, 2}(rand(Uniform(-1, 1), noofsteps, noofwalks));\npos[1, :] = zeros(noofwalks);\ncsum = cumsum(pos, dims=1);f = Plots.font(\"DejaVu Sans\", 6)\nmx = minimum(csum) * 0.9Plot and annotate the random walksp1 = plot(csum, leg=false, title=\"Random walks ($(noofwalks))\")\nplot!(p1, csum[:, Int(floor(noofwalks/2))], leg=false, title=\"Random walks ($(noofwalks))\", color=:black)\nplot!(p1, [5], seriestype=\"vline\")\nannotate!(5, mx, text(\"step 4\", f, :left))\nplot!(p1, [9], seriestype=\"vline\")\nannotate!(9, mx, text(\"step 8\", f, :left))\nplot!(p1, [17], seriestype=\"vline\")\nannotate!(17, mx, text(\"step 16\", f, :left))Generate 3 plots of densities at 3 different step numbers (4, 8 and 16)p2 = Vector{Plots.Plot{Plots.GRBackend}}(undef, 3);\nplt = 1\nfor step in [4, 8, 16]\n  indx = step + 1 # We aadded the first line of zeros\n  global plt\n  fit = fit_mle(Normal, csum[indx, :])\n  x = (fit.μ-4*fit.σ):0.01:(fit.μ+4*fit.σ)\n  p2[plt] = density(csum[indx, :], legend=false, title=\"$(step) steps\")\n  plot!( p2[plt], x, pdf.(Normal( fit.μ , fit.σ ) , x ), fill=(0, .5,:orange))\n  plt += 1\nend\np3 = plot(p2..., layout=(1, 3))\nplot(p1, p3, layout=(2,1))"
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
    "text": "Grid of 1001 stepsp_grid = range(0, step=0.001, stop=1);all priors = 1.0prior = ones(length(p_grid));Binomial pdflikelihood = [pdf(Binomial(9, p), 6) for p in p_grid];As Uniform priar has been used, unstandardized posterior is equal to likelihoodposterior = likelihood .* prior;Scale posterior such that they become probabilitiesposterior = posterior / sum(posterior);Sample using the computed posterior values as weights In this example we keep the number of samples equal to the length of p_grid, but that is not required.samples = sample(p_grid, Weights(posterior), length(p_grid));\np = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\", fill=(0, .5,:orange))\nplot(p..., layout=(1, 2))End of clip-01-06.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-07-13s/#",
    "page": "clip-07-13s",
    "title": "clip-07-13s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-07-13s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-07-13s/#snippet-4.7-1",
    "page": "clip-07-13s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);"
},

{
    "location": "04/clip-07-13s/#snippet-4.8-1",
    "page": "clip-07-13s",
    "title": "snippet 4.8",
    "category": "section",
    "text": "Show first 5 rows of DataFrame dffirst(df, 5)Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Plot the densities.density(df2[:height], lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")Filter on sex to see if it is bi-modalfemale_df = filter(row -> row[:male] == 0, df2);\nmale_df = filter(row -> row[:male] == 1, df2);\nfirst(male_df, 5)Is it bi-modal?density!(female_df[:height], lab=\"Female heights\")\ndensity!(male_df[:height], lab=\"Male heights\")Use data from m4.1sCheck if the m4.1s.jls file is present. If not, run the model.!isfile(\"m4.1s.jls\") && include(\"m4.1s.jl\")\n\nchn = deserialize(\"m4.1s.jls\")Describe the drawsdescribe(chn)"
},

{
    "location": "04/clip-07-13s/#snippet-4.13-1",
    "page": "clip-07-13s",
    "title": "snippet 4.13",
    "category": "section",
    "text": "Plot the density of posterior drawsdensity(chn, lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")End of clip-07-13s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-14-29s/#",
    "page": "clip-14-29s",
    "title": "clip-14-29s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-14-29s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)Use data from m4.1sCheck if the m4.1s.jls file is present. If not, run the model.!isfile(\"m4.1s.jls\") && include(\"m4.1s.jl\")\n\nchn = deserialize(\"m4.1s.jls\")Describe the drawsdescribe(chn)"
},

{
    "location": "04/clip-14-29s/#snippet-4.15-1",
    "page": "clip-14-29s",
    "title": "snippet 4.15",
    "category": "section",
    "text": "scatter(chn.value[:, 2, 1], chn.value[:, 1, 1])End of clip-14-29s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-30s/#",
    "page": "clip-30s",
    "title": "clip-30s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-30s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, CmdStan, StanMCMCChain, LinearAlgebra\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-30s/#snippet-4.7-1",
    "page": "clip-30s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);\nfirst(df2, 5)Use data from m4.1sCheck if the m4.1s.jls file is present. If not, run the model.!isfile(\"m4.1s.jls\") && include(\"m4.1s.jl\")\n\nchn = deserialize(\"m4.1s.jls\")Describe the drawsdescribe(chn)Plot the density of posterior drawsdensity(chn, lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")Compute cormu_sigma = hcat(chn.value[:, 2, 1], chn.value[:,1, 1])\nLinearAlgebra.diag(cov(mu_sigma))Compute covcor(mu_sigma)End of clip_07.0s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-38s/#",
    "page": "clip-38s",
    "title": "clip-38s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-38s.jl\""
},

{
    "location": "04/clip-38s/#Linear-Regression-1",
    "page": "clip-38s",
    "title": "Linear Regression",
    "category": "section",
    "text": ""
},

{
    "location": "04/clip-38s/#Added-snippet-used-as-a-reference-for-all-models-1",
    "page": "clip-38s",
    "title": "Added snippet used as a reference for all models",
    "category": "section",
    "text": "This model is based on the TuringTutorial example LinearRegression by Cameron Pfiffer.Turing is powerful when applied to complex hierarchical models, but it can also be put to task at common statistical procedures, like linear regression. This tutorial covers how to implement a linear regression model in Turing.We begin by importing all the necessary libraries.using StatisticalRethinking, CmdStan, StanMCMCChain, GLM\ngr(size=(500,500))\n\nProjDir = rel_path(\"..\", \"scripts\", \"00\")\ncd(ProjDir)Import the dataset.howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdata = filter(row -> row[:age] >= 18, df)Show the first six rows of the dataset.first(data, 6)The next step is to get our data ready for testing. We\'ll split the mtcars dataset into two subsets, one for training our model and one for evaluating our model. Then, we separate the labels we want to learn (MPG, in this case) and standardize the datasets by subtracting each column\'s means and dividing by the standard deviation of that column.The resulting data is not very familiar looking, but this standardization process helps the sampler converge far easier. We also create a function called unstandardize, which returns the standardized values to their original form. We will use this function later on when we make predictions.Split our dataset 70%/30% into training/test sets.n = size(data, 1)\ntest_ind = sample(1:n, Int(floor(0.3*n)), replace=false);\ntrain_ind = [(i) for i=1:n if !(i in test_ind)];\ntest = data[test_ind, :];\ntrain = data[train_ind, :];Save dataframe versions of our dataset.train_cut = DataFrame(train)\ntest_cut = DataFrame(test)Create our labels. These are the values we are trying to predict.train_label = train[:, :height]\ntest_label = test[:, :height]Get the list of columns to keep.remove_names = filter(x->!in(x, [:height, :age, :male]), names(data))Filter the test and train sets.train = Matrix(train[:, remove_names]);\ntest = Matrix(test[:, remove_names]);A handy helper function to rescale our dataset.function standardize(x)\n    return (x .- mean(x, dims=1)) ./ std(x, dims=1), x\nendAnother helper function to unstandardize our datasets.function unstandardize(x, orig)\n    return x .* std(orig, dims=1) .+ mean(orig, dims=1)\nendStandardize our dataset.(train, train_orig) = standardize(train)\n(test, test_orig) = standardize(test)\n(train_label, train_l_orig) = standardize(train_label)\n(test_label, test_l_orig) = standardize(test_label);Design matrixdmat = [ones(size(train, 1)) train]Bayesian linear regression.lrmodel = \"\ndata {\n  int N; //the number of observations\n  int K; //the number of columns in the model matrix\n  real y[N]; //the response\n  matrix[N,K] X; //the model matrix\n}\nparameters {\n  vector[K] beta; //the regression parameters\n  real sigma; //the standard deviation\n}\ntransformed parameters {\n  vector[N] linpred;\n  linpred <- X*beta;\n}\nmodel {\n  beta[1] ~ cauchy(0,10); //prior for the intercept following Gelman 2008\n\n  for(i in 2:K)\n   beta[i] ~ cauchy(0,2.5);//prior for the slopes following Gelman 2008\n\n  y ~ normal(linpred,sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"linear_regression\",\n  monitors = [\"beta.1\", \"beta.2\", \"sigma\"],\n  model=lrmodel);Input data for cmdstanlrdata = Dict(\"N\" => size(train, 1), \"K\" => size(dmat, 2), \"y\" => train_label, \"X\" => dmat);Sample using cmdstanrc, sim, cnames = stan(stanmodel, lrdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Convert to a MCMCChain Chain objectcnames = [\"intercept\", \"beta[1]\", \"sigma\"]\nchain = convert_a3d(sim, cnames, Val(:mcmcchain))Describe the chains.describe(chain)Perform multivariate OLS.ols = lm(@formula(height ~ weight), train_cut)Store our predictions in the original dataframe.train_cut.OLSPrediction = predict(ols);\ntest_cut.OLSPrediction = predict(ols, test_cut);Make a prediction given an input vector.function prediction(chain, x)\n    α = chain[:, 1, :].value\n    β = [chain[:, i, :].value for i in 2:2]\n    return  mean(α) .+ x * mean.(β)\nendCalculate the predictions for the training and testing sets.train_cut.BayesPredictions = unstandardize(prediction(chain, train), train_l_orig);\ntest_cut.BayesPredictions = unstandardize(prediction(chain, test), test_l_orig);Show the first side rows of the modified dataframe.remove_names = filter(x->!in(x, [:age, :male]), names(test_cut));\ntest_cut = test_cut[remove_names];\nfirst(test_cut, 6)\n\nbayes_loss1 = sum((train_cut.BayesPredictions - train_cut.height).^2);\nols_loss1 = sum((train_cut.OLSPrediction - train_cut.height).^2);\n\nbayes_loss2 = sum((test_cut.BayesPredictions - test_cut.height).^2);\nols_loss2 = sum((test_cut.OLSPrediction - test_cut.height).^2);\n\nprintln(\"\\nTraining set:\")\nprintln(\"  Bayes loss: $bayes_loss1\")\nprintln(\"  OLS loss: $ols_loss1\")\n\nprintln(\"Test set:\")\nprintln(\"  Bayes loss: $bayes_loss2\")\nprintln(\"  OLS loss: $ols_loss2\")Plot the chains.plot(chain)This page was generated using Literate.jl."
},

{
    "location": "04/clip-43s/#",
    "page": "clip-43s",
    "title": "clip-43s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-43s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-43s/#snippet-4.7-1",
    "page": "clip-43s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);\nmean_weight = mean(df2[:weight]);\ndf2[:weight_c] = convert(Vector{Float64}, df2[:weight]) .- mean_weight;\nfirst(df2, 5)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight_c]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsscatter(df2[:weight], df2[:height], lab=\"Observations\",\n  ylab=\"height [cm]\", xlab=\"weight[kg]\")\nxi = -16.0:0.1:18.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\nplot!(xi, yi, lab=\"Regression line\")End of clip-43s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-45-47s/#",
    "page": "clip-45-47s",
    "title": "clip-45-47s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-45-47s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-45-47s/#snippet-4.7-1",
    "page": "clip-45-47s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);\nfirst(df2, 5)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height],\n  \"weight\" => df2[:weight]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME)Show first 5 individual draws of correlated parameter values in chain 1chn.value[1:5,:,1]Plot estimates using the N = [10, 50, 150, 352] observationsp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\nnvals = [10, 50, 150, 352];for i in 1:length(nvals)\n  N = nvals[i]\n  heightsdataN = [\n    Dict(\"N\" => N, \"height\" => df2[1:N, :height], \"weight\" => df2[1:N, :weight])\n  ]\n  rc, chnN, cnames = stan(stanmodel, heightsdataN, ProjDir, diagnostics=false,\n    summary=false, CmdStanDir=CMDSTAN_HOME)\n\n  xi = 30.0:0.1:65.0\n  rws, vars, chns = size(chnN[:, 1, :])\n  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))\n  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))\n\n  p[i] = scatter(df2[1:N, :weight], df2[1:N, :height], leg=false,\n    color=:darkblue, xlab=\"weight\")\n  for j in 1:N\n    yi = alpha_vals[j] .+ beta_vals[j]*xi\n    plot!(p[i], xi, yi, title=\"N = $N\", color=:lightgrey)\n  end\n  scatter!(p[i], df2[1:N, :weight], df2[1:N, :height], leg=false,\n    color=:darkblue, xlab=\"weight\")\nend\nplot(p..., layout=(2, 2))End of clip_45_47s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-48-54s/#",
    "page": "clip-48-54s",
    "title": "clip-48-54s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-48-54s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-48-54s/#Preliminary-snippets-1",
    "page": "clip-48-54s",
    "title": "Preliminary snippets",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Center weight and store as weight_cmean_weight = mean(df2[:weight])\ndf2 = hcat(df2, df2[:weight] .- mean_weight)\nrename!(df2, :x1 => :weight_c); # Rename our col :x1 => :weight_c\nfirst(df2, 5)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstan.heightsdata = Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight_c]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);"
},

{
    "location": "04/clip-48-54s/#Snippet-4.47-1",
    "page": "clip-48-54s",
    "title": "Snippet 4.47",
    "category": "section",
    "text": "Show first 5 draws of correlated parameter values in chain 1chn.value[1:5,:,1]"
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
    "text": "Show posterior density for 6 mu_bar valuesmu = link(25:10:75, chn, [1, 2], mean_weight);\n\nq = Vector{Plots.Plot{Plots.GRBackend}}(undef, size(mu, 1))\nfor i in 1:size(mu, 1)\n  q[i] = density(mu[i], ylim=(0.0, 1.5),\n    leg=false, title=\"mu_bar = $(round(mean(mu[i]), digits=1))\")\nend\nplot(q..., layout=(2, 3), ticks=(3))End of clip_48_54s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/m4.1s/#",
    "page": "m4.1s",
    "title": "m4.1s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.1s.jl\"using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)\n\nhowell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);\n\ndf2 = filter(row -> row[:age] >= 18, df)\nfirst(df2, 5)\n\nheightsmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  real<lower=0> h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=0,upper=250> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ normal(178, 20);\n  sigma ~ uniform( 0 , 50 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\";\n\nstanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain);\n\nheightsdata = Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height]);\n\nrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);\n\ndescribe(chn)\n\nserialize(\"m4.1s.jls\", chn)\nchn2 = deserialize(\"m4.1s.jls\")\n\ndescribe(chn2)end of m4.1s#- This page was generated using Literate.jl."
},

{
    "location": "04/m4.2s/#",
    "page": "m4.2s",
    "title": "m4.2s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.2s.jl\"using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)\n\nhowell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);\n\ndf2 = filter(row -> row[:age] >= 18, df)\nmean_height = mean(df2[:height])\ndf2[:height_c] = convert(Vector{Float64}, df2[:height]) .- mean_height\nfirst(df2, 5)\n\nmax_height_c = maximum(df2[:height_c])\nmin_height_c = minimum(df2[:height_c])\n\nheightsmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  real h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=$(min_height_c),upper=$(max_height_c)> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ normal(178, 20);\n  sigma ~ uniform( 0 , 50 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\";\n\nstanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain);\n\nheightsdata = Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height_c]);\n\nrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);\n\ndescribe(chn)\n\nserialize(\"m4.2s.jls\", chn)\n\nchn2 = deserialize(\"m4.2s.jls\")\n\ndescribe(chn2)end of m4.2s#- This page was generated using Literate.jl."
},

{
    "location": "04/m4.2t/#",
    "page": "m4.2t",
    "title": "m4.2t",
    "category": "page",
    "text": "using StatisticalRethinking\ngr(size=(500,500));\n\nTuring.setadbackend(:reverse_diff)\n\nProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)loaded\n\n\n┌ Warning: Package Turing does not have CmdStan in its dependencies:\n│ - If you have Turing checked out for development and have\n│   added CmdStan as a dependency but haven\'t updated your primary\n│   environment\'s manifest file, try `Pkg.resolve()`.\n│ - Otherwise you may need to report an issue with Turing\n│ Loading CmdStan into Turing from project dependency, future warnings for Turing are suppressed.\n└ @ nothing nothing:840\nWARNING: using CmdStan.Sample in module Turing conflicts with an existing identifier."
},

{
    "location": "04/m4.2t/#snippet-4.43-1",
    "page": "m4.2t",
    "title": "snippet 4.43",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Center the weight observations and add a column to df2mean_weight = mean(df2[:weight])\ndf2 = hcat(df2, df2[:weight] .- mean_weight)\nrename!(df2, :x1 => :weight_c); # Rename our col :x1 => :weight_cExtract variables for Turing modely = convert(Vector{Float64}, df2[:height]);\nx = convert(Vector{Float64}, df2[:weight_c]);Define the regression model@model line(y, x) = begin\n    #priors\n    alpha ~ Normal(178.0, 100.0)\n    beta ~ Normal(0.0, 10.0)\n    s ~ Uniform(0, 50)\n\n    #model\n    mu = alpha .+ beta*x\n    for i in 1:length(y)\n      y[i] ~ Normal(mu[i], s)\n    end\nend;Disable updating progress of sampling processTuring.turnprogress(false);┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/Turing.jl:81Draw the sampleschn = sample(line(y, x), Turing.NUTS(2000, 200, 0.65));┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:246\n[NUTS{Turing.FluxTrackerAD,Union{}}] found initial ϵ: 9.765625e-5\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:291\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:154\n┌ Warning: grad = [2.87442, 1.13369, NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/core/ad.jl:155\n┌ Info:  Adapted ϵ = 0.048916981924135294, std = [1.0, 1.0, 1.0]; 200 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 174.35367367200018;\n  #lf / sample        = 0.006;\n  #evals / sample     = 19.585;\n  pre-cond. metric    = [1.0, 1.0, 1.0].Describe the chain resultdescribe(chn)Iterations = 1:2000\nThinning interval = 1\nChains = 1\nSamples per chain = 2000\n\nEmpirical Posterior Estimates:\n               Mean            SD        Naive SE        MCSE         ESS    \n   alpha   152.667760577  12.963295233 0.2898680935  1.9064933504   46.233869\n    beta     0.904140240   0.091618423 0.0020486502  0.0008881590 2000.000000\n  lf_num     0.006000000   0.268328157 0.0060000000  0.0060000000 2000.000000\n       s     6.266665195   6.434094411 0.1438707248  1.1551333108   31.024918\n elapsed     0.087176837   0.142891027 0.0031951405  0.0045800175  973.364803\n epsilon     0.060923488   0.116768977 0.0026110337  0.0112827671  107.108442\n      lp -1119.947049834 234.300329374 5.2391146363 36.2487389691   41.779188\neval_num    19.585000000  16.885388156 0.3775687574  0.5493208726  944.865288\n  lf_eps     0.060923488   0.116768977 0.0026110337  0.0112827671  107.108442\n\nQuantiles:\n               2.5%           25.0%           50.0%           75.0%          97.5%    \n   alpha   134.948191043   154.375114420   154.565140723   154.73203349   155.05230667\n    beta     0.798963704     0.873424834     0.905341842     0.93619506     1.00452346\n  lf_num     0.000000000     0.000000000     0.000000000     0.00000000     0.00000000\n       s     4.733662988     4.989075540     5.123429873     5.26147108    19.48468805\n elapsed     0.012130080     0.039890004     0.042529685     0.10526795     0.23606201\n epsilon     0.032810233     0.048916982     0.048916982     0.04891698     0.11580557\n      lp -1570.703384637 -1084.496411750 -1083.395403485 -1082.80179112 -1082.28961655\neval_num     4.000000000    10.000000000    10.000000000    22.00000000    46.00000000\n  lf_eps     0.032810233     0.048916982     0.048916982     0.04891698     0.11580557Show corrected results (Drop adaptation samples)for var in [:alpha, :beta, :s]\n  println(\"$var = \",  mean_and_std(chn[Symbol(var)][1001:2000]))\nendalpha = (154.58624745072464, 0.24607428105054843)\nbeta = (0.905527917573359, 0.045451543586106924)\ns = (5.115155765550671, 0.20754394076364754)Compare with a previous resultclip_43s_example_output = \"\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n         Mean        SD       Naive SE       MCSE      ESS\nalpha 154.597086 0.27326431 0.0043206882 0.0036304132 1000\n beta   0.906380 0.04143488 0.0006551430 0.0006994720 1000\nsigma   5.106643 0.19345409 0.0030587777 0.0032035103 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 154.0610000 154.4150000 154.5980000 154.7812500 155.1260000\n beta   0.8255494   0.8790695   0.9057435   0.9336445   0.9882981\nsigma   4.7524368   4.9683400   5.0994450   5.2353100   5.5090128\n\";Example result for Turing with centered weights (appears biased)clip_43t_example_output = \"\n\n[NUTS] Finished with\n  Running time        = 163.20725027799972;\n  #lf / sample        = 0.006;\n  #evals / sample     = 19.824;\n  pre-cond. metric    = [1.0, 1.0, 1.0].\n\n                       Mean                              SD\nalpha = (154.6020248402468, 0.24090814737592972)\nbeta   = (0.9040183717679473, 0.0422796486734481)\ns        = (5.095714121087817, 0.18455074897377258)\n\n\";Plot the regerssion line and observationsxi = -15.0:0.1:15.0\nyi = mean(chn[:alpha]) .+ mean(chn[:beta])*xi\n\nscatter(x, y, lab=\"Observations\", xlab=\"weight\", ylab=\"height\")\nplot!(xi, yi, lab=\"Regression line\")(Image: svg)End of clip_43t.jlThis notebook was generated using Literate.jl."
},

{
    "location": "04/m4.3s/#",
    "page": "m4.3s",
    "title": "m4.3s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.3s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain, JLD\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/m4.3s/#snippet-4.7-1",
    "page": "m4.3s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);\nfirst(df2, 5)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height],\n  \"weight\" => df2[:weight]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME)Describe the drawsdescribe(chn)Save the chains in a JLD fileserialize(\"m4.3s.jls\", chn)\n\nchn2 = deserialize(\"m4.3s.jls\")\n\ndescribe(chn2)Should be identical to earlier resultdescribe(chn2)End of m4.3s.jlThis page was generated using Literate.jl."
},

{
    "location": "05/clip-01s/#",
    "page": "clip-01s",
    "title": "clip-01s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/05/clip-01s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"05\")\ncd(ProjDir)"
},

{
    "location": "05/clip-01s/#snippet-5.1-1",
    "page": "clip-01s",
    "title": "snippet 5.1",
    "category": "section",
    "text": "wd = CSV.read(rel_path(\"..\", \"data\", \"WaffleDivorce.csv\"), delim=\';\')\ndf = convert(DataFrame, wd);\nmean_ma = mean(df[:MedianAgeMarriage])\ndf[:MedianAgeMarriage_s] = convert(Vector{Float64},\n  (df[:MedianAgeMarriage]) .- mean_ma)/std(df[:MedianAgeMarriage]);\nfirst(df, 5)Define the Stan language modelad_model = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] divorce; // Predictor\n vector[N] median_age; // Outcome\n}\n\nparameters {\n real a; // Intercept\n real bA; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {priors  a ~ normal(10, 10);\n  bA ~ normal(0, 1);\n  sigma ~ uniform(0, 10);model  divorce ~ normal(a + bA*median_age , sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"MedianAgeDivorce\", monitors = [\"a\", \"bA\", \"sigma\"],\n  model=ad_model, output_format=:mcmcchain);Input data for cmdstanmaddata = Dict(\"N\" => length(df[:Divorce]), \"divorce\" => df[:Divorce],\n    \"median_age\" => df[:MedianAgeMarriage_s]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, maddata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = -3.0:0.01:3.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df[:MedianAgeMarriage_s], df[:Divorce], color=:darkblue,\n  xlab=\"Median age of marriage [ $(round(mean_ma, digits=1)) years]\",\n  ylab=\"divorce rate [# of divorces/1000 adults]\")\nplot!(xi, yi, lab=\"Regression line\")shade(), abline() and link()mu = link(xi, chn, [1, 2], mean(xi));\nyl = [minimum(mu[i]) for i in 1:length(xi)];\nyh =  [maximum(mu[i]) for i in 1:length(xi)];\nym =  [mean(mu[i]) for i in 1:length(xi)];\npi = hcat(xi, yl, ym, yh);\npi[1:5,:]\n\nplot!((xi, yl), color=:lightgrey, leg=false)\nplot!((xi, yh), color=:lightgrey, leg=false)\nfor i in 1:length(xi)\n  plot!([xi[i], xi[i]], [yl[i], yh[i]], color=:lightgrey, leg=false)\nend\nscatter!(df[:MedianAgeMarriage_s], df[:Divorce], color=:darkblue)\nplot!(xi, yi, lab=\"Regression line\")End of 05/clip_01s.jlThis page was generated using Literate.jl."
},

{
    "location": "08/m8.1t/#",
    "page": "m8.1t",
    "title": "m8.1t",
    "category": "page",
    "text": ""
},

{
    "location": "08/m8.1t/#m8.1stan-1",
    "page": "m8.1t",
    "title": "m8.1stan",
    "category": "section",
    "text": "m8.1stan is the first model in the Statistical Rethinking book (pp. 249) using Stan.Here we will use Turing\'s NUTS support, which is currently (2018) the originalNUTS by Hoffman & Gelman and not the one that\'s in Stan 2.18.2, i.e., Appendix A.5 in: https://arxiv.org/abs/1701.02434The StatisticalRethinking pkg uses, e.g., Turing, CSV, DataFramesusing StatisticalRethinking, Turing\n\nTuring.setadbackend(:reverse_diff)\nTuring.turnprogress(false) #nb┌ Info: Recompiling stale cache file /Users/rob/.julia/compiled/v1.2/StatisticalRethinking/zZGTK.ji for StatisticalRethinking [2d09df54-9d0f-5258-8220-54c2a3d4fbee]\n└ @ Base loading.jl:1184\n\n\nloaded\n\n\n┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/Turing.jl:81\n\n\n\n\n\nfalseRead in rugged data as a DataFramed = CSV.read(rel_path(\"..\", \"data\",\n    \"rugged.csv\"), delim=\';\');\n# Show size of the DataFrame (should be 234x51)\nsize(d)(234, 51)Apply log() to each element in rgdppc_2000 column and add it as a new columnd = hcat(d, map(log, d[Symbol(\"rgdppc_2000\")]));Rename our col x1 => log_gdprename!(d, :x1 => :log_gdp);Now we need to drop every row where rgdppc_2000 == missingWhen this (https://github.com/JuliaData/DataFrames.jl/pull/1546) hits DataFrame it\'ll be conceptually easier: i.e., completecases!(d, :rgdppc_2000)notisnan(e) = !ismissing(e)\ndd = d[map(notisnan, d[:rgdppc_2000]), :];Updated DataFrame dd size (should equal 170 x 52)size(dd)(170, 52)Define the Turing model@model m8_1stan(y, x₁, x₂) = begin\n    σ ~ Truncated(Cauchy(0, 2), 0, Inf)\n    βR ~ Normal(0, 10)\n    βA ~ Normal(0, 10)\n    βAR ~ Normal(0, 10)\n    α ~ Normal(0, 100)\n\n    for i ∈ 1:length(y)\n        y[i] ~ Normal(α + βR * x₁[i] + βA * x₂[i] + βAR * x₁[i] * x₂[i], σ)\n    end\nend;Test to see that the model is sane. Use 2000 for now, as in the book. Need to set the same stepsize and adapt_delta as in Stan...Use Turing mcmcposterior = sample(m8_1stan(dd[:log_gdp], dd[:rugged], dd[:cont_africa]),\n    Turing.NUTS(2000, 200, 0.95));\n# Describe the posterior samples\ndescribe(posterior)┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:246\n[NUTS{Turing.FluxTrackerAD,Union{}}] found initial ϵ: 0.05\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:291\n┌ Info:  Adapted ϵ = 0.027030945408177368, std = [1.0, 1.0, 1.0, 1.0, 1.0]; 200 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 246.10006934400036;\n  #lf / sample        = 0.0015;\n  #evals / sample     = 45.228;\n  pre-cond. metric    = [1.0, 1.0, 1.0, 1.0, 1.0].\nIterations = 1:2000\nThinning interval = 1\nChains = 1\nSamples per chain = 2000\n\nEmpirical Posterior Estimates:\n              Mean           SD         Naive SE        MCSE         ESS   \n       α    9.188088348  0.396871357 0.00887431332 0.02039580300  378.63251\n  lf_num    0.001500000  0.067082039 0.00150000000 0.00150000000 2000.00000\n      βA   -1.911748293  0.332845971 0.00744266218 0.01678874483  393.05213\n      βR   -0.192567599  0.126597842 0.00283081381 0.00556124014  518.21420\n       σ    0.979277273  0.574983336 0.01285701826 0.02762306628  433.27811\n elapsed    0.123050035  0.112029348 0.00250505239 0.00365561704  939.16572\n epsilon    0.027775987  0.014520776 0.00032469443 0.00052470264  765.86669\neval_num   45.228000000 25.405328799 0.56808042184 0.61015166363 1733.70036\n     βAR    0.385937411  0.141733785 0.00316926379 0.00542323507  683.01448\n      lp -249.895980131 18.875323625 0.42206506722 1.26349762411  223.17213\n  lf_eps    0.027775987  0.014520776 0.00032469443 0.00052470264  765.86669\n\nQuantiles:\n              2.5%           25.0%          50.0%          75.0%          97.5%    \n       α    8.914525568    9.103290446    9.207484253    9.314196045    9.497320009\n  lf_num    0.000000000    0.000000000    0.000000000    0.000000000    0.000000000\n      βA   -2.387287116   -2.091614997   -1.914481358   -1.755178739   -1.471547382\n      βR   -0.354413189   -0.255736860   -0.194691494   -0.140923106   -0.038435717\n       σ    0.854148063    0.914868754    0.949824692    0.987314681    1.067955927\n elapsed    0.022774916    0.058130668    0.118208148    0.134882829    0.262489473\n epsilon    0.022700360    0.027030945    0.027030945    0.027030945    0.035644644\neval_num   10.000000000   22.000000000   46.000000000   46.000000000   94.000000000\n     βAR    0.108093386    0.298329907    0.381139774    0.475528425    0.658978123\n      lp -252.894911383 -249.602424413 -248.326264205 -247.445537812 -246.444371185\n  lf_eps    0.022700360    0.027030945    0.027030945    0.027030945    0.035644644Example of a Turing run simulation outputm81turing = \"\n             Mean                SD             Naive SE           MCSE             ESS\nα    9.2140454953  0.416410339 0.00931121825 0.0303436655  188.324543\nβA  -1.9414588557  0.373885658 0.00836033746 0.0583949856   40.994586\nβR  -0.1987645549  0.158902372 0.00355316505 0.0128657961  152.541295\nσ    0.9722532977  0.440031013 0.00983939257 0.0203736871  466.473854\nβAR  0.3951414223  0.187780491 0.00419889943 0.0276680621   46.062071\n\";Here\'s the map2stan output from rethinking, note above that SD is too largem81map2stan = \"\n       Mean StdDev lower 0.89 upper 0.89 n_eff Rhat\n a      9.24   0.14       9.03       9.47   291    1\n bR    -0.21   0.08      -0.32      -0.07   306    1\n bA    -1.97   0.23      -2.31      -1.58   351    1\n bAR    0.40   0.13       0.20       0.63   350    1\n sigma  0.95   0.05       0.86       1.03   566    1\n\";#-This notebook was generated using Literate.jl."
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

{
    "location": "#StatisticalRethinking.ScriptEntry",
    "page": "Functions",
    "title": "StatisticalRethinking.ScriptEntry",
    "category": "type",
    "text": "ScriptEntry\n\nDefine processing requirements for chapter scripts\n\nConstructor\n\nscriptentry(scriptfile;; nb=true, exe=true, doc=true)\n\nRequired arguments\n\n* `scriptfile::AbstractString`        : Script file\n\nOptional arguments\n\n* `nb::Bool`      : Generate a notebook version in notebooks directory\n* `exe::Bool`     : Execute the notebook (for testing or documentation purposes)\n* `doc::Bool`     : Insert documention into Github pages\n\nIf exe = false and doc = true it is assumed the appropriate .md files have been manually created and stored in docs/src/nn/... (Travis will terminate if runs take too long).\n\n\n\n\n\n"
},

{
    "location": "#ScriptEntry-1",
    "page": "Functions",
    "title": "ScriptEntry",
    "category": "section",
    "text": "ScriptEntry"
},

{
    "location": "#StatisticalRethinking.scriptentry-Tuple{Any}",
    "page": "Functions",
    "title": "StatisticalRethinking.scriptentry",
    "category": "method",
    "text": "scriptentry\n\nConstructor for ScriptEntry objects.\n\nConstructor\n\nscriptentry(scriptfile;; nb=true, exe=true, doc=true)\n\nRequired arguments\n\n* `scriptfile::AbstractString`        : Script file\n\nOptional arguments\n\n* `nb::Bool`      : Generate a notebook version in notebooks directory\n* `exe::Bool`     : Execute the notebook (for testing or documentation purposes)\n* `doc::Bool`     : Insert documention into Github pages\n\nIf exe = false and doc = true it is assumed the appropriate .md files have been manually created and stored in docs/src/nn/... (Travis will terminate if runs take too long).\n\n\n\n\n\n"
},

{
    "location": "#scriptentry-1",
    "page": "Functions",
    "title": "scriptentry",
    "category": "section",
    "text": "scriptentry(scriptfile; nb = true, exe = true, doc = true)"
},

{
    "location": "#StatisticalRethinking.link-NTuple{4,Any}",
    "page": "Functions",
    "title": "StatisticalRethinking.link",
    "category": "method",
    "text": "link\n\nCompute the link function\n\nMethod\n\nlink(xrange, chain, vars, xbar) \n\nRequired arguments\n\n* `xrange::Turing model`  : Range over which link values are computed\n* `chain::Float64`             : Chain samples used\n* `vars::Float64`               : Variables in chain used\n* `xbar::Float64`               : Mean value of observed predictor\n\nReturn values\n\n* `result`                       : Vector of link values\n\n\n\n\n\n"
},

{
    "location": "#link-1",
    "page": "Functions",
    "title": "link",
    "category": "section",
    "text": "link(xrange, chain, vars, xbar) "
},

]}
