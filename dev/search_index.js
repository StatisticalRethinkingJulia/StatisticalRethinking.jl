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
    "text": "This package contains Julia versions of selected code snippets and mcmc models contained in the R package \"rethinking\" associated with the book Statistical Rethinking by Richard McElreath.In the book and associated R package rethinking, statistical models are defined as illustrated below:flist <- alist(\n  height ~ dnorm( mu , sigma ) ,\n  mu <- a + b*weight ,\n  a ~ dnorm( 156 , 100 ) ,\n  b ~ dnorm( 0 , 10 ) ,\n  sigma ~ dunif( 0 , 50 )\n)Posterior values can be approximated by# Simulate quadratic approximation (for simpler models)\nm4.31 <- quad(flist, data=d2)or generated using Stan by:# Generate a Stan model and run a simulation\nm4.32 <- ulam(flist, data=d2)The author of the book states: \"If that (the statistical model) doesn\'t make much sense, good. ... you\'re holding the right textbook, since this book teaches you how to read and write these mathematical descriptions\" (page 77).The StatisticalRethinking.jl package is intended to allow experimenting with this learning process introducing 4 available mcmc options in Julia.The mcmc components are based on:TuringLang\nStanJulia\nMamba\nDynamicHMCAt least one other mcmc option is available for mcmc in Julia:KlaraTime constraints prevented this option to be in StatisticalRethinking.jl.A secondary objective of StatisticalRethinking.jl is to compare definition and executions of a variety of models in the above lited 4 mcmc options."
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
    "text": "Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:clip-01-03.jl - contains snippets 0.1 through 0.3\nclip-04-05.jl - contains snippets 0.4 and 0.5.These 2 files are in scripts/00 and later on processed by Literate.jl to create 3 derived versions, e.g. from clip_01_03.jl in scripts/00:clip-01-03.md - included in the documentation\nclip-01-03.ipynb - stored in the notebooks/chapter directory\nclip-01-03.jl - stored in the chapters/chapter directoryOccasionally lines in scripts are suppressed when Literate processes input source files, e.g. in Turing scripts the statement #nb Turing.turnprogress(false); is only inserted in the generated notebook but not in the corresponding chapter .jl script. Similarly #src ... will only be included in the .jl scripts in the chapters subdirectories.A single snippet clip will be referred to as 03/clip-02.jl. Models with names such as 08/m8.1t.jl, 04/m4.1s.jl, 04/m4.4m.jl and 04/m4.5d.jl generate mcmc samples using Turing.jl, CmdStan.jl, Mamba.jl or DynamicHMC.jl respectively. In some cases the results of the mcmc chains have been stored and retrieved (or regenerated if missing) in other clips, e.g. 04/clip-30s.jl.Scripts using Turing, Mamba, CmdStan or DynamicHMC need to import those, see the examples in 02/clip-08[m,s,t,d].jl."
},

{
    "location": "versions/#",
    "page": "Versions",
    "title": "Versions",
    "category": "page",
    "text": ""
},

{
    "location": "versions/#Versions-1",
    "page": "Versions",
    "title": "Versions",
    "category": "section",
    "text": "Developing rethinking must have been an on-going process over several years, StatisticalRethinkinh.jl will likely follow a similar path.The initial version (v1) of StatisticalRethinking is really just a first attempt to capture the models and show ways of setting up those models, execute the models and post-process the results using Julia.\nA second objective of v1 is to experiment and compare the four used mcmc options in Julia in terms of results, performance, ease of expressing models, etc.\nThe R package rethinking, in the experimental branch on Github, contains 2 functions quap and ulam (previously called map and map2stan) which are not in v1 of Statisticalrethinking.jl. It is my intention to study those and possibly include quap or ulam (or both) in a future of Statisticalrethinking.\nSeveral other interesting approaches that could become a good basis for such an endeavour are being explored in Julia, e.g. Soss.jl and Omega.jl.\nMany other R functions such as precis(), link(), shade(), etc. are not in v1, although some very early versions are being tested. Expect refactoring of those in future versions."
},

{
    "location": "notes/#",
    "page": "Notes",
    "title": "Notes",
    "category": "page",
    "text": ""
},

{
    "location": "notes/#Notes-1",
    "page": "Notes",
    "title": "Notes",
    "category": "section",
    "text": "In the src directory is a file scriptentry.jl which defines an object script_dict which is used to control the generation of documentation, notebooks and .jl scripts in chapters and testing of the notebooks. Output from CmdStan scripts are automatically inserted in the documentation. For Turing scripts this needs to be done manually by executing the notebook, exporting the results as .md files (and .svg files if graphics are generated) and copy these to docs/src/nn, where nn is the chapter. See ?ScriptEntry or enter e.g. script_dict[\"02\"] in the REPL.\nThe Mamba examples should really use @everywhere using Mamba in stead of using Mamba. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode. "
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
    "text": "Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8. The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer have been a great help and followed closely in several example scripts.The  documentation has been generated using Literate.jl and Documenter.jl based on several ideas demonstrated by Tamas Papp in above mentioned  DynamicHMCExamples.jl."
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
    "text": "Below dataset(...) provides access to often used R datasets. If this is not a common R dataset, see the chapter 4 snippets.cars = dataset(\"datasets\", \"cars\");\nfirst(cars, 5)Fit a linear regression of distance on speedm = lm(@formula(Dist ~ Speed), cars)estimated coefficients from the modelcoef(m)Plot residuals against speedscatter( cars[:Speed], residuals(m), xlab=\"Speed\",\nylab=\"Model residual values\", lab=\"Model residuals\")End of clip_04_05.jlThis page was generated using Literate.jl."
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/02/clip-06-07.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking, Optim\ngr(size=(600,300));"
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
    "location": "02/clip-08d/#",
    "page": "clip-08d",
    "title": "clip-08d",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/02/clip-08d.jl\""
},

{
    "location": "02/clip-08d/#Estimate-Binomial-draw-probabilility-1",
    "page": "clip-08d",
    "title": "Estimate Binomial draw probabilility",
    "category": "section",
    "text": "using StatisticalRethinking\nusing DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics\nusing Parameters, ForwardDiffDefine a structure to hold the data.struct BernoulliProblem\n    \"Total number of draws in the data.\"\n    n::Int\n    \"Number of draws `==1` in the data\"\n    s::Vector{Int}\nend;Make the type callable with the parameters as a single argument.function (problem::BernoulliProblem)((α, )::NamedTuple{(:α, )})\n    @unpack n, s = problem        # extract the data\n    loglikelihood(Binomial(n, α), s)\nendCreate the data and complete setting up the problem.obs = rand(Binomial(9, 2/3), 1)\np = BernoulliProblem(9, obs)\np((α = 0.5, ))Use a flat priors (the default, omitted) for αP = TransformedLogDensity(as((α = as𝕀,)), p)\n∇P = ADgradient(:ForwardDiff, P);Samplechain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000)To get the posterior for α use get_position and then transform back.posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));Extract the parameter.posterior_α = first.(posterior);check the effective sample sizeess_α = effective_sample_size(posterior_α)NUTS-specific statisticsNUTS_statistics(chain)check the meanmean(posterior_α)This page was generated using Literate.jl."
},

{
    "location": "02/clip-08s/#",
    "page": "clip-08s",
    "title": "clip-08s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/02/clip-08s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"02\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 15\nd = Binomial(9, 0.66)\nn2 = Int.(9 * ones(Int, N2));Show first 5 (generated) observationsk2 = rand(d, N2);\nk2[1:min(5, N2)]Input data for cmdstanbinomialdata = Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2);Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Allocate array of Normal fitsfits = Vector{Normal{Float64}}(undef, 4)\nfor i in 1:4\n  fits[i] = fit_mle(Normal, convert.(Float64, chn.value[:, 1, i]))\n  println(fits[i])\nendPlot the 4 chainsmu_avg = sum([fits[i].μ for i in 1:4]) / 4.0;\nsigma_avg = sum([fits[i].σ for i in 1:4]) / 4.0;\n\nif rc == 0\n  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\n  x = 0:0.001:1\n  for i in 1:4\n    vals = convert.(Float64, chn.value[:, 1, i])\n    μ = round(fits[i].μ, digits=2)\n    σ = round(fits[i].σ, digits=2)\n    p[i] = density(vals, lab=\"Chain $i density\",\n       xlim=(0.45, 1.0), title=\"$(N2) data points\")\n    plot!(p[i], x, pdf.(Normal(fits[i].μ, fits[i].σ), x), lab=\"Fitted Normal($μ, $σ)\")\n  end\n  plot(p..., layout=(4, 1))\nendCompute at hpd regionbnds = MCMCChain.hpd(chn[:, 1, :], alpha=0.055);Show hpd regionprintln(\"hpd bounds = $bnds\\n\")quadratic approximationCompute MAP, compare with CmndStan & MLEtmp = convert(Array{Float64,3}, chn.value)\ndraws = reshape(tmp, (size(tmp, 1)*size(tmp, 3)),)Compute MAPusing Optim\n\nx0 = [0.5]\nlower = [0.2]\nupper = [1.0]\n\ninner_optimizer = GradientDescent()\n\nfunction loglik(x)\n  ll = 0.0\n  ll += log.(pdf.(Beta(1, 1), x[1]))\n  ll += sum(log.(pdf.(Binomial(9, x[1]), k2)))\n  -ll\nend\n\nres = optimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))Summarize mean and sd estimatesCmdStan mean and sd:[mean(chn.value), std(chn.value)]MAP estimate and associated sd:[Optim.minimizer(res)[1], std(draws, mean=mean(chn.value))]MLE of mean and sd:[mu_avg, sigma_avg]Turing Chain &  89% hpd region boundariesplot( x, pdf.(Normal( mu_avg , sigma_avg  ) , x ),\nxlim=(0.0, 1.2), lab=\"Normal approximation using MLE\")\nplot!( x, pdf.(Normal( Optim.minimizer(res)[1] , std(draws, mean=mean(chn.value))) , x),\nlab=\"Normal approximation using MAP\")\ndensity!(draws, lab=\"CmdStan chain\")\nvline!([bnds.value[1]], line=:dash, lab=\"hpd lower bound\")\nvline!([bnds.value[2]], line=:dash, lab=\"hpd upper bound\")End of clip_08s.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip-08t/#",
    "page": "clip-08t",
    "title": "clip-08t",
    "category": "page",
    "text": "Load Julia packages (libraries) neededusing StatisticalRethinking\nusing Optim, Turing, Flux.Tracker\ngr(size=(600,300));loadedTuring.setadbackend(:reverse_diff);\nTuring.turnprogress(false)┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/Turing.jl:81\n\n\n\n\n\nfalse"
},

{
    "location": "02/clip-08t/#snippet-2.8t-1",
    "page": "clip-08t",
    "title": "snippet 2.8t",
    "category": "section",
    "text": "Define the datak = 6; n = 9;Define the model@model globe_toss(n, k) = begin\n  theta ~ Beta(1, 1) # prior\n  k ~ Binomial(n, theta) # model\n  return k, theta\nend;Compute the \"maximumaposteriori\" valueSet search boundslb = [0.0]; ub = [1.0];Create (compile) the modelmodel = globe_toss(n, k);Compute the maximumaposterioriresult = maximum_a_posteriori(model, lb, ub)Results of Optimization Algorithm\n * Algorithm: Fminbox with L-BFGS\n * Starting Point: [0.5278344803167265]\n * Minimizer: [0.6666666666021692]\n * Minimum: 1.297811e+00\n * Iterations: 3\n * Convergence: true\n   * |x - x\'| ≤ 0.0e+00: false \n     |x - x\'| = 4.62e-08 \n   * |f(x) - f(x\')| ≤ 0.0e+00 |f(x)|: false\n     |f(x) - f(x\')| = 3.35e-14 |f(x)|\n   * |g(x)| ≤ 1.0e-08: true \n     |g(x)| = 1.87e-09 \n   * Stopped by an increasing objective: false\n   * Reached Maximum Number of Iterations: false\n * Objective Calls: 43\n * Gradient Calls: 43Use Turing mcmcchn = sample(model, NUTS(2000, 200, 0.65));┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/samplers/support/hmc_core.jl:246\n[NUTS{Turing.FluxTrackerAD,Union{}}] found initial ϵ: 0.4\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/samplers/support/hmc_core.jl:291\n┌ Info:  Adapted ϵ = 1.0169708384755447, std = [1.0]; 200 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 4.928556796000006;\n  #lf / sample        = 0.002;\n  #evals / sample     = 6.539;\n  pre-cond. metric    = [1.0].Look at the generated draws (in chn)describe(chn)Iterations = 1:2000\nThinning interval = 1\nChains = 1\nSamples per chain = 2000\n\nEmpirical Posterior Estimates:\n              Mean          SD       Naive SE       MCSE        ESS   \n  lf_num  0.0020000000 0.089442719 0.0020000000 0.0020000000 2000.0000\n elapsed  0.0024642784 0.075235635 0.0016823199 0.0021980359 1171.5953\n epsilon  1.0548866415 0.461890119 0.0103281770 0.0271973584  288.4190\n   theta  0.6320118370 0.139384359 0.0031167290 0.0049144284  804.4185\n      lp -3.3031059558 0.785831841 0.0175717342 0.0220789561 1266.7828\neval_num  6.5390000000 3.424812940 0.0765811454 0.1028281653 1109.3013\n  lf_eps  1.0548866415 0.461890119 0.0103281770 0.0271973584  288.4190\n\nQuantiles:\n              2.5%         25.0%         50.0%         75.0%         97.5%    \n  lf_num  0.0000000000  0.0000000000  0.0000000000  0.000000000  0.00000000000\n elapsed  0.0001347157  0.0001382845  0.0001499945  0.000359588  0.00055348215\n epsilon  0.5855121691  1.0169708385  1.0169708385  1.016970838  1.76718835045\n   theta  0.3244780718  0.5476709438  0.6403916720  0.734694037  0.87726562376\n      lp -5.5307004970 -3.4356358751 -2.9975359347 -2.822909944 -2.77975955697\neval_num  4.0000000000  4.0000000000  4.0000000000 10.000000000 10.00000000000\n  lf_eps  0.5855121691  1.0169708385  1.0169708385  1.016970838  1.76718835045Look at the mean and sdprintln(\"\\ntheta = $(mean_and_std(chn[:theta][201:2000]))\\n\")theta = (0.6339059485766951, 0.13765016043159534)Fix the inclusion of adaptation sampleschn2 = MCMCChain.Chains(chn.value[201:2000,:,:], names=chn.names)Object of type \"Chains{Float64}\"\n\nIterations = 1:1800\nThinning interval = 1\nChains = 1\nSamples per chain = 1800\n\nUnion{Missing, Float64}[0.0 0.0245762 … 22.0 1.01697; 0.0 0.000412524 … 4.0 1.01697; … ; 0.0 0.000145242 … 4.0 1.01697; 0.0 0.000145184 … 4.0 1.01697]Look at the proper draws (in corrected chn2)describe(chn2)Iterations = 1:1800\nThinning interval = 1\nChains = 1\nSamples per chain = 1800\n\nEmpirical Posterior Estimates:\n              Mean                  SD                     Naive SE               MCSE         ESS   \n  lf_num  0.00000000000 0.00000000000000000000000 0.000000000000000000000000 0.000000000000       NaN\n elapsed  0.00026535625 0.00064334605836867853230 0.000015163812017404300952 0.000019084184 1136.4284\n epsilon  1.01697083848 0.00000000000000066631893 0.000000000000000015705288 0.000000000000 1800.0000\n   theta  0.63390594858 0.13765016043159533642992 0.003244445395753241690590 0.005260408830  684.7223\n      lp -3.29160972548 0.75270133426860552638971 0.017741340588983106618670 0.020840661177 1304.4348\neval_num  6.41666666667 2.96388302012344873048733 0.069859392739098497004946 0.059765336315 1800.0000\n  lf_eps  1.01697083848 0.00000000000000066631893 0.000000000000000015705288 0.000000000000 1800.0000\n\nQuantiles:\n              2.5%           25.0%        50.0%         75.0%          97.5%    \n  lf_num  0.00000000000  0.00000000000  0.00000000  0.00000000000  0.00000000000\n elapsed  0.00013467397  0.00013860325  0.00014983  0.00035968725  0.00048772625\n epsilon  1.01697083848  1.01697083848  1.01697084  1.01697083848  1.01697083848\n   theta  0.33090315595  0.54872730536  0.64026470  0.73821364480  0.87726562376\n      lp -5.50759395812 -3.43606207112 -3.00188591 -2.82229156435 -2.77975601301\neval_num  4.00000000000  4.00000000000  4.00000000 10.00000000000 10.00000000000\n  lf_eps  1.01697083848  1.01697083848  1.01697084  1.01697083848  1.01697083848Compute at hpd regionbnds = MCMCChain.hpd(chn2[:, 4, :], alpha=0.06);analytical calculationw = 6; n = 9; x = 0:0.01:1\nplot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab=\"Conjugate solution\")(Image: svg)quadratic approximationplot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")(Image: svg)Turing Chain &  89%hpd region boundariesdensity!(chn2[:theta], lab=\"Turing chain\")\nvline!([bnds[1]], line=:dash, lab=\"hpd lower bound\")\nvline!([bnds[2]], line=:dash, lab=\"hpd upper bound\")MethodError: no method matching getindex(::Chains{Float64}, ::Symbol)\nClosest candidates are:\n  getindex(::Chains, ::Any, !Matched::Any, !Matched::Any) at /Users/rob/.julia/packages/MCMCChain/wl69W/src/chains.jl:110\n  getindex(::Any, !Matched::AbstractTrees.ImplicitRootState) at /Users/rob/.julia/packages/AbstractTrees/z1wBY/src/AbstractTrees.jl:344\n\n\n\nStacktrace:\n\n [1] top-level scope at In[16]:1Show hpd regionprintln(\"hpd bounds = $bnds\\n\")hpd bounds =       94% Lower 94% Upper\ntheta 0.3873379 0.9004367End of clip_08t.jlThis notebook was generated using Literate.jl."
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
    "location": "04/m4.1d/#",
    "page": "m4.1d",
    "title": "m4.1d",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.1d.jl\""
},

{
    "location": "04/m4.1d/#Heights-problem-1",
    "page": "m4.1d",
    "title": "Heights problem",
    "category": "section",
    "text": "We estimate simple linear regression model with a half-T prior.using StatisticalRethinking\nusing DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics\nusing Parameters, ForwardDiff\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)Import the dataset.howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\');\ndf = convert(DataFrame, howell1);Use only adults and standardizedf2 = filter(row -> row[:age] >= 18, df);Show the first six rows of the dataset.first(df2, 6)Half-T for σ, see below.struct HeightsProblem{TY <: AbstractVector, Tν <: Real}\n    \"Observations.\"\n    y::TY\n    \"Degrees of freedom for prior on sigma.\"\n    ν::Tν\nend;Then make the type callable with the parameters as a single argument.function (problem::HeightsProblem)(θ)\n    @unpack y, ν = problem   # extract the data\n    @unpack μ, σ = θ\n    loglikelihood(Normal(μ, σ), y) + logpdf(TDist(ν), σ)\nend;Setup problem with data and inits.obs = convert(Vector{Float64}, df2[:height]);\np = HeightsProblem(obs, 1.0);\np((μ = 178, σ = 5.0,))Wrap the problem with a transformation, then use Flux for the gradient.P = TransformedLogDensity(as((σ = asℝ₊, μ  = as(Real, 100, 250))), p)\n∇P = ADgradient(:ForwardDiff, P);Tune and sample.chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);We use the transformation to obtain the posterior from the chain.posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));Extract the parameter posterior means: β,posterior_μ = mean(last, posterior)then σ:posterior_σ = mean(first, posterior)Effective sample sizes (of untransformed draws)ess = mapslices(effective_sample_size,\n                get_position_matrix(chain); dims = 1)NUTS-specific statisticsNUTS_statistics(chain)\n\ncmdstan_result = \"\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean        SD       Naive SE      MCSE      ESS\nsigma   7.7641872 0.29928194 0.004732063 0.0055677898 1000\n   mu 154.6055177 0.41989355 0.006639100 0.0085038356 1000\n\nQuantiles:\n         2.5%      25.0%       50.0%      75.0%       97.5%\nsigma   7.21853   7.5560625   7.751355   7.9566775   8.410391\n   mu 153.77992 154.3157500 154.602000 154.8820000 155.431000\n\";Extract the parameter posterior means: β,[posterior_μ, posterior_σ]end of m4.5d.jl#- This page was generated using Literate.jl."
},

{
    "location": "04/m4.1s/#",
    "page": "m4.1s",
    "title": "m4.1s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.1s.jl\"using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)\n\nhowell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);\n\ndf2 = filter(row -> row[:age] >= 18, df)\nfirst(df2, 5)\n\nheightsmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  real<lower=0> h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=0,upper=250> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ normal(178, 20);\n  sigma ~ uniform( 0 , 50 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\";\n\nstanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain);\n\nheightsdata = Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height]);\n\nrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);\n\ndescribe(chn)\n\nserialize(\"m4.1s.jls\", chn)\nchn2 = deserialize(\"m4.1s.jls\")\n\ndescribe(chn2)end of m4.1s#- This page was generated using Literate.jl."
},

{
    "location": "04/m4.2d/#",
    "page": "m4.2d",
    "title": "m4.2d",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.2d.jl\""
},

{
    "location": "04/m4.2d/#Heights-problem-with-restricted-prior-on-mu.-1",
    "page": "m4.2d",
    "title": "Heights problem with restricted prior on mu.",
    "category": "section",
    "text": "Result is not conform cmdstan resultusing StatisticalRethinking\nusing DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics\nusing Parameters, ForwardDiff\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)Import the dataset.howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adults and standardizedf2 = filter(row -> row[:age] >= 18, df);Show the first six rows of the dataset.first(df2, 6)No covariates, just height observations.struct ConstraintHeightsProblem{TY <: AbstractVector}\n    \"Observations.\"\n    y::TY\nend;Very constraint prior on μ. Flat σ.function (problem::ConstraintHeightsProblem)(θ)\n    @unpack y = problem   # extract the data\n    @unpack μ, σ = θ\n    loglikelihood(Normal(μ, σ), y) + logpdf(Normal(178, 0.1), μ) +\n    logpdf(Uniform(0, 50), σ)\nend;Define problem with data and inits.obs = convert(Vector{Float64}, df2[:height])\np = ConstraintHeightsProblem(obs);\np((μ = 178, σ = 5.0))Wrap the problem with a transformation, then use Flux for the gradient.P = TransformedLogDensity(as((μ  = as(Real, 100, 250), σ = asℝ₊)), p)\n∇P = ADgradient(:ForwardDiff, P);FSample from the posterior.chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);Undo the transformation to obtain the posterior from the chain.posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));Extract the parameter posterior means: μ,posterior_μ = mean(first, posterior)Extract the parameter posterior means: μ,posterior_σ = mean(last, posterior)Effective sample sizes (of untransformed draws)ess = mapslices(effective_sample_size,\n                get_position_matrix(chain); dims = 1)NUTS-specific statisticsNUTS_statistics(chain)cmdstan resultcmdstan_result = \"\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n         Mean         SD       Naive SE       MCSE      ESS\nsigma  24.604616 0.946911707 0.0149719887 0.0162406632 1000\n   mu 177.864069 0.102284043 0.0016172527 0.0013514459 1000\n\nQuantiles:\n         2.5%       25.0%     50.0%     75.0%     97.5%\nsigma  22.826377  23.942275  24.56935  25.2294  26.528368\n   mu 177.665000 177.797000 177.86400 177.9310 178.066000\n\";Extract the parameter posterior means: β,[posterior_μ, posterior_σ]end of m4.5d.jl#- This page was generated using Literate.jl."
},

{
    "location": "04/m4.2s/#",
    "page": "m4.2s",
    "title": "m4.2s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.2s.jl\"using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)\n\nhowell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);\n\ndf2 = filter(row -> row[:age] >= 18, df)\n#mean_height = mean(df2[:height])\ndf2[:height_c] = convert(Vector{Float64}, df2[:height]) # .- mean_height\nfirst(df2, 5)\n\nmax_height_c = maximum(df2[:height_c])\nmin_height_c = minimum(df2[:height_c])\n\nheightsmodel = \"\ndata {\n  int N;\n  real h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=$(min_height_c),upper=$(max_height_c)> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ normal(178, 0.1);\n  sigma ~ uniform( 0 , 50 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\";\n\nstanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain);\n\nheightsdata = Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height_c]);\n\nrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);\n\ndescribe(chn)\n\nserialize(\"m4.2s.jls\", chn)\n\nchn2 = deserialize(\"m4.2s.jls\")\n\ndescribe(chn2)end of m4.2s#- This page was generated using Literate.jl."
},

{
    "location": "04/m4.2t/#",
    "page": "m4.2t",
    "title": "m4.2t",
    "category": "page",
    "text": "using StatisticalRethinking, Turing\ngr(size=(500,500));\n\nTuring.setadbackend(:reverse_diff);\nTuring.turnprogress(false);\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)┌ Info: Recompiling stale cache file /Users/rob/.julia/compiled/v1.2/StatisticalRethinking/zZGTK.ji for StatisticalRethinking [2d09df54-9d0f-5258-8220-54c2a3d4fbee]\n└ @ Base loading.jl:1184\n\n\nloaded\n\n\n┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/Turing.jl:81"
},

{
    "location": "04/m4.2t/#snippet-4.43-1",
    "page": "m4.2t",
    "title": "snippet 4.43",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adults and center the weight observationsdf2 = filter(row -> row[:age] >= 18, df);\nmean_weight = mean(df2[:weight]);\ndf2[:weight_c] = df2[:weight] .- mean_weight;\nfirst(df2, 5)<table class=\"data-frame\"><thead><tr><th></th><th>height</th><th>weight</th><th>age</th><th>male</th><th>weight_c</th></tr><tr><th></th><th>Float64⍰</th><th>Float64⍰</th><th>Float64⍰</th><th>Int64⍰</th><th>Float64</th></tr></thead><tbody><p>5 rows × 5 columns</p><tr><th>1</th><td>151.765</td><td>47.8256</td><td>63.0</td><td>1</td><td>2.83512</td></tr><tr><th>2</th><td>139.7</td><td>36.4858</td><td>63.0</td><td>0</td><td>-8.50468</td></tr><tr><th>3</th><td>136.525</td><td>31.8648</td><td>65.0</td><td>0</td><td>-13.1256</td></tr><tr><th>4</th><td>156.845</td><td>53.0419</td><td>41.0</td><td>1</td><td>8.05143</td></tr><tr><th>5</th><td>145.415</td><td>41.2769</td><td>51.0</td><td>0</td><td>-3.71361</td></tr></tbody></table>Extract variables for Turing modely = convert(Vector{Float64}, df2[:height]);\nx = convert(Vector{Float64}, df2[:weight_c]);Define the regression model@model line(y, x) = begin\n    #priors\n    alpha ~ Normal(178.0, 100.0)\n    beta ~ Normal(0.0, 10.0)\n    s ~ Uniform(0, 50)\n\n    #model\n    mu = alpha .+ beta*x\n    for i in 1:length(y)\n      y[i] ~ Normal(mu[i], s)\n    end\nend;Draw the samplessamples = 5000\nadapt_cycles = 1000\n\n@time chn = sample(line(y, x), Turing.NUTS(samples, adapt_cycles, 0.65));\ndraws = adapt_cycles:samples┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/samplers/support/hmc_core.jl:246\n[NUTS{Turing.FluxTrackerAD,Union{}}] found initial ϵ: 0.000390625\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/samplers/support/hmc_core.jl:291\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/core/ad.jl:154\n┌ Warning: grad = [-0.868951, 2.91199, NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/core/ad.jl:155\n┌ Info:  Adapted ϵ = 0.041860226335948374, std = [1.0, 1.0, 1.0]; 1000 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/0dgDY/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 485.25370896200036;\n  #lf / sample        = 0.002;\n  #evals / sample     = 22.1268;\n  pre-cond. metric    = [1.0, 1.0, 1.0].\n493.649833 seconds (3.66 G allocations: 239.349 GiB, 17.16% gc time)\n\n\n\n\n\n1000:5000Describe the chain resultdescribe(chn)Iterations = 1:5000\nThinning interval = 1\nChains = 1\nSamples per chain = 5000\n\nEmpirical Posterior Estimates:\n              Mean           SD        Naive SE        MCSE         ESS    \n   alpha   153.47123243   9.12967259 0.1291130680  1.0267480488   79.064701\n    beta     0.90591051   0.07815896 0.0011053346  0.0010737306 5000.000000\n  lf_num     0.00200000   0.14142136 0.0020000000  0.0020000000 5000.000000\n       s     5.76486187   4.57685223 0.0647264649  0.6029141598   57.626576\n elapsed     0.09705074   0.11271063 0.0015939690  0.0019873894 3216.353938\n epsilon     0.05318071   0.10149160 0.0014353079  0.0072827072  194.211293\n      lp -1104.09161228 158.14864994 2.2365596562 18.1730731871   75.731093\neval_num    22.12680000  17.73624641 0.2508284022  0.3240256276 2996.157964\n  lf_eps     0.05318071   0.10149160 0.0014353079  0.0072827072  194.211293\n\nQuantiles:\n               2.5%           25.0%           50.0%           75.0%           97.5%     \n   alpha   146.939752779   154.388681845   154.579703935   154.777427052   155.087429096\n    beta     0.814993152     0.875580428     0.904885192     0.933355147     0.993297040\n  lf_num     0.000000000     0.000000000     0.000000000     0.000000000     0.000000000\n       s     4.747709767     4.975318395     5.106359264     5.244962939     9.418924511\n elapsed     0.011062591     0.039201472     0.052278239     0.141286437     0.296676763\n epsilon     0.029759657     0.041860226     0.041860226     0.041860226     0.118315849\n      lp -1291.295038082 -1084.314581281 -1083.395048080 -1082.824366313 -1082.304660680\neval_num     4.000000000    10.000000000    10.000000000    34.000000000    58.000000000\n  lf_eps     0.029759657     0.041860226     0.041860226     0.041860226     0.118315849Show corrected results (drop adaptation samples)for var in [:alpha, :beta, :s]\n  describe(chn[Symbol(var)][draws])\n  println(\"$var = \",  mean_and_std(chn[Symbol(var)][draws]))\nendSummary Stats:\nMean:           154.588156\nMinimum:        153.622115\n1st Quartile:   154.419013\nMedian:         154.586628\n3rd Quartile:   154.777065\nMaximum:        155.549980\nLength:         4001\nType:           Float64\nalpha = (154.58815597694613, 0.2563223512827998)\nSummary Stats:\nMean:           0.905479\nMinimum:        0.760774\n1st Quartile:   0.876522\nMedian:         0.905549\n3rd Quartile:   0.933571\nMaximum:        1.045151\nLength:         4001\nType:           Float64\nbeta = (0.9054792962537588, 0.042667112964585974)\nSummary Stats:\nMean:           5.103198\nMinimum:        4.363082\n1st Quartile:   4.968124\nMedian:         5.094436\n3rd Quartile:   5.233923\nMaximum:        5.921219\nLength:         4001\nType:           Float64\ns = (5.103197848095711, 0.19675670369150214)Compare with a previous resultclip_43s_example_output = \"\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n         Mean        SD       Naive SE       MCSE      ESS\nalpha 154.597086 0.27326431 0.0043206882 0.0036304132 1000\n beta   0.906380 0.04143488 0.0006551430 0.0006994720 1000\nsigma   5.106643 0.19345409 0.0030587777 0.0032035103 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 154.0610000 154.4150000 154.5980000 154.7812500 155.1260000\n beta   0.8255494   0.8790695   0.9057435   0.9336445   0.9882981\nsigma   4.7524368   4.9683400   5.0994450   5.2353100   5.5090128\n\";Plot the regerssion line and observationsscatter(x, y, lab=\"Observations\", xlab=\"weight\", ylab=\"height\")\nxi = -15.0:0.1:15.0\nyi = mean(chn[:alpha]) .+ mean(chn[:beta])*xi\nplot!(xi, yi, lab=\"Regression line\")(Image: svg)End of clip_43t.jlThis notebook was generated using Literate.jl."
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
    "location": "04/m4.4s/#",
    "page": "m4.4s",
    "title": "m4.4s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.4s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/m4.4s/#snippet-4.7-1",
    "page": "m4.4s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)\nmean_weight = mean(df2[:weight])\ndf2[:weight_c] = convert(Vector{Float64}, df2[:weight]) .- mean_weight ;Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight_c]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Save the chains in a JLS fileserialize(\"m4.4s.jls\", chn)\n\nchn2 = deserialize(\"m4.4s.jls\")Should be identical to earlier resultdescribe(chn2)End of m4.4s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/m4.5d/#",
    "page": "m4.5d",
    "title": "m4.5d",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.5d.jl\""
},

{
    "location": "04/m4.5d/#Polynomial-weight-model-model-1",
    "page": "m4.5d",
    "title": "Polynomial weight model model",
    "category": "section",
    "text": "using StatisticalRethinking\nusing DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics\nusing Parameters, ForwardDiff\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)Import the dataset.howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adults and standardizedf2 = filter(row -> row[:age] >= 18, df);\ndf2[:weight] = convert(Vector{Float64}, df2[:weight]);\ndf2[:weight_s] = (df2[:weight] .- mean(df2[:weight])) / std(df2[:weight]);\ndf2[:weight_s2] = df2[:weight_s] .^ 2;Show the first six rows of the dataset.first(df2, 6)Then define a structure to hold the data: observables, covariates, and the degrees of freedom for the prior.Linear regression model y  Xβ + ϵ, where ϵ  N(0 σ²) IID.struct ConstraintHeightProblem{TY <: AbstractVector, TX <: AbstractMatrix}\n    \"Observations.\"\n    y::TY\n    \"Covariates\"\n    X::TX\nend;Then make the type callable with the parameters as a single argument.function (problem::ConstraintHeightProblem)(θ)\n    @unpack y, X, = problem   # extract the data\n    @unpack β, σ = θ            # works on the named tuple too\n    ll = 0.0\n    ll += logpdf(Normal(178, 100), X[1]) # a = X[1]\n    ll += logpdf(Normal(0, 10), X[2]) # b1 = X[2]\n    ll += logpdf(Normal(0, 10), X[3]) # b2 = X[3]\n    ll += logpdf(TDist(1.0), σ)\n    ll += loglikelihood(Normal(0, σ), y .- X*β)\n    ll\nendSetup data and inits.N = size(df2, 1)\nX = hcat(ones(N), hcat(df2[:weight_s], df2[:weight_s2]));\ny = convert(Vector{Float64}, df2[:height])\np = ConstraintHeightProblem(y, X);\np((β = [1.0, 2.0, 3.0], σ = 1.0))Use a function to return the transformation (as it varies with the number of covariates).problem_transformation(p::ConstraintHeightProblem) =\n    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))Wrap the problem with a transformation, then use Flux for the gradient.P = TransformedLogDensity(problem_transformation(p), p)\n∇P = ADgradient(:ForwardDiff, P);Draw samples.chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);We use the transformation to obtain the posterior from the chain.posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));\nposterior[1:5]Extract the parameter posterior means: β,posterior_β = mean(first, posterior)then σ:posterior_σ = mean(last, posterior)Effective sample sizes (of untransformed draws)ess = mapslices(effective_sample_size,\n                get_position_matrix(chain); dims = 1)NUTS-specific statisticsNUTS_statistics(chain)\n\ncmdstan_result = \"\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n           Mean         SD       Naive SE       MCSE      ESS\n    a 154.609019750 0.36158389 0.0057171433 0.0071845548 1000\n   b1   5.838431778 0.27920926 0.0044146860 0.0048693502 1000\n   b2  -0.009985954 0.22897191 0.0036203637 0.0047224478 1000\nsigma   5.110136300 0.19096315 0.0030193925 0.0030728192 1000\n\nQuantiles:\n          2.5%        25.0%        50.0%       75.0%        97.5%\n    a 153.92392500 154.3567500 154.60700000 154.8502500 155.32100000\n   b1   5.27846200   5.6493250   5.83991000   6.0276275   6.39728200\n   b2  -0.45954687  -0.1668285  -0.01382935   0.1423620   0.43600905\nsigma   4.76114350   4.9816850   5.10326000   5.2300450   5.51500975\n\";Extract the parameter posterior means: β,[posterior_β, posterior_σ]end of m4.5d.jl#- This page was generated using Literate.jl."
},

{
    "location": "04/m4.5d1/#",
    "page": "m4.5d1",
    "title": "m4.5d1",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.5d1.jl\""
},

{
    "location": "04/m4.5d1/#Linear-regression-1",
    "page": "m4.5d1",
    "title": "Linear regression",
    "category": "section",
    "text": "We estimate simple linear regression model with a half-T prior. First, we load the packages we use.using StatisticalRethinking\nusing DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics\nusing Parameters, ForwardDiff\n\nProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)Import the dataset.howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adults and standardizedf2 = filter(row -> row[:age] >= 18, df)\ndf2[:weight] = convert(Vector{Float64}, df2[:weight]);\ndf2[:weight_s] = (df2[:weight] .- mean(df2[:weight])) / std(df2[:weight]);\ndf2[:weight_s2] = df2[:weight_s] .^ 2;Show the first six rows of the dataset.first(df2, 6)Then define a structure to hold the data: observables, covariates, and the degrees of freedom for the prior.\"\"\"\nLinear regression model ``y ∼ Xβ + ϵ``, where ``ϵ ∼ N(0, σ²)`` IID.\nFlat prior for `β`, half-T for `σ`.\n\"\"\"\nstruct LinearRegressionProblem{TY <: AbstractVector, TX <: AbstractMatrix,\nTν <: Real}\n    \"Observations.\"\n    y::TY\n    \"Covariates\"\n    X::TX\n    \"Degrees of freedom for prior.\"\n    ν::Tν\nendThen make the type callable with the parameters as a single argument.function (problem::LinearRegressionProblem)(θ)\n    @unpack y, X, ν = problem   # extract the data\n    @unpack β, σ = θ            # works on the named tuple too\n    loglikelihood(Normal(0, σ), y .- X*β) + logpdf(TDist(ν), σ)\nendWe should test this, also, this would be a good place to benchmark and optimize more complicated problems.N = size(df2, 1)\nX = hcat(ones(N), hcat(df2[:weight_s], df2[:weight_s2]));\ny = convert(Vector{Float64}, df2[:height])\np = LinearRegressionProblem(y, X, 1.0);\np((β = [1.0, 2.0, 3.0], σ = 1.0))For this problem, we write a function to return the transformation (as it varies with the number of covariates).problem_transformation(p::LinearRegressionProblem) =\n    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))Wrap the problem with a transformation, then use Flux for the gradient.P = TransformedLogDensity(problem_transformation(p), p)\n∇P = ADgradient(:ForwardDiff, P);Finally, we sample from the posterior. chain holds the chain (positions and diagnostic information), while the second returned value is the tuned sampler which would allow continuation of sampling.chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);We use the transformation to obtain the posterior from the chain.posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));\nposterior[1:5]Extract the parameter posterior means: β,posterior_β = mean(first, posterior)then σ:posterior_σ = mean(last, posterior)Effective sample sizes (of untransformed draws)ess = mapslices(effective_sample_size,\n                get_position_matrix(chain); dims = 1)NUTS-specific statisticsNUTS_statistics(chain)\n\ncmdstan_result = \"\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n           Mean         SD       Naive SE       MCSE      ESS\n    a 154.609019750 0.36158389 0.0057171433 0.0071845548 1000\n   b1   5.838431778 0.27920926 0.0044146860 0.0048693502 1000\n   b2  -0.009985954 0.22897191 0.0036203637 0.0047224478 1000\nsigma   5.110136300 0.19096315 0.0030193925 0.0030728192 1000\n\nQuantiles:\n          2.5%        25.0%        50.0%       75.0%        97.5%\n    a 153.92392500 154.3567500 154.60700000 154.8502500 155.32100000\n   b1   5.27846200   5.6493250   5.83991000   6.0276275   6.39728200\n   b2  -0.45954687  -0.1668285  -0.01382935   0.1423620   0.43600905\nsigma   4.76114350   4.9816850   5.10326000   5.2300450   5.51500975\n\";Extract the parameter posterior means: β,[posterior_β, posterior_σ]end of m4.5d.jl#- This page was generated using Literate.jl."
},

{
    "location": "04/m4.5s/#",
    "page": "m4.5s",
    "title": "m4.5s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/m4.5s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/m4.5s/#snippet-4.7-1",
    "page": "m4.5s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)\ndf2[:height] = convert(Vector{Float64}, df2[:height]);\ndf2[:weight] = convert(Vector{Float64}, df2[:weight]);\ndf2[:weight_s] = (df2[:weight] .- mean(df2[:weight])) / std(df2[:weight]);\ndf2[:weight_s2] = df2[:weight_s] .^ 2;Define the Stan language modelweightsmodel = \"\ndata{\n    int N;\n    real height[N];\n    real weight_s2[N];\n    real weight_s[N];\n}\nparameters{\n    real a;\n    real b1;\n    real b2;\n    real sigma;\n}\nmodel{\n    vector[N] mu;\n    sigma ~ uniform( 0 , 50 );\n    b2 ~ normal( 0 , 10 );\n    b1 ~ normal( 0 , 10 );\n    a ~ normal( 178 , 100 );\n    for ( i in 1:N ) {\n        mu[i] = a + b1 * weight_s[i] + b2 * weight_s2[i];\n    }\n    height ~ normal( mu , sigma );\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"a\", \"b1\", \"b2\", \"sigma\"],\nmodel=weightsmodel,  output_format=:mcmcchain);Input data for cmdstanheightsdata = Dict(\"N\" => size(df2, 1), \"height\" => df2[:height],\n\"weight_s\" => df2[:weight_s], \"weight_s2\" => df2[:weight_s2]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\nCmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)End of m4.5s.jlThis page was generated using Literate.jl."
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
    "text": "Show first 5 rows of DataFrame dffirst(df, 5)"
},

{
    "location": "04/clip-07-13s/#snippet-4.9-1",
    "page": "clip-07-13s",
    "title": "snippet 4.9",
    "category": "section",
    "text": "Show first 5 heigth values in dfdf[:height][1:5]"
},

{
    "location": "04/clip-07-13s/#snippet-4.10-1",
    "page": "clip-07-13s",
    "title": "snippet 4.10",
    "category": "section",
    "text": "Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Our model:m4_1 = \"\n  height ~ Normal(μ, σ) # likelihood\n  μ ~ Normal(178,20) # prior\n  σ ~ Uniform(0, 50) # prior\n\";Plot the densities.p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 3)\np[1] = density(df2[:height], xlim=(100,250), lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")"
},

{
    "location": "04/clip-07-13s/#snippet-4.10-2",
    "page": "clip-07-13s",
    "title": "snippet 4.10",
    "category": "section",
    "text": "Show  μ priord1 = Normal(178, 20)\np[2] = plot(100:250, [pdf(d1, μ) for μ in 100:250], lab=\"Prior on mu\")"
},

{
    "location": "04/clip-07-13s/#snippet-4.11-1",
    "page": "clip-07-13s",
    "title": "snippet 4.11",
    "category": "section",
    "text": "Show σ  priord2 = Uniform(0, 50)\np[3] = plot(0:0.1:50, [pdf(d2, σ) for σ in 0:0.1:50], lab=\"Prior on sigma\")\n\nplot(p..., layout=(3,1))"
},

{
    "location": "04/clip-07-13s/#snippet-4.13-1",
    "page": "clip-07-13s",
    "title": "snippet 4.13",
    "category": "section",
    "text": "sample_mu = rand(d1, 10000)\nsample_sigma = rand(d2, 10000)\nprior_height = [rand(Normal(sample_mu[i], sample_sigma[i]), 1)[1] for i in 1:10000]\ndf2 = DataFrame(mu = sample_mu, sigma=sample_sigma, prior_height=prior_height);\nfirst(df2, 5)Show density of prior_heightdensity(prior_height, lab=\"prior_height\")Use data from m4.1s to show CmdStan resultsCheck if the m4.1s.jls file is present. If not, run the model.!isfile(joinpath(ProjDir, \"m4.1s.jls\")) && include(joinpath(ProjDir, \"m4.1s.jl\"))\n\nchn = deserialize(joinpath(ProjDir, \"m4.1s.jls\"))Describe the drawsdescribe(chn)Plot the density of posterior drawsdensity(chn)End of clip-07-13s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-14-20/#",
    "page": "clip-14-20",
    "title": "clip-14-20",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-14-20.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-14-20/#snippet-4.7-1",
    "page": "clip-14-20",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);"
},

{
    "location": "04/clip-14-20/#snippet-4.8-1",
    "page": "clip-14-20",
    "title": "snippet 4.8",
    "category": "section",
    "text": "Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Show first 5 rows of DataFrame dffirst(df2, 5)"
},

{
    "location": "04/clip-14-20/#Snippet-4.14-1",
    "page": "clip-14-20",
    "title": "Snippet 4.14",
    "category": "section",
    "text": "Generate approximate probabilitiesstruct Post\n  mu::Float64\n  sigma::Float64\n  ll:: Float64\n  prod::Float64\n  prob::Float64\nend\n\nmu_list = repeat(range(140, 160, length=200), 200);\nsigma_list = repeat(range(4, 9, length=200), inner=200);\n\nll = zeros(40000);\nfor i in 1:40000\n    d1 = Normal(mu_list[i], sigma_list[i])\n    ll[i] = sum(log.(pdf.(d1, df2[:height])))\nend\n\nd2 = Normal(178.0, 20.0)\nd3 = Uniform(0, 50)\nprod = ll + log.(pdf.(d2, mu_list)) + log.(pdf.(d3, sigma_list))\nprob = exp.(prod .- maximum(prod))\npost = DataFrame(mu=mu_list, sigma=sigma_list, ll=ll, prod=prod, prob=prob)\nfirst(post, 10)"
},

{
    "location": "04/clip-14-20/#Snippet-4.15-1",
    "page": "clip-14-20",
    "title": "Snippet 4.15",
    "category": "section",
    "text": "Sample postsamples = post[sample(1:size(post, 1), Weights(post[:prob]), 10000, replace=true), :]"
},

{
    "location": "04/clip-14-20/#Snippet-4.19-1",
    "page": "clip-14-20",
    "title": "Snippet 4.19",
    "category": "section",
    "text": "Density of mudensity(samples[:mu])Density of sigmadensity(samples[:sigma])"
},

{
    "location": "04/clip-14-20/#Snippet-4.20-1",
    "page": "clip-14-20",
    "title": "Snippet 4.20",
    "category": "section",
    "text": "Hdp muMCMCChain.hpd(samples[:mu])Hdp sigmaMCMCChain.hpd(samples[:sigma])End of clip-14-20.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-21-23/#",
    "page": "clip-21-23",
    "title": "clip-21-23",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-21-23.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);\ndf2 = filter(row -> row[:age] >= 18, df);\nfirst(df2, 5)"
},

{
    "location": "04/clip-21-23/#Snippet-4.21-1",
    "page": "clip-21-23",
    "title": "Snippet 4.21",
    "category": "section",
    "text": "Sample 20 random heightsn = size(df2, 1)\nselected_ind = sample(1:n, 20, replace=false);\ndf3 = df2[selected_ind, :];"
},

{
    "location": "04/clip-21-23/#Snippet-4.22-1",
    "page": "clip-21-23",
    "title": "Snippet 4.22",
    "category": "section",
    "text": "Generate approximate probabilitiesstruct Post\n  mu::Float64\n  sigma::Float64\n  ll:: Float64\n  prod::Float64\n  prob::Float64\nend\n\nmu_list = repeat(range(140, 170, length=200), 200);\nsigma_list = repeat(range(4, 20, length=200), inner=200);\n\nll = zeros(40000);\nfor i in 1:40000\n    d1 = Normal(mu_list[i], sigma_list[i])\n    ll[i] = sum(log.(pdf.(d1, df3[:height])))\nend\n\nd2 = Normal(178.0, 20.0)\nd3 = Uniform(0, 50)\nprod = ll + log.(pdf.(d2, mu_list)) + log.(pdf.(d3, sigma_list))\nprob = exp.(prod .- maximum(prod))\npost = DataFrame(mu=mu_list, sigma=sigma_list, ll=ll, prod=prod, prob=prob)\nfirst(post, 10)Sample postsamples = post[sample(1:size(post, 1), Weights(post[:prob]), 10000, replace=true), :]"
},

{
    "location": "04/clip-21-23/#Snippet-4.23-1",
    "page": "clip-21-23",
    "title": "Snippet 4.23",
    "category": "section",
    "text": "Density of sigmadensity(samples[:sigma])End of clip-21-23.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip-24-29s/#",
    "page": "clip-24-29s",
    "title": "clip-24-29s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/04/clip-24-29s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, Optim\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip-24-29s/#snippet-4.24-1",
    "page": "clip-24-29s",
    "title": "snippet 4.24",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);\ndf2 = filter(row -> row[:age] >= 18, df);\nfirst(df2, 5)"
},

{
    "location": "04/clip-24-29s/#snippet-4.25-1",
    "page": "clip-24-29s",
    "title": "snippet 4.25",
    "category": "section",
    "text": "Our first model:m4_1 = \"\n  height ~ Normal(μ, σ) # likelihood\n  μ ~ Normal(178,20) # prior\n  σ ~ Uniform(0, 50) # prior\n\""
},

{
    "location": "04/clip-24-29s/#snippet-4.26-1",
    "page": "clip-24-29s",
    "title": "snippet 4.26",
    "category": "section",
    "text": "Compute MAPobs = df2[:height]\n\nfunction loglik(x)\n  ll = 0.0\n  ll += log(pdf(Normal(178, 20), x[1]))\n  ll += log(pdf(Uniform(0, 50), x[2]))\n  ll += sum(log.(pdf.(Normal(x[1], x[2]), obs)))\n  -ll\nend"
},

{
    "location": "04/clip-24-29s/#snippet-4.28-1",
    "page": "clip-24-29s",
    "title": "snippet 4.28",
    "category": "section",
    "text": "x0 = [ 178, 10.0]\nlower = [0.0, 0.0]\nupper = [250.0, 50.0]"
},

{
    "location": "04/clip-24-29s/#snippet-4.27-1",
    "page": "clip-24-29s",
    "title": "snippet 4.27",
    "category": "section",
    "text": "inner_optimizer = GradientDescent()\n\noptimize(loglik, lower, upper, x0, Fminbox(inner_optimizer))Our second model:m4_2 = \"\n  height ~ Normal(μ, σ) # likelihood\n  μ ~ Normal(178, 0.1) # prior\n  σ ~ Uniform(0, 50) # prior\n\""
},

{
    "location": "04/clip-24-29s/#snippet-4.29-1",
    "page": "clip-24-29s",
    "title": "snippet 4.29",
    "category": "section",
    "text": "Compute MAPobs = df2[:height]\n\nfunction loglik2(x)\n  ll = 0.0\n  ll += log(pdf(Normal(178, 0.1), x[1]))\n  ll += log(pdf(Uniform(0, 50), x[2]))\n  ll += sum(log.(pdf.(Normal(x[1], x[2]), obs)))\n  -ll\nend\n\noptimize(loglik2, lower, upper, x0, Fminbox(inner_optimizer))End of clip-24-29s.jlThis page was generated using Literate.jl."
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
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);\nfirst(df2, 5)Use data from m4.1sCheck if the m4.1s.jls file is present. If not, run the model.!isfile(joinpath(ProjDir, \"m4.1s.jls\")) && include(joinpath(ProjDir, \"m4.1s.jl\"))\n\nchn = deserialize(joinpath(ProjDir, \"m4.1s.jls\"))Describe the drawsdescribe(chn)Plot the density of posterior drawsdensity(chn, lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")Compute cormu_sigma = hcat(chn.value[:, 2, 1], chn.value[:,1, 1])\nLinearAlgebra.diag(cov(mu_sigma))Compute covcor(mu_sigma)End of clip_07.0s.jlThis page was generated using Literate.jl."
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
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);\nmean_weight = mean(df2[:weight]);\ndf2[:weight_c] = df2[:weight] .- mean_weight;\nfirst(df2, 5)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight_c]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsscatter(df2[:weight_c], df2[:height], lab=\"Observations\",\n  ylab=\"height [cm]\", xlab=\"weight[kg]\")\nxi = -16.0:0.1:18.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)));\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)));\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi;\nplot!(xi, yi, lab=\"Regression line\")End of clip-43s.jlThis page was generated using Literate.jl."
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
    "location": "05/clip-01d/#",
    "page": "clip-01d",
    "title": "clip-01d",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/05/clip-01d.jl\""
},

{
    "location": "05/clip-01d/#Linear-regression-1",
    "page": "clip-01d",
    "title": "Linear regression",
    "category": "section",
    "text": "We estimate simple linear regression model with a half-T prior. First, we load the packages we use.using StatisticalRethinking\nusing DynamicHMC, TransformVariables, LogDensityProblems, MCMCDiagnostics\nusing Parameters, ForwardDiff\n\nProjDir = rel_path(\"..\", \"scripts\", \"05\")\ncd(ProjDir)Import the dataset."
},

{
    "location": "05/clip-01d/#snippet-5.1-1",
    "page": "clip-01d",
    "title": "snippet 5.1",
    "category": "section",
    "text": "wd = CSV.read(rel_path(\"..\", \"data\", \"WaffleDivorce.csv\"), delim=\';\')\ndf = convert(DataFrame, wd);\nmean_ma = mean(df[:MedianAgeMarriage])\ndf[:MedianAgeMarriage_s] = convert(Vector{Float64},\n  (df[:MedianAgeMarriage]) .- mean_ma)/std(df[:MedianAgeMarriage]);Show the first six rows of the dataset.first(df, 6)Then define a structure to hold the data: observables, covariates, and the degrees of freedom for the prior.\"\"\"\nLinear regression model ``y ∼ Xβ + ϵ``, where ``ϵ ∼ N(0, σ²)`` IID.\nFlat prior for `β`, half-T for `σ`.\n\"\"\"\nstruct WaffleDivorceProblem{TY <: AbstractVector, TX <: AbstractMatrix}\n    \"Observations.\"\n    y::TY\n    \"Covariates\"\n    X::TX\nendThen make the type callable with the parameters as a single argument.function (problem::WaffleDivorceProblem)(θ)\n    @unpack y, X, = problem   # extract the data\n    @unpack β, σ = θ            # works on the named tuple too\n    ll = 0.0\n    ll += logpdf(Normal(10, 10), X[1]) # a = X[1]\n    ll += logpdf(Normal(0, 1), X[2]) # b1 = X[2]\n    ll += logpdf(TDist(1.0), σ)\n    ll += loglikelihood(Normal(0, σ), y .- X*β)\n    ll\nendWe should test this, also, this would be a good place to benchmark and optimize more complicated problems.N = size(df, 1)\nX = hcat(ones(N), df[:MedianAgeMarriage_s]);\ny = convert(Vector{Float64}, df[:Divorce])\np = WaffleDivorceProblem(y, X);\np((β = [1.0, 2.0], σ = 1.0))For this problem, we write a function to return the transformation (as it varies with the number of covariates).problem_transformation(p::WaffleDivorceProblem) =\n    as((β = as(Array, size(p.X, 2)), σ = asℝ₊))Wrap the problem with a transformation, then use Flux for the gradient.P = TransformedLogDensity(problem_transformation(p), p)\n∇P = ADgradient(:ForwardDiff, P);Finally, we sample from the posterior. chain holds the chain (positions and diagnostic information), while the second returned value is the tuned sampler which would allow continuation of sampling.chain, NUTS_tuned = NUTS_init_tune_mcmc(∇P, 1000);We use the transformation to obtain the posterior from the chain.posterior = TransformVariables.transform.(Ref(∇P.transformation), get_position.(chain));\nposterior[1:5]Extract the parameter posterior means: β,posterior_β = mean(first, posterior)then σ:posterior_σ = mean(last, posterior)Effective sample sizes (of untransformed draws)ess = mapslices(effective_sample_size,\n                get_position_matrix(chain); dims = 1)NUTS-specific statisticsNUTS_statistics(chain)cmdstan resultcmdstan_result = \"\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n         Mean        SD       Naive SE       MCSE      ESS\n    a  9.6882466 0.22179190 0.0035068378 0.0031243061 1000\n   bA -1.0361742 0.21650514 0.0034232469 0.0034433245 1000\nsigma  1.5180337 0.15992781 0.0025286807 0.0026279593 1000\n\nQuantiles:\n         2.5%      25.0%     50.0%      75.0%       97.5%\n    a  9.253141  9.5393175  9.689585  9.84221500 10.11121000\n   bA -1.454571 -1.1821025 -1.033065 -0.89366925 -0.61711705\nsigma  1.241496  1.4079225  1.504790  1.61630750  1.86642750\n\";Extract the parameter posterior means: β,[posterior_β, posterior_σ]end of m4.5d.jl#- This page was generated using Literate.jl."
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
    "location": "08/m8.1/#",
    "page": "m8.1",
    "title": "m8.1",
    "category": "page",
    "text": ""
},

{
    "location": "08/m8.1/#m8.1stan-1",
    "page": "m8.1",
    "title": "m8.1stan",
    "category": "section",
    "text": "m8.1stan is the first model in the Statistical Rethinking book (pp. 249) using Stan.Here we will use Turing\'s NUTS support, which is currently (2018) the originalNUTS by Hoffman & Gelman and not the one that\'s in Stan 2.18.2, i.e., Appendix A.5 in: https://arxiv.org/abs/1701.02434The StatisticalRethinking pkg imports modules such as CSV and DataFramesusing StatisticalRethinking, Turing\n\nTuring.setadbackend(:reverse_diff);\nTuring.turnprogress(false);loaded\n\n\n┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/Turing.jl:81Read in the rugged data as a DataFramed = CSV.read(rel_path(\"..\", \"data\", \"rugged.csv\"), delim=\';\');Show size of the DataFrame (should be 234x51)size(d)(234, 51)Apply log() to each element in rgdppc_2000 column and add it as a new columnd = hcat(d, map(log, d[Symbol(\"rgdppc_2000\")]));Rename our col x1 => log_gdprename!(d, :x1 => :log_gdp);Now we need to drop every row where rgdppc_2000 == missingWhen this (https://github.com/JuliaData/DataFrames.jl/pull/1546) hits DataFrame it\'ll be conceptually easier: i.e., completecases!(d, :rgdppc_2000)notisnan(e) = !ismissing(e)\ndd = d[map(notisnan, d[:rgdppc_2000]), :];Updated DataFrame dd size (should equal 170 x 52)size(dd)(170, 52)Define the Turing model@model m8_1stan(y, x₁, x₂) = begin\n    σ ~ Truncated(Cauchy(0, 2), 0, Inf)\n    βR ~ Normal(0, 10)\n    βA ~ Normal(0, 10)\n    βAR ~ Normal(0, 10)\n    α ~ Normal(0, 100)\n\n    for i ∈ 1:length(y)\n        y[i] ~ Normal(α + βR * x₁[i] + βA * x₂[i] + βAR * x₁[i] * x₂[i], σ)\n    end\nend;Test to see that the model is sane. Use 2000 for now, as in the book. Need to set the same stepsize and adapt_delta as in Stan...Use Turing mcmcposterior = sample(m8_1stan(dd[:log_gdp], dd[:rugged], dd[:cont_africa]),\n    Turing.NUTS(2000, 200, 0.95));\n# Describe the posterior samples\ndescribe(posterior)┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:246\n[NUTS{Turing.FluxTrackerAD,Union{}}] found initial ϵ: 0.05\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:291\n┌ Info:  Adapted ϵ = 0.02494112896959952, std = [1.0, 1.0, 1.0, 1.0, 1.0]; 200 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 284.69474977300035;\n  #lf / sample        = 0.0015;\n  #evals / sample     = 47.82;\n  pre-cond. metric    = [1.0, 1.0, 1.0, 1.0, 1.0].\nIterations = 1:2000\nThinning interval = 1\nChains = 1\nSamples per chain = 2000\n\nEmpirical Posterior Estimates:\n              Mean          SD         Naive SE       MCSE         ESS   \n       α    9.20431457  0.409119788 0.00914819658 0.0277999222  216.57774\n  lf_num    0.00150000  0.067082039 0.00150000000 0.0015000000 2000.00000\n      βA   -1.92760777  0.347059686 0.00776049050 0.0286062609  147.19266\n      βR   -0.20010279  0.111203536 0.00248658666 0.0076298260  212.42612\n       σ    0.96306823  0.240119729 0.00536924037 0.0150168225  255.68167\n elapsed    0.14234737  0.166759748 0.00372886132 0.0080236235  431.95785\n epsilon    0.02569079  0.013752776 0.00030752142 0.0005170151  707.57793\neval_num   47.82000000 26.804754194 0.59937252499 0.6517587542 1691.41396\n     βAR    0.39846959  0.186980959 0.00418102135 0.0062014197  909.10178\n      lp -249.61661241 16.615338561 0.37153026491 1.1359823316  213.93175\n  lf_eps    0.02569079  0.013752776 0.00030752142 0.0005170151  707.57793\n\nQuantiles:\n              2.5%           25.0%         50.0%         75.0%         97.5%    \n       α    8.942664429    9.132459560    9.23019097    9.32077476    9.49302098\n  lf_num    0.000000000    0.000000000    0.00000000    0.00000000    0.00000000\n      βA   -2.370022641   -2.094903734   -1.95759873   -1.79584367   -1.47003212\n      βR   -0.355302986   -0.255220809   -0.20584364   -0.15294067   -0.04647507\n       σ    0.850984812    0.911530362    0.94640859    0.98396223    1.06767308\n elapsed    0.028388287    0.060682055    0.11541753    0.17330208    0.36332965\n epsilon    0.022344993    0.024941129    0.02494113    0.02494113    0.03243229\neval_num   10.000000000   22.000000000   46.00000000   46.00000000   94.00000000\n     βAR    0.134905453    0.310059030    0.39529263    0.48317478    0.66063326\n      lp -253.227027174 -249.344374789 -248.14662559 -247.30631894 -246.41399276\n  lf_eps    0.022344993    0.024941129    0.02494113    0.02494113    0.03243229Example of a Turing run simulation outputHere\'s the ulam() output from rethinking (note that in above output the SD value is too large).m81rethinking = \"\n       Mean StdDev lower 0.89 upper 0.89 n_eff Rhat\n a      9.24   0.14       9.03       9.47   291    1\n bR    -0.21   0.08      -0.32      -0.07   306    1\n bA    -1.97   0.23      -2.31      -1.58   351    1\n bAR    0.40   0.13       0.20       0.63   350    1\n sigma  0.95   0.05       0.86       1.03   566    1\n\";#-This notebook was generated using Literate.jl."
},

{
    "location": "08/m8.3/#",
    "page": "m8.3",
    "title": "m8.3",
    "category": "page",
    "text": "using StatisticalRethinking, Turing\n\nTuring.setadbackend(:reverse_diff)\nTuring.turnprogress(false)┌ Info: Recompiling stale cache file /Users/rob/.julia/compiled/v1.2/StatisticalRethinking/zZGTK.ji for StatisticalRethinking [2d09df54-9d0f-5258-8220-54c2a3d4fbee]\n└ @ Base loading.jl:1184\n\n\nloaded\n\n\n┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/Turing.jl:81\n\n\n\n\n\nfalseTuring model@model m8_3(y) = begin\n    α ~ Normal(1, 10)\n    σ ~ Truncated(Cauchy(0, 1), 0, Inf)\n\n    for i ∈ 1:length(y)\n        y[i] ~ Normal(α, σ)\n    end\nend\n\ny = [-1,1]2-element Array{Int64,1}:\n -1\n  1Sampleposterior = sample(m8_3(y), Turing.NUTS(4000, 1000, 0.95));┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:246\n[NUTS{Turing.FluxTrackerAD,Union{}}] found initial ϵ: 0.1\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/support/hmc_core.jl:291\n┌ Info:  Adapted ϵ = 0.23309036013171572, std = [1.0, 1.0]; 1000 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/xp88X/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 11.59304771500004;\n  #lf / sample        = 0.0005;\n  #evals / sample     = 28.57525;\n  pre-cond. metric    = [1.0, 1.0].Draw summarydescribe(posterior)Iterations = 1:4000\nThinning interval = 1\nChains = 1\nSamples per chain = 4000\n\nEmpirical Posterior Estimates:\n              Mean          SD        Naive SE       MCSE         ESS   \n       α  0.1343282881  1.922595048 0.0303988968 0.1033135484  346.30685\n       σ  2.1657545701  2.039860509 0.0322530266 0.0819828186  619.09208\n  lf_num  0.0005000000  0.031622777 0.0005000000 0.0005000000 4000.00000\n elapsed  0.0028982619  0.059849008 0.0009462959 0.0012197662 2407.46927\n epsilon  0.2442798614  0.103110703 0.0016303234 0.0033573352  943.23104\n      lp -8.6993360203  1.454901242 0.0230040085 0.0642703462  512.44322\neval_num 28.5752500000 18.530439329 0.2929919716 0.4683081918 1565.69773\n  lf_eps  0.2442798614  0.103110703 0.0016303234 0.0033573352  943.23104\n\nQuantiles:\n               2.5%          25.0%         50.0%         75.0%         97.5%    \n       α  -3.15403575829 -0.6501026737  0.0209383092  0.7419790304  4.9187523194\n       σ   0.59706505633  1.0503474221  1.5510559816  2.4428393692  7.9340121925\n  lf_num   0.00000000000  0.0000000000  0.0000000000  0.0000000000  0.0000000000\n elapsed   0.00049106245  0.0011012628  0.0011802135  0.0023158943  0.0052448396\n epsilon   0.15498800794  0.2330903601  0.2330903601  0.2330903601  0.3836541393\n      lp -12.81538094932 -9.2888633133 -8.2264862248 -7.6603384826 -7.2498002093\neval_num  10.00000000000 22.0000000000 22.0000000000 46.0000000000 82.0000000000\n  lf_eps   0.15498800794  0.2330903601  0.2330903601  0.2330903601  0.3836541393Results rethinkingm83rethinking = \"\n          Mean StdDev lower 0.89 upper 0.89 n_eff Rhat\nalpha  -0.01   1.60      -1.98       2.37  1121    1\nsigma  1.98   1.91       0.47       3.45  1077    1\n\";This notebook was generated using Literate.jl."
},

{
    "location": "12/m12.6.1s/#",
    "page": "m12.6.1s",
    "title": "m12.6.1s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/12/m12.6.1s.jl\"using StatisticalRethinking\nusing CmdStan, StanMCMCChain\n\nProjDir = rel_path(\"..\", \"scripts\", \"12\")\n\nd = CSV.read(rel_path( \"..\", \"data\",  \"Kline.csv\"), delim=\';\');\nsize(d) # Should be 10x5New col logpop, set log() for population datad[:logpop] = map((x) -> log(x), d[:population]);\nd[:society] = 1:10;\n\nfirst(d, 5)\n\nm12_6_1 = \"\ndata{\n    int total_tools[10];\n    real logpop[10];\n    int society[10];\n}\nparameters{\n    real a;\n    real bp;\n    vector[10] a_society;\n    real<lower=0> sigma_society;\n}\nmodel{\n    vector[10] mu;\n    sigma_society ~ cauchy( 0 , 1 );\n    a_society ~ normal( 0 , sigma_society );\n    bp ~ normal( 0 , 1 );\n    a ~ normal( 0 , 10 );\n    for ( i in 1:10 ) {\n        mu[i] = a + a_society[society[i]] + bp * logpop[i];\n        mu[i] = exp(mu[i]);\n    }\n    total_tools ~ poisson( mu );\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"m12.6.1\",  model=m12_6_1, num_warmup=2000,\nnum_samples=2000, output_format=:mcmcchain);Input data for cmdstanm12_6_1_data = Dict(\"total_tools\" => d[:total_tools], \"logpop\" => d[:logpop], \"society\" => d[:society]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, m12_6_1_data, ProjDir, diagnostics=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)This page was generated using Literate.jl."
},

{
    "location": "12/m12.6.2s/#",
    "page": "m12.6.2s",
    "title": "m12.6.2s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/12/m12.6.2s.jl\"using StatisticalRethinking\nusing CmdStan, StanMCMCChain\n\nProjDir = rel_path(\"..\", \"scripts\", \"12\")\n\nd = CSV.read(rel_path( \"..\", \"data\",  \"Kline.csv\"), delim=\';\');\nsize(d) # Should be 10x5New col log_pop, set log() for population datad[:log_pop] = map((x) -> log(x), d[:population]);\nd[:society] = 1:10;\n\nfirst(d, 5)\n\nm12_6 = \"\n  data {\n    int N;\n    int T[N];\n    int N_societies;\n    int society[N];\n    int P[N];\n  }\n  parameters {\n    real alpha;\n    vector[N_societies] a_society;\n    real bp;\n    real<lower=0> sigma_society;\n  }\n  model {\n    vector[N] mu;\n    target += normal_lpdf(alpha | 0, 10);\n    target += normal_lpdf(bp | 0, 1);\n    target += cauchy_lpdf(sigma_society | 0, 1);\n    target += normal_lpdf(a_society | 0, sigma_society);\n    for(i in 1:N) mu[i] = alpha + a_society[society[i]] + bp * log(P[i]);\n    target += poisson_log_lpmf(T | mu);\n  }\n  generated quantities {\n    vector[N] log_lik;\n    {\n    vector[N] mu;\n    for(i in 1:N) {\n      mu[i] = alpha + a_society[society[i]] + bp * log(P[i]);\n      log_lik[i] = poisson_log_lpmf(T[i] | mu[i]);\n    }\n    }\n  }\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"m12.6\",  model=m12_6, output_format=:mcmcchain);Input data for cmdstanm12_6_data = Dict(\"N\" => size(d, 1), \"T\" => d[:total_tools], \"N_societies\" => 10, \"society\" => d[:society], \"P\" => d[:population]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, m12_6_data, ProjDir, diagnostics=false, summary=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)This page was generated using Literate.jl."
},

{
    "location": "13/m13.2s/#",
    "page": "m13.2s",
    "title": "m13.2s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/scripts/13/m13.2s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"scripts\", \"13\")\ncd(ProjDir)"
},

{
    "location": "13/m13.2s/#snippet-13.1-1",
    "page": "m13.2s",
    "title": "snippet 13.1",
    "category": "section",
    "text": "wd = CSV.read(rel_path(\"..\", \"data\", \"UCBadmit.csv\"), delim=\';\');\ndf = convert(DataFrame, wd);Preprocess datadf[:admit] = convert(Vector{Int}, df[:admit])\ndf[:applications] = convert(Vector{Int}, df[:applications])\ndf[:male] = [(df[:gender][i] == \"male\" ? 1 : 0) for i in 1:size(df, 1)];\ndf[:dept_id] = [Int(df[:dept][i][1])-64 for i in 1:size(df, 1)];\nfirst(df, 5)\n\nm13_2_model = \"\n  data{\n      int N;\n      int N_depts;\n      int applications[N];\n      int admit[N];\n      real male[N];\n      int dept_id[N];\n  }\n  parameters{\n      vector[N_depts] a_dept;\n      real a;\n      real bm;\n      real<lower=0> sigma_dept;\n  }\n  model{\n      vector[N] p;\n      sigma_dept ~ cauchy( 0 , 2 );\n      bm ~ normal( 0 , 1 );\n      a ~ normal( 0 , 10 );\n      a_dept ~ normal( a , sigma_dept );\n      for ( i in 1:N ) {\n          p[i] = a_dept[dept_id[i]] + bm * male[i];\n          p[i] = inv_logit(p[i]);\n      }\n      admit ~ binomial( applications , p );\n  }\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"m13_2_model\", model=m13_2_model,\nmonitors=[\"a\", \"bm\", \"sigma_dept\", \"a_dept.1\", \"a_dept.2\", \"a_dept.3\",\n\"a_dept.4\", \"a_dept.5\", \"a_dept.6\"],\noutput_format=:mcmcchain);Input data for cmdstanucdata = Dict(\"N\" => size(df, 1), \"N_depts\" => maximum(df[:dept_id]), \"admit\" => df[:admit],\n\"applications\" => df[:applications],  \"dept_id\"=> df[:dept_id], \"male\" => df[:male]);Sample using cmdstanrc, chn, cnames = stan(stanmodel, ucdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the density of posterior drawsplot(chn)This page was generated using Literate.jl."
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
