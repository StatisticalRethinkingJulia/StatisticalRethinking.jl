# StatisticalRethinking

This package will contain Julia versions of selected code snippets contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

In the book and associated R package `rethinking`, statistical models are defined as illustrated below:

```
m4.3 <- map(
    alist(
        height ~ dnorm( mu , sigma ) ,
        mu <- a + b*weight ,
        a ~ dnorm( 156 , 100 ) ,
        b ~ dnorm( 0 , 10 ) ,
        sigma ~ dunif( 0 , 50 )
    ) ,
    data=d2
)
```

The author states: "*If that (the statistical model) doesn't make much sense, good. ... you're holding the right textbook, since this book teaches you how to read and write these mathematical descriptions*"  (page 77).

This package is intended to allow experimenting with this learning process using 3 available mcmc options in Julia.

## Layout of the package

Instead of having all snippets in a single file, the snippets are organized by chapter and grouped in clips by related snippets. E.g. chapter 0 of the R package has snippets 0.1 to 0.5. Those have been combined into 2 clips:

1. `clip_01_03.jl` - contains snippets 0.1 through 0.3
2. `clip_04_05.jl` - contains snippets 0.4 and 0.5.

These 2 files are in chapters/00. These files are later on processed by Literate.jl to create 2 derived versions, e.g. from `clip_01_03.jl` in chapters/00:

1. `clip_01_03.md` - included in the documentation
2. `clip_01_03.ipynb` - stored in the notebooks directory for use in Jupyter

Occasionally a clip will contain just a single snippet and will be referred to as `03/clip_02.jl`. 

Clips with names such as `02/clip_08t.jl`, `clip_08s.jl` and `clip_08m.jl` contain mcmc implementations using Turing.jl, CmdStan.jl and Mamba.jl respectively. Examples have been added to chapter 2.

From chapter 8 onwards, the **Turing** versions of the mcmc models are available as e.g. `chapters/08/m8.1t.jl`. Equivalent **CmdStan** versions and, in a few cases **Mamba** models, are provided as well.

Almost identical clips are named e.g. `04/clip_07.0s.jl` and `04/clip_07.1s.jl`. In that specific example just the priors differ.

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

Time constraints prevents inclusion of those right now, although e.g. the example `chapters/04/clip_38.1m.jl` almost begs for a `clip_38d.jl`. For now the linear regression example in  [DynamicHMCExamples](https://tpapp.github.io/DynamicHMCExamples.jl/latest/example_linear_regression/) is a good starting point.

As a final note, the Mamba examples should really use `@everywhere using Mamba` in stead of `using Mamba`. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode.


```@meta
CurrentModule = StatisticalRethinking
```

## `maximum_a_posteriori`
```@docs
maximum_a_posteriori(model, lower_bound, upper_bound)
```