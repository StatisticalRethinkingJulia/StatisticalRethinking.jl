var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "StatisticalRethinking",
    "title": "StatisticalRethinking",
    "category": "page",
    "text": ""
},

{
    "location": "#StatisticalRethinking-1",
    "page": "StatisticalRethinking",
    "title": "StatisticalRethinking",
    "category": "section",
    "text": "StatisticalRethinking is a Julia implementation of the code accompanying the book StatisticalRethinking.CurrentModule = StatisticalRethinking"
},

{
    "location": "#StatisticalRethinking.maximum_a_posteriori-Tuple{Any,Any,Any}",
    "page": "StatisticalRethinking",
    "title": "StatisticalRethinking.maximum_a_posteriori",
    "category": "method",
    "text": "maximumaposterior\n\nCompute the maximumaposteriori of a model. \n\nMethod\n\nmaximum_a_posteriori(model, lower_bound, upper_bound)\n\nRequired arguments\n\n* `model::Turing model`\n* `lower_bound::Float64`\n\nReturn values\n\n* `result`                       : Maximum_a_posterior vector\n\nExamples\n\nSee ...\n\n\n\n\n\n"
},

{
    "location": "#maximum_a_posteriori-1",
    "page": "StatisticalRethinking",
    "title": "maximum_a_posteriori",
    "category": "section",
    "text": "maximum_a_posteriori(model, lower_bound, upper_bound)"
},

{
    "location": "snippets_00_01_03/#",
    "page": "Chapter 0 snippets",
    "title": "Chapter 0 snippets",
    "category": "page",
    "text": "EditURL = \"https://github.com/TRAVIS_REPO_SLUG/blob/master/\""
},

{
    "location": "snippets_00_01_03/#Chapter-0-snippets-1",
    "page": "Chapter 0 snippets",
    "title": "Chapter 0 snippets",
    "category": "section",
    "text": ""
},

{
    "location": "snippets_00_01_03/#snippet-0.0-1",
    "page": "Chapter 0 snippets",
    "title": "snippet 0.0",
    "category": "section",
    "text": "Load Julia packages (libraries) needed  for the snippets in chapter 0using StatisticalRethinking\ngr(size=(300, 300))"
},

{
    "location": "snippets_00_01_03/#snippet-0.1-1",
    "page": "Chapter 0 snippets",
    "title": "snippet 0.1",
    "category": "section",
    "text": "println( \"All models are wrong, but some are useful.\" )"
},

{
    "location": "snippets_00_01_03/#snippet-0.2-1",
    "page": "Chapter 0 snippets",
    "title": "snippet 0.2",
    "category": "section",
    "text": "This is a StepRange, not a vectorx = 1:3\nx = x*10\nx = log.(x)\nx = sum(x)\nx = exp(x)\nx = x*10\nx = log(x)\nx = sum(x)\nx = exp(x)"
},

{
    "location": "snippets_00_01_03/#snippet-0.3-1",
    "page": "Chapter 0 snippets",
    "title": "snippet 0.3",
    "category": "section",
    "text": "log( 0.01^200 )\n200 * log(0.01)This page was generated using Literate.jl."
},

{
    "location": "snippets_00_04_05/#",
    "page": "Chapter 0 snippets",
    "title": "Chapter 0 snippets",
    "category": "page",
    "text": "EditURL = \"https://github.com/TRAVIS_REPO_SLUG/blob/master/\""
},

{
    "location": "snippets_00_04_05/#Chapter-0-snippets-1",
    "page": "Chapter 0 snippets",
    "title": "Chapter 0 snippets",
    "category": "section",
    "text": "Load Julia packages (libraries) needed"
},

{
    "location": "snippets_00_04_05/#snippet-0.0-1",
    "page": "Chapter 0 snippets",
    "title": "snippet 0.0",
    "category": "section",
    "text": "using StatisticalRethinking\ngr(size=(300, 300))"
},

{
    "location": "snippets_00_04_05/#snippet-0.4-1",
    "page": "Chapter 0 snippets",
    "title": "snippet 0.4",
    "category": "section",
    "text": "dataset(...) provides access to often used R datasets.cars = dataset(\"datasets\", \"cars\")If this is not a common R dataset, use e.g.: howell1 = CSV.read(joinpath(ProjDir, \"..\", \"..\",  \"data\", \"Howell1.csv\"), delim=\';\') df = convert(DataFrame, howell1)This reads the Howell1.csv dataset in the data subdirectory of this package,  StatisticalRethinking.jl. See also the chapter 4 snippets.Fit a linear regression of distance on speedm = lm(@formula(Dist ~ Speed), cars)estimated coefficients from the modelcoef(m)Plot residuals against speedfig1 = scatter( cars[:Speed], residuals(m),\n  xlab=\"Speed\", ylab=\"Model residual values\", lab=\"Model residuals\")Save the plot"
},

{
    "location": "snippets_00_04_05/#snippet-0.5-1",
    "page": "Chapter 0 snippets",
    "title": "snippet 0.5",
    "category": "section",
    "text": "Thie contents of this snipper is partially replaced by snippet 0.0. If any of these packages is not installed in your Julia system, you can add it by e.g. Pkg.add(\"RDatasets\")This page was generated using Literate.jl."
},

{
    "location": "snippets_02_01_02/#",
    "page": "Chapter 2 snippets",
    "title": "Chapter 2 snippets",
    "category": "page",
    "text": "EditURL = \"https://github.com/TRAVIS_REPO_SLUG/blob/master/\""
},

{
    "location": "snippets_02_01_02/#Chapter-2-snippets-1",
    "page": "Chapter 2 snippets",
    "title": "Chapter 2 snippets",
    "category": "section",
    "text": ""
},

{
    "location": "snippets_02_01_02/#snippet-2.0-1",
    "page": "Chapter 2 snippets",
    "title": "snippet 2.0",
    "category": "section",
    "text": "Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300))snippet 2.1@show ways  = [0  , 3 , 8 , 9 , 0 ];\n@show ways/sum(ways)snippet 2.2@show d = Binomial(9, 0.5);\n@show pdf(d, 6)This page was generated using Literate.jl."
},

{
    "location": "snippets_02_03_05/#",
    "page": "Chapter 2 snippets",
    "title": "Chapter 2 snippets",
    "category": "page",
    "text": "EditURL = \"https://github.com/TRAVIS_REPO_SLUG/blob/master/\""
},

{
    "location": "snippets_02_03_05/#Chapter-2-snippets-1",
    "page": "Chapter 2 snippets",
    "title": "Chapter 2 snippets",
    "category": "section",
    "text": ""
},

{
    "location": "snippets_02_03_05/#snippet-2.0-1",
    "page": "Chapter 2 snippets",
    "title": "snippet 2.0",
    "category": "section",
    "text": "Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300))snippet 2.3define gridp_grid = range( 0 , stop=1 , length=20 )define priorprior = ones( 20 )compute likelihood at each value in gridlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]compute product of likelihood and priorunstd_posterior = likelihood .* priorstandardize the posterior, so it sums to 1posterior = unstd_posterior  ./ sum(unstd_posterior)snippet 2.4p1 = plot( p_grid , posterior ,\n    xlab=\"probability of water\" , ylab=\"posterior probability\",\n    lab = \"interpolated\", title=\"20 points\" )\np2 = scatter!( p1, p_grid , posterior, lab=\"computed\" )\n\nsavefig(\"s2_4.pdf\")snippet 2.5prior1 = [p < 0.5 ? 0 : 1 for p in p_grid]\nprior2 = [exp( -5*abs( p - 0.5 ) ) for p in p_grid]\n\np3 = plot(p_grid, prior1,\n  xlab=\"probability of water\" , ylab=\"posterior probability\",\n  lab = \"semi_uniform\", title=\"Other priors\" )\np4 = plot!(p3, p_grid, prior2,  lab = \"double_exponential\" )\n\nsavefig(\"s2_5.pdf\")This page was generated using Literate.jl."
},

{
    "location": "snippets_02_06_07/#",
    "page": "Chapter 2 snippets",
    "title": "Chapter 2 snippets",
    "category": "page",
    "text": "EditURL = \"https://github.com/TRAVIS_REPO_SLUG/blob/master/\""
},

{
    "location": "snippets_02_06_07/#Chapter-2-snippets-1",
    "page": "Chapter 2 snippets",
    "title": "Chapter 2 snippets",
    "category": "section",
    "text": ""
},

{
    "location": "snippets_02_06_07/#snippet-2.0-1",
    "page": "Chapter 2 snippets",
    "title": "snippet 2.0",
    "category": "section",
    "text": "Load Julia packages (libraries) neededusing StatisticalRethinking\ngr(size=(600,300))snippet 2.6 (see snippet 3_2 for explanations)p_grid = range(0, step=0.001, stop=1)\nprior = ones(length(p_grid))\nlikelihood = [pdf(Binomial(9, p), 6) for p in p_grid]\nposterior = likelihood .* prior\nposterior = posterior / sum(posterior)\n\nsamples = sample(p_grid, Weights(posterior), length(p_grid))\n\np = Vector{Plots.Plot{Plots.GRBackend}}(undef, 2)\n\np[1] = scatter(1:length(p_grid), samples, markersize = 2, ylim=(0.0, 1.3), lab=\"Draws\")analytical calculationw = 6\nn = 9\nx = 0:0.01:1\np[2] = density(samples, ylim=(0.0, 5.0), lab=\"Sample density\")\np[2] = plot!( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( p[2], x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")\nplot(p..., layout=(1, 2))\nsavefig(\"s2_6.pdf\")snippet 2.7 analytical calculationw = 6\nn = 9\nx = 0:0.01:1\nplot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), lab=\"Conjugate solution\")quadratic approximationplot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab=\"Normal approximation\")\nsavefig(\"s2_7.pdf\")snippet 2.8 The example is in stanglobetoss.jlThis page was generated using Literate.jl."
},

]}
