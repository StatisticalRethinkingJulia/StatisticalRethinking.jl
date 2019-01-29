# Versions

Developing `rethinking` must have been an on-going process over several years, `StatisticalRethinkinh.jl` will likely follow a similar path.

1. The initial version (v1) of `StatisticalRethinking` is really just a first attempt to capture the models and show ways of setting up those models, execute the models and post-process the results using Julia.

2. A second objective of v1 is to experiment and compare the four used mcmc options in Julia in terms of results, performance, ease of expressing models, etc.

3. The R package `rethinking`, in the experimental branch on Github, contains 2 functions `quap` and `ulam` (previously called `map` and `map2stan`) which are not in v1 of `Statisticalrethinking.jl`. It is my *intention* to study those and _possibly_ include `quap` or `ulam` (or both) in a future of `Statisticalrethinking`.

4. Several other interesting approaches that could become a good basis for such an endeavour are being explored in Julia, e.g. Soss.jl and Omega.jl.

5. Many other R functions such as precis(), link(), shade(), etc. are not in v1, although some very early versions are being tested. Expect refactoring of those in future versions.
