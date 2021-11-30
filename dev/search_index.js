var documenterSearchIndex = {"docs":
[{"location":"references/#References","page":"References","title":"References","text":"","category":"section"},{"location":"references/","page":"References","title":"References","text":"This package is based on:","category":"page"},{"location":"references/","page":"References","title":"References","text":"McElreath: Statistical Rethinking 2nd edition","category":"page"},{"location":"references/","page":"References","title":"References","text":"There is no shortage of additional good books on Bayesian statistics. A few of my favorites are:","category":"page"},{"location":"references/","page":"References","title":"References","text":"Bolstad: Introduction to Bayesian statistics\nBolstad: Understanding Computational Bayesian Statistics\nGelman, Hill: Data Analysis Using Regression and Multilevel/Hierarchical Models\nKruschke: Doing Bayesian Data Analysis\nLee, Wagenmakers: Bayesian Cognitive Modeling\nGelman, Carlin, and others: Bayesian Data Analysis\nCausal Inference in Statistics - A Primer\nBetancourt: A Conceptual Introduction to Hamiltonian Monte Carlo","category":"page"},{"location":"acknowledgements/#Acknowledgements","page":"Acknowledgements","title":"Acknowledgements","text":"","category":"section"},{"location":"acknowledgements/","page":"Acknowledgements","title":"Acknowledgements","text":"Of course, without this excellent textbook by Richard McElreath, this package would not have been possible. The author has also been supportive of this work and gave permission to use the datasets.","category":"page"},{"location":"acknowledgements/","page":"Acknowledgements","title":"Acknowledgements","text":"Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8 and subsequent chapters. ","category":"page"},{"location":"acknowledgements/","page":"Acknowledgements","title":"Acknowledgements","text":"Tamas Papp has been very helpful during the development of the DynamicHMC versions of the models.","category":"page"},{"location":"acknowledgements/","page":"Acknowledgements","title":"Acknowledgements","text":"The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer are followed closely in several example scripts.","category":"page"},{"location":"acknowledgements/","page":"Acknowledgements","title":"Acknowledgements","text":"The increasing use of Particles to represent quap approximations is possible thanks to the package MonteCarloMeasurements.jl. Soss.jl and related write-ups introduced me to that option.","category":"page"},{"location":"acknowledgements/","page":"Acknowledgements","title":"Acknowledgements","text":"Developing rethinking must have been an on-going process over several years, StatisticalRethinking.jl and associated packages will likely follow a similar path.","category":"page"},{"location":"","page":"Functions","title":"Functions","text":"CurrentModule = StatisticalRethinking","category":"page"},{"location":"#sr_path","page":"Functions","title":"sr_path","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"sr_path(parts...)","category":"page"},{"location":"#StatisticalRethinking.sr_path-Tuple","page":"Functions","title":"StatisticalRethinking.sr_path","text":"sr_path\n\nRelative path using the StatisticalRethinking src/ directory.\n\nExample to get access to the data subdirectory\n\nsr_path(\"..\", \"data\")\n\nNote that in the projects, e.g. SR2StanPluto.jl and SR2TuringPluto.jl, the DrWatson approach is a better choics, i.e: sr_datadir(filename)\n\n\n\n\n\n","category":"method"},{"location":"#sr_datadir","page":"Functions","title":"sr_datadir","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"sr_datadir(parts...)","category":"page"},{"location":"#StatisticalRethinking.sr_datadir-Tuple","page":"Functions","title":"StatisticalRethinking.sr_datadir","text":"sr_datadir\n\nRelative path using the StatisticalRethinking src/ directory.\n\nExample to access Howell1.csv in StatisticalRethinking:\n\ndf = CSV.read(sr_datadir(\"Howell1.csv\"), DataFrame)\n\n\n\n\n\n","category":"method"},{"location":"#link","page":"Functions","title":"link","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"link","category":"page"},{"location":"#StatisticalRethinking.link","page":"Functions","title":"StatisticalRethinking.link","text":"link\n\nCompute the link function for standardized variables.\n\nlink(dfa, vars, xrange)\n\n\nRequired arguments\n\ndf::DataFrame                      : Chain samples converted to a DataFrame\nvars::Vector{Symbol}               : Variables in DataFrame (2 variables)\nxrange::range                      : Range over which link values are computed\n\nOptional arguments\n\nxbar::Float64                      : Mean value of observed predictor\nybar::Float64                      : Mean value of observed outcome (requires xbar argument)\n\nReturn values\n\nresult                             : Vector of link values\n\n\n\n\n\nlink\n\nGeneralized link function to evaluate callable for all parameters in dataframe over range of x values.\n\nlink(dfa, rx_to_val, xrange)\n\n\nRequired arguments\n\ndfa::DataFrame: data frame with parameters\nrx_to_val::Function: function of two arguments: row object and x\nxrange: sequence of x values to be evaluated on\n\nReturn values\n\nIs the vector, where each entry was calculated on each value from xrange. Every such entry is a list corresponding each row in the data frame.\n\nExamples\n\njulia> using StatisticalRethinking, DataFrames\n\njulia> d = DataFrame(:a => [1,2], :b=>[1,1])\n2×2 DataFrame\n Row │ a      b\n     │ Int64  Int64\n─────┼──────────────\n   1 │     1      1\n   2 │     2      1\n\njulia> link(d, (r,x) -> r.a+x*r.b, 1:2)\n2-element Vector{Vector{Int64}}:\n [2, 3]\n [3, 4]\n\n\n\n\n\n\n","category":"function"},{"location":"#lppd","page":"Functions","title":"lppd","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"lppd","category":"page"},{"location":"#StatisticalRethinking.lppd","page":"Functions","title":"StatisticalRethinking.lppd","text":"lppd\n\nGeneric version of Log Pointwise Predictive Density computation, which is similar to simulate function, but additionally computes log density for the target values.\n\nlppd(df, rx_to_dist, xseq, yseq)\n\n\nRequired arguments\n\ndf::DataFrame: data frame with parameters\nrx_to_dist::Function: callable with two arguments: row object and x value.\n\nHas to return Distribution instance\n\nxseq: sequence of x values to be passed to the callable\nyseq: sequence of target values for log density calculation.\n\nReturn values\n\nVector of float values with the same size as xseq and yseq.\n\nExamples\n\njulia> using StatisticalRethinking, DataFrames, Distributions\n\njulia> df = DataFrame(:mu => [0.0, 1.0])\n2×1 DataFrame\n Row │ mu\n     │ Float64\n─────┼─────────\n   1 │     0.0\n   2 │     1.0\n\njulia> lppd(df, (r, x) -> Normal(r.mu + x, 1.0), 0:3, 3:-1:0)\n4-element Vector{Float64}:\n -3.5331959794720684\n -1.1380087295845114\n -1.9106724357818656\n -6.082335295491998\n\n\n\n\n\n","category":"function"},{"location":"#rescale","page":"Functions","title":"rescale","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"rescale(x::Vector{Float64}, xbar::Float64, xstd::Float64)","category":"page"},{"location":"#StatisticalRethinking.rescale-Tuple{Vector{Float64}, Float64, Float64}","page":"Functions","title":"StatisticalRethinking.rescale","text":"rescale\n\nRescale a vector to \"un-standardize\", the opposite of scale!().\n\nrescale(x, xbar, xstd)\n\n\nExtended help\n\nRequired arguments\n\n* `x::Vector{Float64}`                 : Vector to be rescaled\n* `xbar`                               : Mean value for rescaling\n* `xstd`                               : Std for rescaling\n\nReturn values\n\n* `result::AbstractVector`             : Rescaled vector\n\n\n\n\n\n","category":"method"},{"location":"#sample","page":"Functions","title":"sample","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"sample(df::DataFrame, n; replace=true, ordered=false)","category":"page"},{"location":"#StatsBase.sample-Tuple{DataFrame, Any}","page":"Functions","title":"StatsBase.sample","text":"sample\n\nSample rows from a DataFrame\n\nMethod\n\nsample(df, n; replace, ordered) \n\nRequired arguments\n\n* `df::DataFrame`                      : DataFrame\n* `n::Int`                             : Number of samples\n\nOptional argument\n\n* `rng::AbstractRNG`                   : Random number generator\n* `replace::Bool=true`                 : Sample with replace \n* `ordered::Bool=false`                : Sort sample \n\nReturn values\n\n* `result`                             : Array of samples\n\n\n\n\n\n","category":"method"},{"location":"#hpdi","page":"Functions","title":"hpdi","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"hpdi(x::Vector{T}; alpha::Real=0.05) where {T<:Real}","category":"page"},{"location":"#StatisticalRethinking.hpdi-Union{Tuple{Vector{T}}, Tuple{T}} where T<:Real","page":"Functions","title":"StatisticalRethinking.hpdi","text":"hpdi\n\nCompute high density region.\n\nhpdi(x; alpha)\n\n\nDerived from hpd in MCMCChains.jl.\n\nBy default alpha=0.11 for a 2-sided tail area of p < 0.055% and p > 0.945%.\n\n\n\n\n\n","category":"method"},{"location":"#meanlowerupper","page":"Functions","title":"meanlowerupper","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"meanlowerupper(data, PI = (0.055, 0.945))","category":"page"},{"location":"#StatisticalRethinking.meanlowerupper","page":"Functions","title":"StatisticalRethinking.meanlowerupper","text":"meanlowerupper\n\nCompute a NamedTuple with means, lower and upper PI values.\n\nmeanlowerupper(data)\nmeanlowerupper(data, PI)\n\n\n\n\n\n\n","category":"function"},{"location":"#compare","page":"Functions","title":"compare","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"compare(m::Vector{Matrix{Float64}}, ::Val{:waic})","category":"page"},{"location":"#StatisticalRethinking.compare-Tuple{Vector{Matrix{Float64}}, Val{:waic}}","page":"Functions","title":"StatisticalRethinking.compare","text":"compare\n\nCompare waic and psis values for models.\n\ncompare(m, ; mnames)\n\n\nRequired arguments\n\n* `models`                             : Vector of logprob matrices\n* `criterium`                          : Either ::Val{:waic} or ::Val{:psis}\n\nOptional argument\n\n* `mnames::Vector{Symbol}`             : Vector of model names\n\nReturn values\n\n* `df`                                 : DataFrame with statistics\n\n\n\n\n\n","category":"method"},{"location":"#create_observation_matrix","page":"Functions","title":"create_observation_matrix","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"create_observation_matrix(x::Vector, k::Int)","category":"page"},{"location":"#StatisticalRethinking.create_observation_matrix-Tuple{Vector{T} where T, Int64}","page":"Functions","title":"StatisticalRethinking.create_observation_matrix","text":"pairsplot\n\nCreate a polynomial observation matrix.\n\ncreate_observation_matrix(x, k)\n\n\n\n\n\n\n","category":"method"},{"location":"#r2_is_bad","page":"Functions","title":"r2_is_bad","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"r2_is_bad(model::NamedTuple, df::DataFrame)","category":"page"},{"location":"#StatisticalRethinking.r2_is_bad-Tuple{NamedTuple, DataFrame}","page":"Functions","title":"StatisticalRethinking.r2_is_bad","text":"r2isbad\n\nCompute R^2 values.\n\nr2_is_bad(model, df)\n\n\n\n\n\n\n","category":"method"},{"location":"#PI","page":"Functions","title":"PI","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"PI","category":"page"},{"location":"#StatisticalRethinking.PI","page":"Functions","title":"StatisticalRethinking.PI","text":"PI\n\nCompute percentile central interval of data. Returns vector of bounds.\n\nPI(data; perc_prob)\n\n\nRequired arguments\n\ndata: iterable over data values\n\nOptional arguments\n\nprob::Float64=0.89: percentile interval to calculate\n\nExamples\n\njulia> using StatisticalRethinking\n\njulia> PI(1:10)\n2-element Vector{Float64}:\n 1.495\n 9.505\n\njulia> PI(1:10; prob=0.1)\n2-element Vector{Float64}:\n 5.05\n 5.95\n\n\n\n\n\n\n","category":"function"},{"location":"#var2","page":"Functions","title":"var2","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"var2(x)","category":"page"},{"location":"#StatisticalRethinking.var2-Tuple{Any}","page":"Functions","title":"StatisticalRethinking.var2","text":"var2\n\nVariance without n-1 correction.\n\nvar2(x)\n\n\n\n\n\n\n","category":"method"},{"location":"#sim_happiness","page":"Functions","title":"sim_happiness","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"sim_happiness","category":"page"},{"location":"#StatisticalRethinking.sim_happiness","page":"Functions","title":"StatisticalRethinking.sim_happiness","text":"sim_happiness\n\nsim_happiness(; seed, n_years, max_age, n_births, aom)\n\n\nSimulates hapiness using rules from section 6.3 of the book:\n\nEach year, 20 people are born with uniformly distributed happiness values.\nEach year, each person ages one year. Happiness does not change.\nAt age 18, individuals can become married. The odds of marriage each year are\n\nproportional to an individual’s happiness.\n\nOnce married, an individual remains married.\nAfter age 65, individuals leave the sample. (They move to Spain.)\n\nArguments:\n\nseed: random seed, default is no seed\nn_years: amount of years to simulate\nmax_age: maximum age people are living\nn_births: count of people are born every year\naom: at what age people can got married\n\nExamples\n\njulia> using StatisticalRethinking\n\njulia> sim_happiness(n_years=4, n_births=10)\n40×3 DataFrame\n Row │ age    happiness  married\n     │ Int64  Float64    Int64\n─────┼───────────────────────────\n   1 │     4  -2.0             0\n   2 │     4  -1.55556         0\n   3 │     4  -1.11111         0\n\n\n\n\n\n","category":"function"},{"location":"#simulate","page":"Functions","title":"simulate","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"simulate","category":"page"},{"location":"#StatisticalRethinking.simulate","page":"Functions","title":"StatisticalRethinking.simulate","text":"simulate\n\nUsed for counterfactual simulations.\n\nsimulate(df, coefs, var_seq)\n\n\nRequired arguments\n\n* `df`                                 : DataFrame with coefficient samples\n* `coefs`                              : Vector of coefficients\n* `var_seq`                            : Input values for simulated effect\n\nReturn values\n\n* `m_sim::NamedTuple`                  : Array with predictions\n\n\n\n\n\nsimulate\n\nCounterfactual predictions after manipulating a variable.\n\nsimulate(df, coefs, var_seq, coefs_ext)\n\n\nRequired arguments\n\n* `df`                                 : DataFrame with coefficient samples\n* `coefs`                              : Vector of coefficients\n* `var_seq`                            : Input values for simulated effect\n* `ext_coefs`                          : Vector of simulated variable coefficients\n\nReturn values\n\n* `(m_sim, d_sim)`                     : Arrays with predictions\n\n\n\n\n\nsimulate\n\nGeneric simulate of predictions using callable returning distribution to sample from.\n\nsimulate(df, rx_to_dist, xrange; return_dist, seed)\n\n\nRequired arguments\n\ndf::DataFrame: data frame with parameters in each row\nrx_to_dist::Function: callable with two arguments: row object and x value. Have to return Distribution instance.\nxrange: iterable with arguments\n\nOptional arguments\n\nreturn_dist::Bool = false: if set to true, distributions will be returned, not their samples\nseed::Int = missing: sets the random seed\n\nReturn value\n\nVector were each item is generated from every item in xrange argument. Each item is again a vector obtained from rx_to_dist call to obtain a distribution and then sample from it. If argument return_dist=true, sampling step will be omitted.\n\nExamples\n\njulia> using StatisticalRethinking, DataFrames, Distributions\n\njulia> d = DataFrame(:mu => [1.0, 2.0], :sigma => [0.1, 0.2])\n2×2 DataFrame\n Row │ mu       sigma\n     │ Float64  Float64\n─────┼──────────────────\n   1 │     1.0      0.0\n   2 │     2.0      0.0\n\njulia> simulate(d, (r,x) -> Normal(r.mu+x, r.sigma), 0:1)\n2-element Vector{Vector{Float64}}:\n [1.0, 2.0]\n [2.0, 3.0]\n\njulia> simulate(d, (r,x) -> Normal(r.mu+x, r.sigma), 0:1, return_dist=true)\n2-element Vector{Vector{Normal{Float64}}}:\n [Normal{Float64}(μ=1.0, σ=0.0), Normal{Float64}(μ=2.0, σ=0.0)]\n [Normal{Float64}(μ=2.0, σ=0.0), Normal{Float64}(μ=3.0, σ=0.0)]\n\n\n\n\n\n\n","category":"function"},{"location":"srgithub/#Github-organization","page":"StatisticalRethinkingJulia","title":"Github organization","text":"","category":"section"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"StatisticalRethinking.jl is part of the broader StatisticalRethinkingJulia Github organization.","category":"page"},{"location":"srgithub/#Why-a-StatisticalRethinking-v4?","page":"StatisticalRethinkingJulia","title":"Why a StatisticalRethinking v4?","text":"","category":"section"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"Over time more and better options become available to express the material covered in Statistical Rethinking. The most important (in my opinion!) is the use of KeyedArrays (provided by AxisKeys.jl) for the representation of mcmc chains.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"But other examples are the recently developed ParetoSmooth.jl used in the PSIS related examples and the preliminary work by SHMUMA on a better Dagitty.jl (vs. StructuralCausalModels.jl).","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"While StatisticalRethinking v3 focused on making StatisticalRethinking.jl mcmc package independendent, StatisticalRethinking v4 aims at de-coupling it from a specific graphical package and thus enables new choices for graphics, e.g. using Makie.jl and AlgebraOfGraphics.jl. ","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"Also, an attempt has been made to make StatisticalRethinking.jl fit better with the new setup of Pluto notebooks which keep track of used package versions in the notebooks themselves (see here).","category":"page"},{"location":"srgithub/#Workflow-of-StatisticalRethinkingJulia-(v4):","page":"StatisticalRethinkingJulia","title":"Workflow of StatisticalRethinkingJulia (v4):","text":"","category":"section"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"Data preparation, typically using CSV.jl, DataFrames.jl and some statistical methods from StatsBase.jl and Statistics.jl. In some cases simulations are used which need Distributions.jl and a few special methods (available in StatisticalRethinking.jl).\nDefine the mcmc model, e.g. using StanSample.jl or Turing.jl, and obtain draws from the model.\nCapture the draws for further processing. In Turing that is ususally done using MCMCChains.jl, in StanSample.jl v4 it's mostly in the form of KeyedArray chains (as stated above, obtained from AxisKeys.jl).\nInspect the chains using statistical and visual methods. In many cases this will need one or more statistical packages and one of the graphical options.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"Currently most visual options are StatsPlots/Plots based, e.g. in MCMCChains.jl and StatisticalRethinkingPlots.jl. The setup of StatisticalRethinking v4 enables the future introduction of a new package, StatisticalRethinkingMakie which will be based on Makie.jl and AlgebraOfGraphics.jl.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"The above 4 items could all be done by just using StanSample.jl or Turing.jl.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"The book Statistical Rethinking has a different objective and studies how models compare, how models can help (or mislead) and why multilevel modeling might help in some cases.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"For this, additional packages are available, explained and demonstrated, e.g. StructuralCausalModels.jl, ParetoSmooth.jl and quite a few more.","category":"page"},{"location":"srgithub/#Using-StatisticalRethinking-v4","page":"StatisticalRethinkingJulia","title":"Using StatisticalRethinking v4","text":"","category":"section"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"To work through the StatisticalRethinking book using Julia and Stan, download project SR2StanPluto.jl. ","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"To work through the StatisticalRethinking book using Julia and Turing, download project SR2TuringPluto.jl. ","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"Both projects create a Julia environment where most needed packages are available.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"In addition to providing a Julia package environment, these also contain chapter by chapter Pluto notebooks to work through the Statistical Rethinking book. ","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"In order to keep environment packages relatively simple (i.e. have a limited set of dependencies on other Julia packages) StatisticalRethinking consists of 2 layers, a top layer containing mcmc dependent methods (e.g. a model comparison method taking Turing.jl or StanSample.jl derived objects) which in turn call common methods in the bottom layer. The same applies for the graphic packages. This feature relies on Requires.jl and the mcmc dependent methods can be found in src/require directories.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"To tailor StatisticalRethinking.jl for Stan, use (in that order!):","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"using StanSample\nusing StatisticalRethinking","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"or, for Turing:","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"using Turing\nusing StatisticalRethinking","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"See the notebook examples.","category":"page"},{"location":"srgithub/#Structure-of-StatisticalRethinkingJulia-(v4):","page":"StatisticalRethinkingJulia","title":"Structure of StatisticalRethinkingJulia (v4):","text":"","category":"section"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"On a high level, the StatisticalRethinkingJulia ecosystem contains 4 layers:","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"The lowest layer provides mcmc methods, currently Turing.jl and StanSample.jl.\nCommon (mcmc independent) bottom layer in StatisticalRethinking (and StatisticalRethinkingPlots).\nMCMC dependent top layer in StatisticalRethinking (and StatisticalRethinkingPlots).\nChapter by chapter notebooks.","category":"page"},{"location":"srgithub/#Future-possible-projects","page":"StatisticalRethinkingJulia","title":"Future possible projects","text":"","category":"section"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"A start has been made with a similar project using Julia and Turing, but unfortunately only the first 5 chapters have been completed. I just don't have the time to continue to work and complete that project. Luckily there is an excellent other package, TuringModels.jl that contains a selection of the Statistical Rethinking models in Turing.jl's PPL. There is also Shuma which is another good starting point to use Turing.jl.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"Along similar lines, I would love to see a StatisticalRethinkingDHMC.jl, which could be a combination of Soss.jl and DynamicHMC.jl, and a StatisticalRethinkingMamba.jl!","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"If interested in either of these projects, please contact me!","category":"page"},{"location":"srgithub/#Some-background-info-on-previuos-versions","page":"StatisticalRethinkingJulia","title":"Some background info on previuos versions","text":"","category":"section"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"Given that Julia provides several very capable packages that support mcmc simulation, it only seemed appropriate to make StatisticalRethinking (v3) on Julia mcmc implementation independent.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"The availablility of DynamicHMC, the huge progress made by the Turing.jl team over the last 2 years, the introduction of Julia projects in addition to Julia packages, the novel approach to notebooks in Pluto.jl and the work by Karajan and currently Shuma were a few of the ideas that triggered exploring a new setup for StatisticalRethinking.jl and the 'course' projects StatistcalRethinkingStan and StatisticalrethinkingTuring.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"An early, experimental version of StructuralCausalModels.jl is also included as a dependency in the StatisticalRethinking.jl package. In the meantime I will definitely keep my eyes on Dagitty.jl, Omega.jl and CausalInference.jl. In particular Dagitty.jl has very similar objectives as StructuralCausalModels.jl and over time might replace it in the StatisticalRethinkingJulia ecosystem. For now, StructuralCausalModels does provide ways to convert DAGs to Dagitty and ggm formats.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"The in v3 added introduced dependency StatsModelComparisons.jl which provides PSIS and WAIC statistics for model comparison is deprecated in v4. For PSIS and LOO ParetoSmooth.jl is now used and WAIC has been moved to StatisticalRethinking.jl.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"Finally, for a good while I have been looking for a great statistics book using Julia as kind of an introductory text to StatisticalRethinking and I believe the first couple of chapters in an upcoming book Statistics with Julia by Yoni Nazarathy and Hayden Klok are exactly that.","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"As StatisticalRethinking v3/4 is also (DrWatson & Pkg) project based and uses Pluto notebooks, I have converted the book listings in the first 5 chapters to Pluto Notebooks in a new repository in StatisticalRethinkingJulia, i.e. StatisticsWithJuliaPlutoNotebooks. ","category":"page"},{"location":"srgithub/","page":"StatisticalRethinkingJulia","title":"StatisticalRethinkingJulia","text":"After chapter 4, Statistics with Julia follows the frequentionist approach while Statistical Rethinking opts for the Bayesian approach. Most of the material in chapters 5 and 6 of Statistics with Julia is therefore also covered using a more Bayesian perspective in the early chapters of the notebook projects SR2StanPluto and SR2TuringPluto. ","category":"page"}]
}
