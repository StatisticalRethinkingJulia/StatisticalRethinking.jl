# StatisticalRethinking

## Introduction

This package will contain Julia versions of selected code snippets contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

In the book, the author states: "*If that (a model) doesn't make much sense, good. ... you're holding the right textbook, since this book teaches you how to read and write these mathematical descriptions*". This package allows experimenting with this learning process using 3 available mcmc options in Julia.

The intention is that when needed clips with names such as `02/clip_08t.jl`, `clip_08s.jl` and `clip_08m.jl` will show up. These will contain mcmc implementations using Turing.jl, CmdStan.jl and Mamba.jl respectively. Examples have been added to chapter 2.

Occasionally a clip will contain just a single snippet and will be referred to as `03/clip_02.jl`. Almost identical models are named e.g. `04/clip_07.0s.jl` and `04/clip_07.1s.jl`. In that example just the priors differ.

From chapter 8 onwards, the **Turing** versions of the mcmc models are available as e.g. chapters/08/m8.1t.jl. Equivalent **CmdStan** versions and, in a few cases **Mamba** models, are provided as well.

## Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models in chapter 8.

The TuringLang team and #turing contributors on Slack have been extremely helpful!

The mcmc components are based on:

1. [TuringLang](https://github.com/TuringLang)
2. [StanJulia](https://github.com/StanJulia)
3. [Mamba](https://github.com/brian-j-smith/Mamba.jl)

At least 2 other mcmc options are available for mcmc in Julia:

4. [DynamicHMC](https://github.com/tpapp/DynamicHMC.jl)
5. [Klara](https://github.com/JuliaStats/Klara.jl)

Time constraints prevents inclusion of those right now, although e.g. the example `chapters/04/clip_38.1m.jl` almost begs for a `clip_38d.jl'. For now the linear regression example in  [DynamicHMCExamples](https://tpapp.github.io/DynamicHMCExamples.jl/latest/example_linear_regression/) is a good starting point.

As a final note, the Mamba examples should really use `@everywhere using Mamba` in stead of `using Mamba`. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode.


```@meta
CurrentModule = StatisticalRethinking
```

## `maximum_a_posteriori`
```@docs
maximum_a_posteriori(model, lower_bound, upper_bound)
```