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
    "text": "This package will contain Julia versions of selected code snippets contained in the R package \"rethinking\" associated with the book Statistical Rethinking by Richard McElreath.In the book and associated R package rethinking, statistical models are defined as illustrated below:m4.3 <- map(\n    alist(\n        height ~ dnorm( mu , sigma ) ,\n        mu <- a + b*weight ,\n        a ~ dnorm( 156 , 100 ) ,\n        b ~ dnorm( 0 , 10 ) ,\n        sigma ~ dunif( 0 , 50 )\n    ) ,\n    data=d2\n)The author of the book states: \"If that (the statistical model) doesn\'t make much sense, good. ... you\'re holding the right textbook, since this book teaches you how to read and write these mathematical descriptions\"  (page 77).This package is intended to allow experimenting with this learning process using 3 available mcmc options in Julia."
},

{
    "location": "#Layout-of-the-package-1",
    "page": "Home",
    "title": "Layout of the package",
    "category": "section",
    "text": "Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:clip_01_03.jl - contains snippets 0.1 through 0.3\nclip_04_05.jl - contains snippets 0.4 and 0.5.These 2 files are in chapters/00. These files are later on processed by Literate.jl to create 2 derived versions, e.g. from clip_01_03.jl in chapters/00:clip_01_03.md - included in the documentation\nclip_01_03.ipynb - stored in the notebooks directory for use in JupyterOccasionally a clip will contain just a single snippet and will be referred to as 03/clip_02.jl. Clips with names such as 02/clip_08t.jl, clip_08s.jl and clip_08m.jl contain mcmc implementations using Turing.jl, CmdStan.jl and Mamba.jl respectively. Examples have been added to chapter 2.From chapter 8 onwards, the Turing versions of the mcmc models are available as e.g. chapters/08/m8.1t.jl. Equivalent CmdStan versions and, in a few cases Mamba models, are provided as well.Almost identical clips are named e.g. 04/clip_07.0s.jl and 04/clip_07.1s.jl. In that specific example just the priors differ."
},

{
    "location": "#Acknowledgements-1",
    "page": "Home",
    "title": "Acknowledgements",
    "category": "section",
    "text": "Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8.The TuringLang team and #turing contributors on Slack have been extremely helpful!The mcmc components are based on:TuringLang\nStanJulia\nMambaAt least 2 other mcmc options are available for mcmc in Julia:DynamicHMC\nKlaraTime constraints prevents inclusion of those right now, although e.g. the example chapters/04/clip_38.1m.jl almost begs for a clip_38d.jl. For now the linear regression example in  DynamicHMCExamples is a good starting point.The Mamba examples should really use @everywhere using Mamba in stead of using Mamba. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode.The  documentation has been generated using Literate.jl based on several ideas demonstrated by Tamas Papp in above mentioned  DynamicHMCExamples.jl."
},

{
    "location": "#References-1",
    "page": "Home",
    "title": "References",
    "category": "section",
    "text": "There is no shortage of good books on Bayesian statistics. A few of my favorites are:Bolstad: Introduction to Bayesian statistics\nBolstad: Understanding Computational Bayesian Statistics\nGelman, Hill: Data Analysis using regression and multileve,/hierachical models\nMcElreath: Statistical Rethinking\nGelman, Carlin, and others: Bayesian Data Analysis\nLee, Wagenmakers: Bayesian Cognitive Modeling\nKruschke:Doing Bayesian Data Analysisand a great read (and implementation in DynamicHMC.jl):Betancourt: A Conceptual Introduction to Hamiltonian Monte Carlo"
},

{
    "location": "#Functions:-1",
    "page": "Home",
    "title": "Functions:",
    "category": "section",
    "text": "CurrentModule = StatisticalRethinking"
},

{
    "location": "#StatisticalRethinking.maximum_a_posteriori-Tuple{Any,Any,Any}",
    "page": "Home",
    "title": "StatisticalRethinking.maximum_a_posteriori",
    "category": "method",
    "text": "maximumaposterior\n\nCompute the maximumaposteriori of a model. \n\nMethod\n\nmaximum_a_posteriori(model, lower_bound, upper_bound)\n\nRequired arguments\n\n* `model::Turing model`\n* `lower_bound::Float64`\n* `upper_bound::Float64`\n\nReturn values\n\n* `result`                       : Maximum_a_posterior vector\n\nExamples\n\nSee 02/clip_08t.jl\n\n\n\n\n\n"
},

{
    "location": "#maximum_a_posteriori-1",
    "page": "Home",
    "title": "maximum_a_posteriori",
    "category": "section",
    "text": "maximum_a_posteriori(model, lower_bound, upper_bound)"
},

{
    "location": "#StatisticalRethinking.rel_path-Tuple",
    "page": "Home",
    "title": "StatisticalRethinking.rel_path",
    "category": "method",
    "text": "rel_path\n\nRelative path using the StatisticalRethinking src/ directory. Copied from DynamicHMCExamples.jl\n\nExample to get access to the data subdirectory\n\nrel_path(\"..\", \"data\")\n\n\n\n\n\n"
},

{
    "location": "#rel_path-1",
    "page": "Home",
    "title": "rel_path",
    "category": "section",
    "text": "rel_path(parts...)"
},

{
    "location": "00/clip_01_03/#",
    "page": "clip_01_03",
    "title": "clip_01_03",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/00/clip_01_03.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking"
},

{
    "location": "00/clip_01_03/#snippet-0.1-1",
    "page": "clip_01_03",
    "title": "snippet 0.1",
    "category": "section",
    "text": "println( \"All models are wrong, but some are useful.\" );"
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
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/00/clip_04_05.jl\"Load Julia packages (libraries) needed"
},

{
    "location": "00/clip_04_05/#snippet-0.5-is-replaced-by-below-using-StatisticalRethinking.-1",
    "page": "clip_04_04",
    "title": "snippet 0.5 is replaced by below using StatisticalRethinking.",
    "category": "section",
    "text": "using StatisticalRethinking, GLM\ngr(size=(500, 500));"
},

{
    "location": "00/clip_04_05/#snippet-0.4-1",
    "page": "clip_04_04",
    "title": "snippet 0.4",
    "category": "section",
    "text": "Below dataset(...) provides access to often used R datasets.cars = dataset(\"datasets\", \"cars\")If this is not a common R dataset, use e.g.: howell1 = CSV.read(joinpath(ProjDir, \"..\", \"..\",  \"data\", \"Howell1.csv\"), delim=\';\') df = convert(DataFrame, howell1)This reads the Howell1.csv dataset in the data subdirectory of this package,  StatisticalRethinking.jl. See also the chapter 4 snippets.Fit a linear regression of distance on speedm = lm(@formula(Dist ~ Speed), cars)estimated coefficients from the modelcoef(m)Plot residuals against speedscatter( cars[:Speed], residuals(m),\n  xlab=\"Speed\", ylab=\"Model residual values\", lab=\"Model residuals\")End of clip_04_05.jlThis page was generated using Literate.jl."
},

{
    "location": "00/m0.1s/#",
    "page": "m0.1s",
    "title": "m0.1s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/00/m0.1s.jl\""
},

{
    "location": "00/m0.1s/#Linear-Regression-1",
    "page": "m0.1s",
    "title": "Linear Regression",
    "category": "section",
    "text": ""
},

{
    "location": "00/m0.1s/#Added-snippet-used-as-a-reference-for-all-models-1",
    "page": "m0.1s",
    "title": "Added snippet used as a reference for all models",
    "category": "section",
    "text": "This model is based on the TuringTutorial example LinearRegression by Cameron Pfiffer.Turing is powerful when applied to complex hierarchical models, but it can also be put to task at common statistical procedures, like linear regression. This tutorial covers how to implement a linear regression model in Turing.We begin by importing all the necessary libraries.using StatisticalRethinking, CmdStan, StanMCMCChain, GLM\ngr(size=(500,500))\n\nProjDir = rel_path(\"..\", \"chapters\", \"00\")\ncd(ProjDir)We will use the mtcars dataset from the RDatasets package. mtcars contains a variety of statistics on different car models, including their miles per gallon, number of cylinders, and horsepower, among others.We want to know if we can construct a Bayesian linear regression model to predict the miles per gallon of a car, given the other statistics it has. Lets take a look at the data we have.Import the dataset.data = RDatasets.dataset(\"datasets\", \"mtcars\");Show the first six rows of the dataset.first(data, 6)The next step is to get our data ready for testing. We\'ll split the mtcars dataset into two subsets, one for training our model and one for evaluating our model. Then, we separate the labels we want to learn (MPG, in this case) and standardize the datasets by subtracting each column\'s means and dividing by the standard deviation of that column.The resulting data is not very familiar looking, but this standardization process helps the sampler converge far easier. We also create a function called unstandardize, which returns the standardized values to their original form. We will use this function later on when we make predictions.Split our dataset 70%/30% into training/test sets.train, test = MLDataUtils.splitobs(data, at = 0.7);Save dataframe versions of our dataset.train_cut = DataFrame(train)\ntest_cut = DataFrame(test)Create our labels. These are the values we are trying to predict.train_label = train[:, :MPG]\ntest_label = test[:, :MPG]Get the list of columns to keep.remove_names = filter(x->!in(x, [:MPG, :Model]), names(data))Filter the test and train sets.train = Matrix(train[:,remove_names]);\ntest = Matrix(test[:,remove_names]);A handy helper function to rescale our dataset.function standardize(x)\n    return (x .- mean(x, dims=1)) ./ std(x, dims=1), x\nendAnother helper function to unstandardize our datasets.function unstandardize(x, orig)\n    return x .* std(orig, dims=1) .+ mean(orig, dims=1)\nendStandardize our dataset.(train, train_orig) = standardize(train)\n(test, test_orig) = standardize(test)\n(train_label, train_l_orig) = standardize(train_label)\n(test_label, test_l_orig) = standardize(test_label);Design matrixdmat = [ones(size(train, 1)) train]Bayesian linear regression.lrmodel = \"\ndata {\n  int N; //the number of observations\n  int K; //the number of columns in the model matrix\n  real y[N]; //the response\n  matrix[N,K] X; //the model matrix\n}\nparameters {\n  vector[K] beta; //the regression parameters\n  real sigma; //the standard deviation\n}\ntransformed parameters {\n  vector[N] linpred;\n  linpred <- X*beta;\n}\nmodel {\n  beta[1] ~ cauchy(0,10); //prior for the intercept following Gelman 2008\n\n  for(i in 2:K)\n   beta[i] ~ cauchy(0,2.5);//prior for the slopes following Gelman 2008\n\n  y ~ normal(linpred,sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"linear_regression\",\n  monitors = [\"beta.1\", \"beta.2\", \"beta.3\", \"beta.4\", \"beta.5\", \"beta.6\", \"beta.7\",\n    \"beta.8\", \"beta.9\", \"beta.10\", \"beta.11\", \"sigma\"],\n  model=lrmodel);Input data for cmdstanlrdata = [\n  Dict(\"N\" => size(train, 1), \"K\" => size(dmat, 2), \"y\" => train_label, \"X\" => dmat)\n];Sample using cmdstanrc, sim, cnames = stan(stanmodel, lrdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Convert to a MCMCChain Chain objectcnames = [\"intercept\", \"beta[1]\", \"beta[2]\", \"beta[3]\", \"beta[4]\", \"beta[5]\", \"beta[6]\",\n      \"beta[7]\", \"beta[8]\", \"beta[9]\", \"beta[10]\", \"sigma\"]\nchain = convert_a3d(sim, cnames, Val(:mcmcchain))Plot the chains.plot(chain)Describe the chains.describe(chain)Perform multivariate OLS.ols = lm(@formula(MPG ~ Cyl + Disp + HP + DRat + WT + QSec + VS + AM + Gear + Carb), train_cut)Store our predictions in the original dataframe.train_cut.OLSPrediction = predict(ols);\ntest_cut.OLSPrediction = predict(ols, test_cut);Make a prediction given an input vector.function prediction(chain, x)\n    α = chain[:, 1, :].value\n    β = [chain[:, i, :].value for i in 2:11]\n    return  mean(α) .+ x * mean.(β)\nendCalculate the predictions for the training and testing sets.train_cut.BayesPredictions = unstandardize(prediction(chain, train), train_l_orig);\ntest_cut.BayesPredictions = unstandardize(prediction(chain, test), test_l_orig);Show the first side rows of the modified dataframe.first(test_cut, 6)\n\nbayes_loss1 = sum((train_cut.BayesPredictions - train_cut.MPG).^2)\nols_loss1 = sum((train_cut.OLSPrediction - train_cut.MPG).^2)\n\nbayes_loss2 = sum((test_cut.BayesPredictions - test_cut.MPG).^2)\nols_loss2 = sum((test_cut.OLSPrediction - test_cut.MPG).^2)\n\nprintln(\"Training set:\")\nprintln(\"  Bayes loss: $bayes_loss1\")\nprintln(\"  OLS loss: $ols_loss1\")\n\nprintln(\"Test set:\")\nprintln(\"  Bayes loss: $bayes_loss2\")\nprintln(\"  OLS loss: $ols_loss2\")This page was generated using Literate.jl."
},

{
    "location": "02/clip_01_02/#",
    "page": "clip_01_02",
    "title": "clip_01_02",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_01_02.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking"
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
    "text": "Create a distribution with n = 9 (e.g. tosses) and p = 0.5.d = Binomial(9, 0.5)Probability density for 6 waters holding n = 9 and p = 0.5.pdf(d, 6)End of clip_01_02.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip_03_05/#",
    "page": "clip_03_05",
    "title": "clip_03_05",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_03_05.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300));"
},

{
    "location": "02/clip_03_05/#snippet-2.3-1",
    "page": "clip_03_05",
    "title": "snippet 2.3",
    "category": "section",
    "text": "Define a gridN = 20\np_grid = range( 0 , stop=1 , length=N )Define the (uniform) priorprior = ones( 20 );Compute likelihood at each value in gridlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]Compute product of likelihood and priorunstd_posterior = likelihood .* prior;Standardize the posterior, so it sums to 1posterior = unstd_posterior  ./ sum(unstd_posterior);"
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
    "text": "prior1 = [p < 0.5 ? 0 : 1 for p in p_grid]\nprior2 = [exp( -5*abs( p - 0.5 ) ) for p in p_grid]\n\np3 = plot(p_grid, prior1,\n  xlab=\"probability of water\" , ylab=\"posterior probability\",\n  lab = \"semi_uniform\", title=\"Other priors\" )\nscatter!(p3, p_grid, prior1, lab = \"semi_uniform grid point\")\nplot!(p3, p_grid, prior2,  lab = \"double_exponential\" )\nscatter!(p3, p_grid, prior2,  lab = \"double_exponential grid point\" )End of clip_03_05.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip_06_07/#",
    "page": "clip_06_07",
    "title": "clip_06_07",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_06_07.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300));"
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
    "text": "analytical calculationw = 6; n = 9; x = 0:0.01:1\nscatter( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationscatter!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")End of clip_06_07.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip_08t/#",
    "page": "clip_08t",
    "title": "clip_08t",
    "category": "page",
    "text": "Load Julia packages (libraries) neededusing StatisticalRethinking\nusing StatsFuns, Optim, Turing, Flux.Tracker\ngr(size=(600,300));\n\nTuring.setadbackend(:reverse_diff)loaded\n\n\n┌ Warning: Package Turing does not have CmdStan in its dependencies:\n│ - If you have Turing checked out for development and have\n│   added CmdStan as a dependency but haven\'t updated your primary\n│   environment\'s manifest file, try `Pkg.resolve()`.\n│ - Otherwise you may need to report an issue with Turing\n│ Loading CmdStan into Turing from project dependency, future warnings for Turing are suppressed.\n└ @ nothing nothing:840\nWARNING: using CmdStan.Sample in module Turing conflicts with an existing identifier.\n\n\n\n\n\n:reverse_diff"
},

{
    "location": "02/clip_08t/#snippet-2.8t-1",
    "page": "clip_08t",
    "title": "snippet 2.8t",
    "category": "section",
    "text": "Define the datak = 6; n = 9;Define the model@model globe_toss(n, k) = begin\n  theta ~ Beta(1, 1) # prior\n  k ~ Binomial(n, theta) # model\n  return k, theta\nend;Compute the \"maximumaposteriori\" valueSet search boundslb = [0.0]; ub = [1.0];Create (compile) the modelmodel = globe_toss(n, k);Compute the maximumaposterioriresult = maximum_a_posteriori(model, lb, ub)Results of Optimization Algorithm\n * Algorithm: Fminbox with L-BFGS\n * Starting Point: [0.43601313152405363]\n * Minimizer: [0.6666666665712192]\n * Minimum: 1.297811e+00\n * Iterations: 3\n * Convergence: true\n   * |x - x\'| ≤ 0.0e+00: false \n     |x - x\'| = 7.68e-08 \n   * |f(x) - f(x\')| ≤ 0.0e+00 |f(x)|: false\n     |f(x) - f(x\')| = 9.22e-14 |f(x)|\n   * |g(x)| ≤ 1.0e-08: true \n     |g(x)| = 3.11e-09 \n   * Stopped by an increasing objective: false\n   * Reached Maximum Number of Iterations: false\n * Objective Calls: 49\n * Gradient Calls: 49Use Turing mcmcTuring.turnprogress(false)\nchn = sample(model, NUTS(2000, 1000, 0.65));┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/Turing.jl:81\n┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/support/hmc_core.jl:246\n[NUTS{Union{}}] found initial ϵ: 0.8\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/support/hmc_core.jl:291\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/core/ad.jl:114\n┌ Warning: grad = [NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/core/ad.jl:115\n┌ Info:  Adapted ϵ = 0.9595407256254531, std = [1.0]; 1000 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 5.366160218000005;\n  #lf / sample        = 0.0025;\n  #evals / sample     = 6.8585;\n  pre-cond. metric    = [1.0].Look at the generated draws (in chn)describe(chn)Iterations = 1:2000\nThinning interval = 1\nChains = 1\nSamples per chain = 2000\n\nEmpirical Posterior Estimates:\n             Mean         SD       Naive SE       MCSE         ESS   \n  lf_num  0.00250000 0.111803399 0.0025000000 0.0025000000 2000.00000\n elapsed  0.00268308 0.083443804 0.0018658602 0.0024022260 1206.59200\n epsilon  1.11832340 0.967841538 0.0216415947 0.0449674509  463.24632\n   theta  0.64178990 0.133473620 0.0029845609 0.0032139864 1724.65731\n      lp -3.26836903 0.699385284 0.0156387304 0.0257294314  738.87777\neval_num  6.85850000 3.987910413 0.0891723877 0.1334487384  893.02135\n  lf_eps  1.11832340 0.967841538 0.0216415947 0.0449674509  463.24632\n\nQuantiles:\n              2.5%          25.0%        50.0%         75.0%          97.5%    \n  lf_num  0.0000000000  0.00000000000  0.00000000  0.00000000000  0.00000000000\n elapsed  0.0001327437  0.00013531425  0.00014373  0.00034360475  0.00074923602\n epsilon  0.3871856393  0.95954072563  0.95954073  1.03236201414  2.72709112614\n   theta  0.3712161929  0.54695523760  0.64940621  0.73885701268  0.87566668020\n      lp -5.2978624719 -3.42597439130 -3.01414974 -2.82723625426 -2.77970959395\neval_num  4.0000000000  4.00000000000  4.00000000 10.00000000000 10.00000000000\n  lf_eps  0.3871856393  0.95954072563  0.95954073  1.03236201414  2.72709112614Look at the mean and sdprintln(\"\\ntheta = $(mean_and_std(chn[:theta][1001:2000]))\\n\")theta = (0.6416312990141793, 0.1311782682540063)Compute at hpd regionbnds = MCMCChain.hpd(chn[:theta], alpha=0.06);analytical calculationw = 6; n = 9; x = 0:0.01:1\nplot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab=\"Conjugate solution\")(Image: svg)quadratic approximationplot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")(Image: svg)Turing Chain &  89%hpd region boundariesdensity!(chn[:theta], lab=\"Turing chain\")\nvline!([bnds[1]], line=:dash, lab=\"hpd lower bound\")\nvline!([bnds[2]], line=:dash, lab=\"hpd upper bound\")(Image: svg)Show hpd regionprintln(\"hpd bounds = $bnds\\n\")hpd bounds = [0.390912, 0.87325]End of clip_08t.jlThis notebook was generated using Literate.jl."
},

{
    "location": "02/clip_08m/#",
    "page": "clip_08m",
    "title": "clip_08m",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_08m.jl\"using Distributed, Gadfly\nusing MambaDataglobe_toss = Dict{Symbol, Any}(\n  :w => [6, 7, 5, 6, 6],\n  :n => [9, 9, 9, 9, 9]\n)\nglobe_toss[:N] = length(globe_toss[:w]);Model Specificationmodel = Model(\n  w = Stochastic(1,\n    (n, p, N) ->\n      UnivariateDistribution[Binomial(n[i], p) for i in 1:N],\n    false\n  ),\n  p = Stochastic(() -> Beta(1, 1))\n);Initial Valuesinits = [\n  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => 0.5),\n  Dict(:w => globe_toss[:w], :n => globe_toss[:n], :p => rand(Beta(1, 1)))\n];Sampling Schemescheme = [NUTS(:p)]\nsetsamplers!(model, scheme);MCMC Simulationssim = mcmc(model, globe_toss, inits, 10000, burnin=2500, thin=1, chains=2)Describe drawsdescribe(sim)End of clip_08m.jlThis page was generated using Literate.jl."
},

{
    "location": "02/clip_08s/#",
    "page": "clip_08s",
    "title": "clip_08s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/02/clip_08s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,800));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"02\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4^2\nd = Binomial(9, 0.66)\nn2 = Int.(9 * ones(Int, N2));Show (generated) observationsk2 = rand(d, N2)Input data for cmdstanbinomialdata = [\n  Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Allocate array of Normal fitsfits = Vector{Normal{Float64}}(undef, 4)\nfor i in 1:4\n  fits[i] = fit_mle(Normal, convert.(Float64, chn.value[:, 1, i]))\n  println(fits[i])\nendPlot the 4 chainsif rc == 0\n  p = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\n  x = 0:0.001:1\n  for i in 1:4\n    vals = convert.(Float64, chn.value[:, 1, i])\n    μ = round(fits[i].μ, digits=2)\n    σ = round(fits[i].σ, digits=2)\n    p[i] = density(vals, lab=\"Chain $i density\",\n       xlim=(0.45, 1.0), title=\"$(N2) data points\")\n    plot!(p[i], x, pdf.(Normal(fits[i].μ, fits[i].σ), x), lab=\"Fitted Normal($μ, $σ)\")\n  end\n  plot(p..., layout=(4, 1))\nendEnd of clip_08s.jlThis page was generated using Literate.jl."
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
    "text": "PrPV = 0.95\nPrPM = 0.01\nPrV = 0.001\nPrP = PrPV*PrV + PrPM*(1-PrV)\nPrVP = PrPV*PrV / PrPEnd of clip_01.jlThis page was generated using Literate.jl."
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
    "text": "Grid of 1001 stepsp_grid = range(0, step=0.001, stop=1)all priors = 1.0prior = ones(length(p_grid));Binomial pdflikelihood = [pdf(Binomial(9, p), 6) for p in p_grid];As Uniform priar has been used, unstandardized posterior is equal to likelihoodposterior = likelihood .* prior;Scale posterior such that they become probabilitiesposterior = posterior / sum(posterior)"
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
    "text": "Analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")Add quadratic approximationplot!( p[2], x, pdf.(Normal( fitnormal.μ, fitnormal.σ ) , x ), lab=\"Normal approximation\")\nplot(p..., layout=(1, 2))End of clip_02_05.jlThis page was generated using Literate.jl."
},

{
    "location": "03/clip_05s/#",
    "page": "clip_05s",
    "title": "clip_05s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip_05s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,800));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"03\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4^2\nd = Binomial(9, 0.66)\nn2 = Int.(9 * ones(Int, N2))\nk2 = rand(d, N2);Input data for cmdstanbinomialdata = [\n  Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the 4 chainsif rc == 0\n  plot(chn)\nendEnd of clip_05s.jlThis page was generated using Literate.jl."
},

{
    "location": "03/clip_06_16s/#",
    "page": "clip_06_16s",
    "title": "clip_06_16s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/03/clip_06_16s.jl\"Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"03\")\ncd(ProjDir)Define the Stan language modelbinomialstanmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  int<lower=0> k[N];\n  int<lower=1> n[N];\n}\nparameters {\n  real<lower=0,upper=1> theta;\n  real<lower=0,upper=1> thetaprior;\n}\nmodel {\n  // Prior Distribution for Rate Theta\n  theta ~ beta(1, 1);\n  thetaprior ~ beta(1, 1);\n\n  // Observed Counts\n  k ~ binomial(n, theta);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"binomial\", monitors = [\"theta\"], model=binomialstanmodel,\n  output_format=:mcmcchain);Use 16 observationsN2 = 4\nn2 = Int.(9 * ones(Int, N2))\nk2 = [6, 5, 7, 6]Input data for cmdstanbinomialdata = [\n  Dict(\"N\" => length(n2), \"n\" => n2, \"k\" => k2)\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, binomialdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Look at area of hpdMCMCChain.hpd(chn)Plot the 4 chainsif rc == 0\n  mixeddensity(chn, xlab=\"height [cm]\", ylab=\"density\")\n  bnds = MCMCChain.hpd(convert(Vector{Float64}, chn.value[:,1,1]))\n  vline!([bnds[1]], line=:dash)\n  vline!([bnds[2]], line=:dash)\nendEnd of clip_06_16s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_01_06/#",
    "page": "clip_01_06",
    "title": "clip_01_06",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_01_06.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(600,300));"
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
    "text": "Grid of 1001 stepsp_grid = range(0, step=0.001, stop=1);all priors = 1.0prior = ones(length(p_grid));Binomial pdflikelihood = [pdf(Binomial(9, p), 6) for p in p_grid];As Uniform priar has been used, unstandardized posterior is equal to likelihoodposterior = likelihood .* prior;Scale posterior such that they become probabilitiesposterior = posterior / sum(posterior);Sample using the computed posterior values as weights In this example we keep the number of samples equal to the length of p_grid, but that is not required.samples = sample(p_grid, Weights(posterior), length(p_grid));\np = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\np[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\", fill=(0, .5,:orange))\nplot(p..., layout=(1, 2))End of clip_01_06.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_07.0s/#",
    "page": "clip_07.0s",
    "title": "clip_07.0s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_07.0s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_07.0s/#snippet-4.7-1",
    "page": "clip_07.0s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)\nfemale_df = filter(row -> row[:male] == 0, df2)\nmale_df = filter(row -> row[:male] == 1, df2)Plot the densities.density(df2[:height], lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")Is it bi-modal?density!(female_df[:height], lab=\"Female heights\")\ndensity!(male_df[:height], lab=\"Male heights\")Define the Stan language modelheightsmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  real<lower=0> h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=0,upper=250> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ normal(178, 20);\n  sigma ~ uniform( 0 , 50 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the density of posterior drawsdensity(chn, lab=\"All heights\", xlab=\"height [cm]\", ylab=\"density\")End of clip_07.0s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_07.1s/#",
    "page": "clip_07.1s",
    "title": "clip_07.1s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_07.1s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking, CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_07.1s/#snippet-4.7-1",
    "page": "clip_07.1s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelheightsmodel = \"\n// Inferring a Rate\ndata {\n  int N;\n  real<lower=0> h[N];\n}\nparameters {\n  real<lower=0> sigma;\n  real<lower=0,upper=250> mu;\n}\nmodel {\n  // Priors for mu and sigma\n  mu ~ uniform(100, 250);\n  sigma ~ cauchy( 0 , 1 );\n\n  // Observed heights\n  h ~ normal(mu, sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"heights\", monitors = [\"mu\", \"sigma\"],model=heightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"h\" => df2[:height])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Compare with previous resultclip_07s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean        SD      Naive SE      MCSE      ESS\nsigma   7.7641718 0.3055115 0.004830561 0.0047596714 1000\n   mu 154.6042417 0.4158242 0.006574758 0.0068304868 1000\n\nQuantiles:\n         2.5%       25.0%       50.0%      75.0%      97.5%\nsigma   7.198721   7.5573575   7.749435   7.960795   8.393317\n   mu 153.795975 154.3307500 154.610000 154.884000 155.391050\n\n\";Plot the density of posterior drawsdensity(chn, xlab=\"height [cm]\", ylab=\"density\")End of clip_07.1s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_38.0s/#",
    "page": "clip_38.0s",
    "title": "clip_38.0s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_38.0s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_38.0s/#snippet-4.38-1",
    "page": "clip_38.0s",
    "title": "snippet 4.38",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Compare with a previous resultclip_38s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean         SD       Naive SE       MCSE     ESS\nalpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000\n beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000\nsigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750\n beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574\nsigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417\n\n\";Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = 30.0:0.1:65.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df2[:weight], df2[:height], lab=\"Observations\",\n  xlab=\"weight [kg]\", ylab=\"height [cm]\")\nplot!(xi, yi, lab=\"Regression line\")End of clip_38.0s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_38.1s/#",
    "page": "clip_38.1s",
    "title": "clip_38.1s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_38.1s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_38.1s/#snippet-4.38-1",
    "page": "clip_38.1s",
    "title": "snippet 4.38",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\ntransformed parameters {\n  vector[N] mu; // Intermediate mu\n  for (i in 1:N)\n    mu[i] = alpha + beta*weight[i];\n}\n\nmodel {\n height ~ normal(mu , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanweightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, weightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Compare with a previous resultclip_38s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean         SD       Naive SE       MCSE     ESS\nalpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000\n beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000\nsigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750\n beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574\nsigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417\nsigma   3.9447100   4.1530675   4.254755   4.36483000   4.5871028\n\";Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = 30.0:0.1:65.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df2[:weight], df2[:height], lab=\"Observations\",\n  xlab=\"weight [kg]\", ylab=\"heigth [cm]\")\nplot!(xi, yi, lab=\"Regression line\")End of clip_38.1s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_38.2s/#",
    "page": "clip_38.2s",
    "title": "clip_38.2s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_38.2s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_38.2s/#snippet-4.38-1",
    "page": "clip_38.2s",
    "title": "snippet 4.38",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N;\n vector[N] height;\n vector[N] weight;\n}\n\nparameters {\n real alpha;\n real beta;\n real < lower = 0, upper = 50 > sigma;\n}\n\nmodel {priors  alpha ~ normal(178, 100);\n  beta ~ normal(0, 10);\n  sigma ~ uniform(0, 50);model  height ~ normal(alpha + beta*weight , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],\n  model=weightsmodel, output_format=:mcmcchain);Input data for cmdstanweightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, weightsdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Compare with a previous resultclip_38s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean         SD       Naive SE       MCSE     ESS\nalpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000\n beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000\nsigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750\n beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574\nsigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417\nsigma   3.9447100   4.1530675   4.254755   4.36483000   4.5871028\n\";Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = 30.0:0.1:65.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df2[:weight], df2[:height], lab=\"Observations\",\n  xlab=\"weight [kg]\", ylab=\"heigth [cm]\")\nplot!(xi, yi, lab=\"Regression line\")End of clip_38.1s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_38.3s/#",
    "page": "clip_38.3s",
    "title": "clip_38.3s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_38.3s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_38.3s/#snippet-4.38-1",
    "page": "clip_38.3s",
    "title": "snippet 4.38",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelweightsmodel = \"\ndata {\n  int<lower=1> N;\n  vector[N] height;\n  vector[N] weight;\n}\nparameters {\n  real alpha;\n  real beta;\n  real<lower=0,upper=50> sigma;\n}\nmodel {\n  vector[N] mu = alpha + beta * weight;\n  target += normal_lpdf(height | mu, sigma);\n  target += normal_lpdf(alpha | 178, 20);\n  target += normal_lpdf(beta | 0, 10);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],\n  model=weightsmodel, output_format=:mcmcchain);Input data for cmdstanweightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, weightsdata, ProjDir, diagnostics=false,\n  summary=false, CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Compare with a previous resultclip_38s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean         SD       Naive SE       MCSE     ESS\nalpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000\n beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000\nsigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750\n beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574\nsigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417\nsigma   3.9447100   4.1530675   4.254755   4.36483000   4.5871028\n\";Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = 30.0:0.1:65.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df2[:weight], df2[:height], lab=\"Observations\",\n  xlab=\"weight [kg]\", ylab=\"heigth [cm]\")\nplot!(xi, yi, lab=\"Regression line\")End of clip_38.1s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_38.0m/#",
    "page": "clip_38.0m",
    "title": "clip_38.0m",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_38.0m.jl\"using StatisticalRethinking, Distributed, JLD\nusing Mamba\n\n# Data\nline = Dict{Symbol, Any}()\n\nhowell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);\nline[:x] = convert(Array{Float64,1}, df2[:weight]);\nline[:y] = convert(Array{Float64,1}, df2[:height]);\nline[:xmat] = convert(Array{Float64,2}, [ones(length(line[:x])) line[:x]])\n\n# Model Specification\nmodel = Model(\n  y = Stochastic(1,\n    (xmat, beta, s2) -> MvNormal(xmat * beta, sqrt(s2)),\n    false\n  ),\n  beta = Stochastic(1, () -> MvNormal([178, 0], [sqrt(10000), sqrt(100)])),\n  s2 = Stochastic(() -> Uniform(0, 50))\n)\n\n# Initial Values\ninits = [\n  Dict{Symbol, Any}(\n    :y => line[:y],\n    :beta => [rand(Normal(178, 100)), rand(Normal(0, 10))],\n    :s2 => rand(Uniform(0, 50))\n  )\n  for i in 1:3\n]\n\n# Tuning Parameters\nscale1 = [0.5, 0.25]\nsummary1 = identity\neps1 = 0.5\n\nscale2 = 0.5\nsummary2 = x -> [mean(x); sqrt(var(x))]\neps2 = 0.1\n\n# Define sampling scheme\n\nscheme = [\n  Mamba.NUTS([:beta]),\n  Mamba.Slice([:s2], 10)\n]\n\nsetsamplers!(model, scheme)\n\n# MCMC Simulation\n\nsim = mcmc(model, line, inits, 10000, burnin=1000, chains=3)Show draws summarydescribe(sim)End of clip_38.0m.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_38.1m/#",
    "page": "clip_38.1m",
    "title": "clip_38.1m",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_38.1m.jl\"using StatisticalRethinking, Distributed, JLD, LinearAlgebra\nusing MambaDatahowell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Input data for Mambadata = Dict(\n  :x => convert(Array{Float64,1}, df2[:weight]),\n  :y => convert(Array{Float64,1}, df2[:height])\n);Log-transformed Posterior(b0, b1, log(s2)) + Constant and Gradient Vectorlogfgrad = function(x::DenseVector)\n  b0 = x[1]\n  b1 = x[2]\n  logs2 = x[3]\n  r = data[:y] .- b0 .- b1 .* data[:x]\n  logf = (-0.5 * length(data[:y]) - 0.001) * logs2 -\n           (0.5 * dot(r, r) + 0.001) / exp(logs2) -\n           0.5 * b0^2 / 1000 - 0.5 * b1^2 / 1000\n  grad = [\n    sum(r) / exp(logs2) - b0 / 1000,\n    sum(data[:x] .* r) / exp(logs2) - b1 / 1000,\n    -0.5 * length(data[:y]) - 0.001 + (0.5 * dot(r, r) + 0.001) / exp(logs2)\n  ]\n  logf, grad\nend\n\n# MCMC Simulation with No-U-Turn Sampling\n\nn = 5000\nburnin = 1000\nsim = Mamba.Chains(n, 3, start = (burnin + 1), names = [\"b0\", \"b1\", \"s2\"])\ntheta = NUTSVariate([0.0, 0.0, 0.0], logfgrad)\nfor i in 1:n\n  sample!(theta, adapt = (i <= burnin))\n  if i > burnin\n    sim[i, :, 1] = [theta[1:2]; exp(theta[3])]\n  end\nendSummarize drawsdescribe(sim)#-This page was generated using Literate.jl."
},

{
    "location": "04/clip_43s/#",
    "page": "clip_43s",
    "title": "clip_43s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_43s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_43s/#snippet-4.7-1",
    "page": "clip_43s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)\nmean_weight = mean(df2[:weight])\ndf2[:weight] = convert(Vector{Float64}, df2[:weight]) .- mean_weight ;Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME)Describe the drawsdescribe(chn)Compare with a previous resultclip_38s_example_output = \"\n\nSamples were drawn using hmc with nuts.\nFor each parameter, N_Eff is a crude measure of effective sample size,\nand R_hat is the potential scale reduction factor on split chains (at\nconvergence, R_hat=1).\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n          Mean         SD       Naive SE       MCSE     ESS\nalpha 113.82267275 1.89871177 0.0300212691 0.053895503 1000\n beta   0.90629952 0.04155225 0.0006569987 0.001184630 1000\nsigma   5.10334279 0.19755211 0.0031235731 0.004830464 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 110.1927000 112.4910000 113.7905000 115.1322500 117.5689750\n beta   0.8257932   0.8775302   0.9069425   0.9357115   0.9862574\nsigma   4.7308260   4.9644050   5.0958800   5.2331875   5.5133417\n\n\";Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = -16.0:0.1:18.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df2[:weight], df2[:height], lab=\"Observations\",\n  ylab=\"height [cm]\", xlab=\"weight[kg]\")\nplot!(xi, yi, lab=\"Regression line\")End of clip_43s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_43t/#",
    "page": "clip_43t",
    "title": "clip_43t",
    "category": "page",
    "text": "using StatisticalRethinking\ngr(size=(500,500));\n\nTuring.setadbackend(:reverse_diff)\n\nProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)loaded\n\n\n┌ Warning: Package Turing does not have CmdStan in its dependencies:\n│ - If you have Turing checked out for development and have\n│   added CmdStan as a dependency but haven\'t updated your primary\n│   environment\'s manifest file, try `Pkg.resolve()`.\n│ - Otherwise you may need to report an issue with Turing\n│ Loading CmdStan into Turing from project dependency, future warnings for Turing are suppressed.\n└ @ nothing nothing:840\nWARNING: using CmdStan.Sample in module Turing conflicts with an existing identifier."
},

{
    "location": "04/clip_43t/#snippet-4.43-1",
    "page": "clip_43t",
    "title": "snippet 4.43",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Center the weight observations and add a column to df2mean_weight = mean(df2[:weight])\ndf2 = hcat(df2, df2[:weight] .- mean_weight)\nrename!(df2, :x1 => :weight_c); # Rename our col :x1 => :weight_cExtract variables for Turing modely = convert(Vector{Float64}, df2[:height]);\nx = convert(Vector{Float64}, df2[:weight_c]);Define the regression model@model line(y, x) = begin\n    #priors\n    alpha ~ Normal(178.0, 100.0)\n    beta ~ Normal(0.0, 10.0)\n    s ~ Uniform(0, 50)\n\n    #model\n    mu = alpha .+ beta*x\n    for i in 1:length(y)\n      y[i] ~ Normal(mu[i], s)\n    end\nend;Disable updating progress of sampling processTuring.turnprogress(false);┌ Info: [Turing]: global PROGRESS is set as false\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/Turing.jl:81Draw the sampleschn = sample(line(y, x), Turing.NUTS(2000, 1000, 0.65));┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/support/hmc_core.jl:246\n[NUTS{Union{}}] found initial ϵ: 0.0015625\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/support/hmc_core.jl:291\n┌ Warning: Numerical error has been found in gradients.\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/core/ad.jl:114\n┌ Warning: grad = [9.77018, -246.999, NaN]\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/core/ad.jl:115\n┌ Info:  Adapted ϵ = 0.044462752933641304, std = [1.0, 1.0, 1.0]; 1000 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/pRhjG/src/samplers/adapt/adapt.jl:91\n\n\n[NUTS] Finished with\n  Running time        = 189.38645733500005;\n  #lf / sample        = 0.004;\n  #evals / sample     = 20.942;\n  pre-cond. metric    = [1.0, 1.0, 1.0].Describe the chain result#describe(chn)\nfor var in [:alpha, :beta, :s]\n  println(\"$var = \",  mean_and_std(chn[Symbol(var)][1001:2000]))\nendalpha = (154.61078700045508, 0.2724353848980195)\nbeta = (0.9066138974896988, 0.04095449280236761)\ns = (5.098763886954905, 0.19522522291317368)Compare with a previous resultclip_43s_example_output = \"\n\nIterations = 1:1000\nThinning interval = 1\nChains = 1,2,3,4\nSamples per chain = 1000\n\nEmpirical Posterior Estimates:\n         Mean        SD       Naive SE       MCSE      ESS\nalpha 154.597086 0.27326431 0.0043206882 0.0036304132 1000\n beta   0.906380 0.04143488 0.0006551430 0.0006994720 1000\nsigma   5.106643 0.19345409 0.0030587777 0.0032035103 1000\n\nQuantiles:\n          2.5%       25.0%       50.0%       75.0%       97.5%\nalpha 154.0610000 154.4150000 154.5980000 154.7812500 155.1260000\n beta   0.8255494   0.8790695   0.9057435   0.9336445   0.9882981\nsigma   4.7524368   4.9683400   5.0994450   5.2353100   5.5090128\n\";Example result for Turing with centered weights (appears biased)clip_43t_example_output = \"\n\n[NUTS] Finished with\n  Running time        = 163.20725027799972;\n  #lf / sample        = 0.006;\n  #evals / sample     = 19.824;\n  pre-cond. metric    = [1.0, 1.0, 1.0].\n\n               Mean                SD\nalpha = (154.6020248402468, 0.24090814737592972)\nbeta = (0.9040183717679473, 0.0422796486734481)\ns = (5.095714121087817, 0.18455074897377258)\n\n\";Plot the regerssion line and observationsxi = -15.0:0.1:15.0\nyi = mean(chn[:alpha]) .+ mean(chn[:beta])*xi\n\nscatter(x, y, lab=\"Observations\", xlab=\"weight\", ylab=\"height\")\nplot!(xi, yi, lab=\"Regression line\")(Image: svg)End of clip_43t.jlThis notebook was generated using Literate.jl."
},

{
    "location": "04/clip_45_47s/#",
    "page": "clip_45_47s",
    "title": "clip_45_47s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_45_47s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_45_47s/#snippet-4.7-1",
    "page": "clip_45_47s",
    "title": "snippet 4.7",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df)Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstanheightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME)Show first 5 individual draws of correlated parameter values in chain 1chn.value[1:5,:,1]Plot estimates using the N = [10, 50, 150, 352] observationsp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\nnvals = [10, 50, 150, 352]\n\nfor i in 1:length(nvals)\n  N = nvals[i]\n  heightsdataN = [\n    Dict(\"N\" => N, \"height\" => df2[1:N, :height], \"weight\" => df2[1:N, :weight])\n  ]\n  rc, chnN, cnames = stan(stanmodel, heightsdataN, ProjDir, diagnostics=false,\n    summary=false, CmdStanDir=CMDSTAN_HOME)\n\n  xi = 30.0:0.1:65.0\n  rws, vars, chns = size(chnN[:, 1, :])\n  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))\n  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))\n\n  p[i] = scatter(df2[1:N, :weight], df2[1:N, :height], leg=false, xlab=\"weight\")\n  for j in 1:N\n    yi = alpha_vals[j] .+ beta_vals[j]*xi\n    plot!(p[i], xi, yi, title=\"N = $N\")\n  end\nend\nplot(p..., layout=(2, 2))End of clip_45_47s.jlThis page was generated using Literate.jl."
},

{
    "location": "04/clip_48_54s/#",
    "page": "clip_48_54s",
    "title": "clip_48_54s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/04/clip_48_54s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"04\")\ncd(ProjDir)"
},

{
    "location": "04/clip_48_54s/#Preliminary-snippets-1",
    "page": "clip_48_54s",
    "title": "Preliminary snippets",
    "category": "section",
    "text": "howell1 = CSV.read(rel_path(\"..\", \"data\", \"Howell1.csv\"), delim=\';\')\ndf = convert(DataFrame, howell1);Use only adultsdf2 = filter(row -> row[:age] >= 18, df);Center weight and store as weight_cmean_weight = mean(df2[:weight])\ndf2 = hcat(df2, df2[:weight] .- mean_weight)\nrename!(df2, :x1 => :weight_c); # Rename our col :x1 => :weight_c\ndf2Define the Stan language modelweightsmodel = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] height; // Predictor\n vector[N] weight; // Outcome\n}\n\nparameters {\n real alpha; // Intercept\n real beta; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\nmodel {\n height ~ normal(alpha + weight * beta , sigma);\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"weights\", monitors = [\"alpha\", \"beta\", \"sigma\"],model=weightsmodel,\n  output_format=:mcmcchain);Input data for cmdstan.heightsdata = [\n  Dict(\"N\" => length(df2[:height]), \"height\" => df2[:height], \"weight\" => df2[:weight_c])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);"
},

{
    "location": "04/clip_48_54s/#Snippet-4.47-1",
    "page": "clip_48_54s",
    "title": "Snippet 4.47",
    "category": "section",
    "text": "Show first 5 individual draws of correlated parameter values in chain 1chn.value[1:5,:,1]"
},

{
    "location": "04/clip_48_54s/#Snippets-4.48-and-4.49-1",
    "page": "clip_48_54s",
    "title": "Snippets 4.48 & 4.49",
    "category": "section",
    "text": "Plot estimates using the N = [10, 50, 150, 352] observationsnvals = [10, 50, 150, 352];Create the 4 nvals plotsp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\nfor i in 1:length(nvals)\n  N = nvals[i]\n  heightsdataN = [\n    Dict(\"N\" => N, \"height\" => df2[1:N, :height], \"weight\" => df2[1:N, :weight_c])\n  ]\n  rc, chnN, cnames = stan(stanmodel, heightsdataN, ProjDir, diagnostics=false,\n    summary=false, CmdStanDir=CMDSTAN_HOME)\n\n  rws, vars, chns = size(chnN[:, 1, :])\n  xi = -15.0:0.1:15.0\n  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))\n  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))\n\n  p[i] = scatter(df2[1:N, :weight_c], df2[1:N, :height], leg=false, xlab=\"weight_c\")\n  for j in 1:N\n    yi = alpha_vals[j] .+ beta_vals[j]*xi\n    plot!(p[i], xi, yi, title=\"N = $N\")\n  end\nend\nplot(p..., layout=(2, 2))"
},

{
    "location": "04/clip_48_54s/#Snippet-4.50-1",
    "page": "clip_48_54s",
    "title": "Snippet 4.50",
    "category": "section",
    "text": "Get dimensions of chainsrws, vars, chns = size(chn[:, 1, :])\nmu_at_50 = link(50:10:50, chn, [1, 2], mean_weight);\ndensity(mu_at_50)"
},

{
    "location": "04/clip_48_54s/#Snippet-4.54-1",
    "page": "clip_48_54s",
    "title": "Snippet 4.54",
    "category": "section",
    "text": "Show posterior density for 6 mu_bar valuesmu = link(25:10:75, chn, [1, 2], mean_weight);\n\nq = Vector{Plots.Plot{Plots.GRBackend}}(undef, size(mu, 1))\nfor i in 1:size(mu, 1)\n  q[i] = density(mu[i], ylim=(0.0, 1.5),\n    leg=false, title=\"mu_bar = $(round(mean(mu[i]), digits=1))\")\nend\n\nplot(q..., layout=(2, 3), ticks=(3))End of clip_48_54s.jlThis page was generated using Literate.jl."
},

{
    "location": "05/clip_01s/#",
    "page": "clip_01s",
    "title": "clip_01s",
    "category": "page",
    "text": "EditURL = \"https://github.com/StanJulia/StatisticalRethinking.jl/blob/master/chapters/05/clip_01s.jl\"Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\nusing CmdStan, StanMCMCChain\ngr(size=(500,500));CmdStan uses a tmp directory to store the output of cmdstanProjDir = rel_path(\"..\", \"chapters\", \"05\")\ncd(ProjDir)"
},

{
    "location": "05/clip_01s/#snippet-5.1-1",
    "page": "clip_01s",
    "title": "snippet 5.1",
    "category": "section",
    "text": "wd = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\",\n  \"data\", \"WaffleDivorce.csv\"), delim=\';\')\ndf = convert(DataFrame, wd);\nmean_ma = mean(df[:MedianAgeMarriage])\ndf[:MedianAgeMarriage] = convert(Vector{Float64},\n  df[:MedianAgeMarriage]) .- mean_ma;Define the Stan language modelad_model = \"\ndata {\n int < lower = 1 > N; // Sample size\n vector[N] divorce; // Predictor\n vector[N] median_age; // Outcome\n}\n\nparameters {\n real a; // Intercept\n real bA; // Slope (regression coefficients)\n real < lower = 0 > sigma; // Error SD\n}\n\ntransformed parameters {\n  vector[N] mu; // Intermediate mu\n  for (i in 1:N)\n    mu[i] = a + bA*median_age[i];\n}\n\nmodel {priors  a ~ normal(10, 10);\n  bA ~ normal(0, 1);\n  sigma ~ uniform(0, 10);model  divorce ~ normal(mu , sigma);\n}\n\ngenerated quantities {\n}\n\";Define the Stanmodel and set the output format to :mcmcchain.stanmodel = Stanmodel(name=\"MedianAgeDivorce\", monitors = [\"a\", \"bA\", \"sigma\"],\n  model=ad_model, output_format=:mcmcchain);Input data for cmdstanmaddata = [\n  Dict(\"N\" => length(df[:Divorce]), \"divorce\" => df[:Divorce],\n    \"median_age\" => df[:MedianAgeMarriage])\n];Sample using cmdstanrc, chn, cnames = stan(stanmodel, maddata, ProjDir, diagnostics=false,\n  CmdStanDir=CMDSTAN_HOME);Describe the drawsdescribe(chn)Plot the density of posterior drawsplot(chn)Plot regression line using means and observationsxi = -3.0:0.1:3.0\nrws, vars, chns = size(chn[:, 1, :])\nalpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))\nbeta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))\nyi = mean(alpha_vals) .+ mean(beta_vals)*xi\n\nscatter(df[:MedianAgeMarriage], df[:Divorce], lab=\"Observations\",\n  xlab=\"Median age of marriage\", ylab=\"divorce\")\nplot!(xi, yi, lab=\"Regression line\")Plot estimates using the N = [10, 50, 150, 352] observationsp = Vector{Plots.Plot{Plots.GRBackend}}(undef, 4)\nnvals = [10, 20, 35, 50]\n\nfor i in 1:length(nvals)\n  N = nvals[i]\n  maddataN = [\n    Dict(\"N\" => N, \"divorce\" => df[1:N, :Divorce],\n      \"median_age\" => df[1:N, :MedianAgeMarriage])\n  ]\n  rc, chnN, cnames = stan(stanmodel, maddataN, ProjDir, diagnostics=false,\n    summary=false, CmdStanDir=CMDSTAN_HOME)\n\n  xi = -3.0:0.1:3.0\n  rws, vars, chns = size(chnN[:, 1, :])\n  alpha_vals = convert(Vector{Float64}, reshape(chnN.value[:, 1, :], (rws*chns)))\n  beta_vals = convert(Vector{Float64}, reshape(chnN.value[:, 2, :], (rws*chns)))\n\n  p[i] = scatter(df[1:N, :MedianAgeMarriage], df[1:N, :Divorce],\n    leg=false, xlab=\"Median age of marriage\")\n  for j in 1:N\n    yi = alpha_vals[j] .+ beta_vals[j]*xi\n    plot!(p[i], xi, yi, title=\"N = $N\")\n  end\nend\nplot(p..., layout=(2, 2))End of 05/clip_01s.jlThis page was generated using Literate.jl."
},

{
    "location": "08/m8.1t/#",
    "page": "m8.1t.jl",
    "title": "m8.1t.jl",
    "category": "page",
    "text": ""
},

{
    "location": "08/m8.1t/#m8.1stan-1",
    "page": "m8.1t.jl",
    "title": "m8.1stan",
    "category": "section",
    "text": "m8.1stan is the first model in the Statistical Rethinking book (pp. 249) using Stan.Here we will use Turing\'s NUTS support, which is currently (2018) the originalNUTS by Hoffman & Gelman and not the one that\'s in Stan 2.18.2, i.e., Appendix A.5.The StatisticalRethinking pkg uses, e.g., Turing, CSV, DataFramesusing StatisticalRethinkingloaded\n\n\n┌ Warning: Package Turing does not have CmdStan in its dependencies:\n│ - If you have Turing checked out for development and have\n│   added CmdStan as a dependency but haven\'t updated your primary\n│   environment\'s manifest file, try `Pkg.resolve()`.\n│ - Otherwise you may need to report an issue with Turing\n│ Loading CmdStan into Turing from project dependency, future warnings for Turing are suppressed.\n└ @ nothing nothing:840\nWARNING: using CmdStan.Sample in module Turing conflicts with an existing identifier.Read in rugged data as a DataFramed = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), \"..\", \"data\",\n    \"rugged.csv\"), delim=\';\');\n# Show size of the DataFrame (should be 234x51)\nsize(d)(234, 51)Apply log() to each element in rgdppc_2000 column and add it as a new columnd = hcat(d, map(log, d[Symbol(\"rgdppc_2000\")]));Rename our col x1 => log_gdprename!(d, :x1 => :log_gdp);Now we need to drop every row where rgdppc_2000 == missingWhen this (https://github.com/JuliaData/DataFrames.jl/pull/1546) hits DataFrame it\'ll be conceptually easier: i.e., completecases!(d, :rgdppc_2000)notisnan(e) = !ismissing(e)\ndd = d[map(notisnan, d[:rgdppc_2000]), :];Updated DataFrame dd size (should equal 170 x 52)size(dd)(170, 52)Define the Turing model@model m8_1stan(y, x₁, x₂) = begin\n    σ ~ Truncated(Cauchy(0, 2), 0, Inf)\n    βR ~ Normal(0, 10)\n    βA ~ Normal(0, 10)\n    βAR ~ Normal(0, 10)\n    α ~ Normal(0, 100)\n\n    for i ∈ 1:length(y)\n        y[i] ~ Normal(α + βR * x₁[i] + βA * x₂[i] + βAR * x₁[i] * x₂[i], σ)\n    end\nend;Test to see that the model is sane. Use 2000 for now, as in the book. Need to set the same stepsize and adapt_delta as in Stan...posterior = sample(m8_1stan(dd[:,:log_gdp], dd[:,:rugged], dd[:,:cont_africa]),\n    Turing.NUTS(2000, 1000, 0.95));\n# Describe the posterior samples\ndescribe(posterior)┌ Warning: Indexing with colon as row will create a copy in the future. Use `df[col_inds]` to get the columns without copying\n│   caller = top-level scope at In[8]:1\n└ @ Core In[8]:1\n┌ Warning: Indexing with colon as row will create a copy in the future. Use `df[col_inds]` to get the columns without copying\n│   caller = top-level scope at In[8]:1\n└ @ Core In[8]:1\n┌ Warning: Indexing with colon as row will create a copy in the future. Use `df[col_inds]` to get the columns without copying\n│   caller = top-level scope at In[8]:1\n└ @ Core In[8]:1\n┌ Info: [Turing] looking for good initial eps...\n└ @ Turing /Users/rob/.julia/packages/Turing/orJH9/src/samplers/support/hmc_core.jl:246\n[NUTS{Union{}}] found initial ϵ: 0.05\n└ @ Turing /Users/rob/.julia/packages/Turing/orJH9/src/samplers/support/hmc_core.jl:291\n[32m[NUTS] Sampling...  1%  ETA: 0:06:54[39m\n[34m  ϵ:         0.021702349971125082[39m\n[34m  α:         0.9890516933991319[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...  2%  ETA: 0:05:49[39m\n[34m  ϵ:         0.025964213600878867[39m\n[34m  α:         0.8596042698404098[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...  3%  ETA: 0:04:25[39m\n[34m  ϵ:         0.014815766991558857[39m\n[34m  α:         0.9934963906380034[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...  4%  ETA: 0:03:49[39m\n[34m  ϵ:         0.032734674808041646[39m\n[34m  α:         0.8267264305201034[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...  5%  ETA: 0:03:11[39m\n[34m  ϵ:         0.03183906486749323[39m\n[34m  α:         0.9980435182012655[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...  6%  ETA: 0:02:52[39m\n[34m  ϵ:         0.02332219042746582[39m\n[34m  α:         0.9938986598752901[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...  7%  ETA: 0:02:42[39m\n[34m  ϵ:         0.022765193972566565[39m\n[34m  α:         0.9963929753051147[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...  8%  ETA: 0:02:32[39m\n[34m  ϵ:         0.018115226291014586[39m\n[34m  α:         0.9831564890831901[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...  9%  ETA: 0:02:24[39m\n[34m  ϵ:         0.0264916665322655[39m\n[34m  α:         0.9887844525209211[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 10%  ETA: 0:02:16[39m\n[34m  ϵ:         0.021575607716437604[39m\n[34m  α:         0.9749267632446936[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 11%  ETA: 0:02:10[39m\n[34m  ϵ:         0.03141462283517077[39m\n[34m  α:         0.8714611472530431[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 12%  ETA: 0:02:04[39m\n[34m  ϵ:         0.02939689779238441[39m\n[34m  α:         0.9984025534187178[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 13%  ETA: 0:02:03[39m\n[34m  ϵ:         0.01909107851666875[39m\n[34m  α:         0.9992739975281155[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 14%  ETA: 0:02:02[39m\n[34m  ϵ:         0.021149241662058213[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 15%  ETA: 0:01:58[39m\n[34m  ϵ:         0.023888285400989993[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 16%  ETA: 0:01:57[39m\n[34m  ϵ:         0.01889749833742631[39m\n[34m  α:         0.9178221360475471[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 16%  ETA: 0:01:54[39m\n[34m  ϵ:         0.03289091879046056[39m\n[34m  α:         0.9983176872334326[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 18%  ETA: 0:01:51[39m\n[34m  ϵ:         0.03143636930148497[39m\n[34m  α:         0.973450644644926[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 19%  ETA: 0:01:48[39m\n[34m  ϵ:         0.03333568334968122[39m\n[34m  α:         0.8802416912910938[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 19%  ETA: 0:01:47[39m\n[34m  ϵ:         0.024860129757923958[39m\n[34m  α:         0.9465574509975048[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 20%  ETA: 0:01:45[39m\n[34m  ϵ:         0.024147271950740724[39m\n[34m  α:         0.9963454219465105[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 21%  ETA: 0:01:42[39m\n[34m  ϵ:         0.02841750041302116[39m\n[34m  α:         0.9915183507724583[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 23%  ETA: 0:01:38[39m\n[34m  ϵ:         0.03477889821030197[39m\n[34m  α:         0.9620996967069368[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 24%  ETA: 0:01:35[39m\n[34m  ϵ:         0.02292329764909516[39m\n[34m  α:         0.9531273994262867[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 25%  ETA: 0:01:34[39m\n[34m  ϵ:         0.03465171740982106[39m\n[34m  α:         0.9696570042137486[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 26%  ETA: 0:01:32[39m\n[34m  ϵ:         0.03154099794490125[39m\n[34m  α:         0.9666588241056846[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 27%  ETA: 0:01:30[39m\n[34m  ϵ:         0.025445032131723687[39m\n[34m  α:         0.9987618606606394[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 28%  ETA: 0:01:29[39m\n[34m  ϵ:         0.02700948014435288[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 29%  ETA: 0:01:26[39m\n[34m  ϵ:         0.04045178285341591[39m\n[34m  α:         0.9962842848999183[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 30%  ETA: 0:01:24[39m\n[34m  ϵ:         0.015560536869733648[39m\n[34m  α:         0.9822753019048962[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 31%  ETA: 0:01:23[39m\n[34m  ϵ:         0.022521210797718835[39m\n[34m  α:         0.9747560489912214[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 32%  ETA: 0:01:21[39m\n[34m  ϵ:         0.036886036835501936[39m\n[34m  α:         0.9641170285183496[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 33%  ETA: 0:01:18[39m\n[34m  ϵ:         0.03218803022030199[39m\n[34m  α:         0.8559107831132022[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 34%  ETA: 0:01:17[39m\n[34m  ϵ:         0.03217185677378528[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 36%  ETA: 0:01:14[39m\n[34m  ϵ:         0.029934090465140267[39m\n[34m  α:         0.9637935308868608[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 37%  ETA: 0:01:13[39m\n[34m  ϵ:         0.03766209842729723[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 38%  ETA: 0:01:11[39m\n[34m  ϵ:         0.022525648837685045[39m\n[34m  α:         0.979910303228714[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 39%  ETA: 0:01:10[39m\n[34m  ϵ:         0.01786061046273[39m\n[34m  α:         0.9771913428474581[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 40%  ETA: 0:01:09[39m\n[34m  ϵ:         0.028067342663153656[39m\n[34m  α:         0.9753760022954534[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 40%  ETA: 0:01:08[39m\n[34m  ϵ:         0.028986812476833282[39m\n[34m  α:         0.9375335119964464[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 41%  ETA: 0:01:07[39m\n[34m  ϵ:         0.032117279642967206[39m\n[34m  α:         0.9940669026916351[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 42%  ETA: 0:01:06[39m\n[34m  ϵ:         0.030737127864859708[39m\n[34m  α:         0.9821912777159816[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 43%  ETA: 0:01:05[39m\n[34m  ϵ:         0.026438391658241963[39m\n[34m  α:         0.9980480594684609[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 44%  ETA: 0:01:03[39m\n[34m  ϵ:         0.02780498401755003[39m\n[34m  α:         0.9379581388525683[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 45%  ETA: 0:01:02[39m\n[34m  ϵ:         0.021497580222665725[39m\n[34m  α:         0.997838993180469[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 46%  ETA: 0:01:01[39m\n[34m  ϵ:         0.030820042201476643[39m\n[34m  α:         0.9780183694318911[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 47%  ETA: 0:00:59[39m\n[34m  ϵ:         0.02581329680132846[39m\n[34m  α:         0.9602252978375723[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 48%  ETA: 0:00:58[39m\n[34m  ϵ:         0.04447510506264669[39m\n[34m  α:         0.9603561420806969[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 50%  ETA: 0:00:57[39m\n[34m  ϵ:         0.028028277925480596[39m\n[34m  α:         0.936555913265008[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m┌ Info:  Adapted ϵ = 0.028862387932864265, std = [1.0, 1.0, 1.0, 1.0, 1.0]; 1000 iterations is used for adaption.\n└ @ Turing /Users/rob/.julia/packages/Turing/orJH9/src/samplers/adapt/adapt.jl:91\n\n\n\n[32m[NUTS] Sampling... 51%  ETA: 0:00:55[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9731170875091677[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 52%  ETA: 0:00:54[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9323017998991567[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 53%  ETA: 0:00:53[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9903549704526096[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 54%  ETA: 0:00:51[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9978152996666327[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 55%  ETA: 0:00:50[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 56%  ETA: 0:00:49[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9745595306250021[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 57%  ETA: 0:00:48[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9364723452724012[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 58%  ETA: 0:00:47[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9882822029392492[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 59%  ETA: 0:00:46[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9764526530232573[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 60%  ETA: 0:00:44[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9945875964420767[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 61%  ETA: 0:00:42[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 62%  ETA: 0:00:41[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9962157248944833[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 63%  ETA: 0:00:40[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9890323655917073[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 65%  ETA: 0:00:38[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.8324021795495518[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 66%  ETA: 0:00:37[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9657150103723464[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 67%  ETA: 0:00:36[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9234381416818382[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 68%  ETA: 0:00:35[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9494730649956734[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 69%  ETA: 0:00:34[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.8784878588473566[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 69%  ETA: 0:00:33[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9935813628621196[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 70%  ETA: 0:00:32[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9727677401574897[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 71%  ETA: 0:00:31[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9942663653403332[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 73%  ETA: 0:00:29[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9439622157894664[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 74%  ETA: 0:00:28[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.999478295756282[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 75%  ETA: 0:00:27[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9729044361179782[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 75%  ETA: 0:00:26[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 76%  ETA: 0:00:26[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9894849332618576[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 77%  ETA: 0:00:25[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9978627128794907[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 78%  ETA: 0:00:24[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9929515657222006[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 79%  ETA: 0:00:23[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9993663615086615[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 80%  ETA: 0:00:22[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.99958917121676[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 81%  ETA: 0:00:21[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9948412904815331[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 82%  ETA: 0:00:20[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 82%  ETA: 0:00:19[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9846293914634091[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 83%  ETA: 0:00:18[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 84%  ETA: 0:00:17[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 85%  ETA: 0:00:16[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9867209387222736[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 86%  ETA: 0:00:15[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9757542419609502[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 88%  ETA: 0:00:13[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9098487923015703[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 89%  ETA: 0:00:12[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9116645340587638[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 90%  ETA: 0:00:11[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.8741954363453688[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 90%  ETA: 0:00:10[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.98152618446337[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 92%  ETA: 0:00:09[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         1.0[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 93%  ETA: 0:00:08[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.997082288585899[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 94%  ETA: 0:00:07[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9913409566691967[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 95%  ETA: 0:00:06[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9636173199279039[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 96%  ETA: 0:00:05[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.8274183984970295[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 97%  ETA: 0:00:04[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9899779190278849[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 98%  ETA: 0:00:03[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.906318260459193[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling... 98%  ETA: 0:00:02[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.9917617167298529[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n[32m[NUTS] Sampling...100%  ETA: 0:00:00[39m\n[34m  ϵ:         0.028862387932864265[39m\n[34m  α:         0.8337995406437935[39m\n[A4m  pre_cond:  [1.0, 1.0, 1.0, 1.0, 1.0][39m\n\n\n\n\n[NUTS] Finished with\n  Running time        = 107.10928417000004;\n  #lf / sample        = 0.0015;\n  #evals / sample     = 44.931;\n  pre-cond. metric    = [1.0, 1.0, 1.0, 1.0, 1.0].\n\n\n[32m[NUTS] Sampling...100% Time: 0:01:48[39m\n\n\nIterations = 1:2000\nThinning interval = 1\nChains = 1\nSamples per chain = 2000\n\nEmpirical Posterior Estimates:\n              Mean           SD         Naive SE        MCSE         ESS   \n       α    9.192198853  0.471485288 0.01054273155 0.03488051527  182.71345\n  lf_num    0.001500000  0.067082039 0.00150000000 0.00150000000 2000.00000\n      βA   -1.916864926  0.377451668 0.00844007588 0.02969740713  161.54207\n      βR   -0.195354050  0.142021349 0.00317569391 0.01008324641  198.38394\n       σ    0.968861418  0.295329191 0.00660376148 0.01871696223  248.96714\n elapsed    0.053554642  0.076105161 0.00170176314 0.00239230124 1012.03724\n epsilon    0.029681037  0.018393691 0.00041129543 0.00041492961 1965.11923\neval_num   44.931000000 25.521538227 0.57067894365 0.67314732101 1437.45232\n     βAR    0.386290432  0.160630677 0.00359181114 0.00838013229  367.41360\n      lp -249.858010884 17.850220615 0.39914306709 1.35731471511  172.95219\n  lf_eps    0.029681037  0.018393691 0.00041129543 0.00041492961 1965.11923\n\nQuantiles:\n              2.5%           25.0%          50.0%          75.0%          97.5%    \n       α    8.948743652    9.126714263    9.221557657    9.318783435    9.501543505\n  lf_num    0.000000000    0.000000000    0.000000000    0.000000000    0.000000000\n      βA   -2.368320692   -2.097968685   -1.938597291   -1.779472367   -1.451814577\n      βR   -0.361073257   -0.254798277   -0.204489451   -0.149987743   -0.042763334\n       σ    0.857642577    0.915085102    0.947928480    0.984199708    1.060340022\n elapsed    0.009562707    0.026420479    0.050147139    0.061298654    0.116432655\n epsilon    0.018468817    0.028417477    0.028862388    0.028862388    0.039981894\neval_num   10.000000000   22.000000000   46.000000000   46.000000000   94.000000000\n     βAR    0.118640406    0.298877960    0.395536816    0.480566011    0.656950733\n      lp -252.744273688 -249.297284956 -248.219714562 -247.399261183 -246.384239328\n  lf_eps    0.018468817    0.028417477    0.028862388    0.028862388    0.039981894Example of a Turing run simulation outputm_08_1t_turing_result = \"\n        Mean           SD        Naive SE        MCSE         ESS\nα    9.2140454953  0.416410339 0.00931121825 0.0303436655  188.324543\nβA  -1.9414588557  0.373885658 0.00836033746 0.0583949856   40.994586\nβR  -0.1987645549  0.158902372 0.00355316505 0.0128657961  152.541295\nσ    0.9722532977  0.440031013 0.00983939257 0.0203736871  466.473854\nβAR  0.3951414223  0.187780491 0.00419889943 0.0276680621   46.062071\n\";Here\'s the map2stan output from rethinkingm_08_1_map2stan_result = \"\n       Mean StdDev lower 0.89 upper 0.89 n_eff Rhat\n a      9.24   0.14       9.03       9.47   291    1\n bR    -0.21   0.08      -0.32      -0.07   306    1\n bA    -1.97   0.23      -2.31      -1.58   351    1\n bAR    0.40   0.13       0.20       0.63   350    1\n sigma  0.95   0.05       0.86       1.03   566    1\n\";\n\n#-This notebook was generated using Literate.jl."
},

]}
