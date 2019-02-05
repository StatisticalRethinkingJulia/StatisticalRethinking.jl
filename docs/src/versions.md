## Versions & notes

Developing `rethinking` must have been an on-going process over several years, `StatisticalRethinkinh.jl` will likely follow a similar path.

1. The initial version (v1) of `StatisticalRethinking` is really just a first attempt to capture the models and show ways of setting up those models, execute the models and post-process the results using Julia.

2. As mentioned above, a second objective of v1 is to experiment and compare the four selected mcmc options in Julia in terms of results, performance, ease of expressing models, etc.

3. The R package `rethinking`, in the experimental branch on Github, contains 2 functions `quap` and `ulam` (previously called `map` and `map2stan`) which are not in v1 of `Statisticalrethinking.jl`. It is my *intention* to study those and _possibly_ include `quap` or `ulam` (or both) in a future of `Statisticalrethinking`.

4. Several other interesting approaches that could become a good basis for such an endeavour are being explored in Julia, e.g. Soss.jl and Omega.jl.

5. Many other R functions such as precis(), link(), shade(), etc. are not in v1, although some very early versions are being tested. Expect significant refactoring of those in future versions.

6. The Mamba examples should really use `@everywhere using Mamba` in stead of `using Mamba`. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode. 

7. In the `src` directory of all packages is a file scriptentry.jl which defines an object `script_dict` which is used to control the generation of documentation, notebooks and .jl scripts in chapters and testing of the notebooks. See `?ScriptEntry` or enter e.g. `script_dict["02"]` in the REPL. In the model packages this file is suffixed by an indication of the used mcmc option. e.g. `script_dict_d` in DynamicHMCModels.

8. A utility function, generate() is part of each package to regenerate notebooks and chapter scripts, please see ?generate. Again, e.g. `generate_t` in TuringModels generates all model notebooks and chapter scripts for Turing models.

9. In a similar fashion, borrowed from DynamicHMCExamples I define several variations on `rel_path()`. By itself, `rel_path()` points at the scr directory of StatisticalRethinking.jl and e.g. `rel_path_s()` points to the src directory of StanModels. The `rel_path()` version is typically used to read in data files. All others are used to locate directorres to read from or store generated files into.

