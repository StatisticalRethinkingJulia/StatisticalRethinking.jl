# Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8.

The TuringLang team and #turing contributors on Slack have been extremely helpful! The Turing examples by Cameron Pfiffer have been a great help and followed closely in several example scripts.

The mcmc components are based on:

1. [TuringLang](https://github.com/TuringLang)
2. [StanJulia](https://github.com/StanJulia)
3. [Mamba](https://github.com/brian-j-smith/Mamba.jl)

At least 2 other mcmc options are available for mcmc in Julia:

4. [DynamicHMC](https://github.com/tpapp/DynamicHMC.jl)
5. [Klara](https://github.com/JuliaStats/Klara.jl)

Time constraints prevents inclusion of those right now, although e.g. the example `chapters/04/clip_38.1m.jl` almost begs for a `clip_38d.jl`. For now the linear regression example in  [DynamicHMCExamples](https://tpapp.github.io/DynamicHMCExamples.jl/latest/example_linear_regression/) is a good starting point.

The Mamba examples should really use `@everywhere using Mamba` in stead of `using Mamba`. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode.

The  documentation has been generated using Literate.jl based on several ideas demonstrated by Tamas Papp in above mentioned  [DynamicHMCExamples.jl](https://tpapp.github.io/DynamicHMCExamples.jl).
