# StatisticalRethinking

## Introduction

This package contains the Julia versions of the snippets contained in the R package "rethinking" associated with the book [Statisticasl Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

## Layout of the package

Instead of having all snippets in a single file, the snippets are organized by chapter and grouped into clips of related snippets. E.g. chapter 0 of the R package [rethinking](https://github.com/rmcelreath/rethinking) has snippets 0.1 to 0.5. These are divided over 2 clips:

1. `clip_01_03.jl` - contains snippets 0.1 through 0.3
2. `clip_04_05.jl` - contains snippets 0.4 and 0.5.

These 2 files are in chapters/00. These files are later on processed by Literate.jl to create 2 derived versions, e.g. from `clip_01_03.jl` in chapters/00:

1. `clip_01_03.md` - which is stored in docs/src and included in the documentation
2. `clip_01_03.ipynb` - stored in the notebooks directory for use in Jupyter

The intention is that when needed clips with names such as `clip_05_07t.jl`, `clip_05_07s.jl` and `clip_05_07m.jl` will show up. These will contain mcmc implementations using Turing.jl, CmdStan.jl and Mamba.jl respectively. Examples have been added to chapter 2.

Occasionally a clip contains a single snippet and will be refered to as `clip_02.jl`, e.g. in chapters/03

## Acknowledgements

Richard Torkar has taken the lead in developing the Turing versions of the models from chapter 8 onwards.

The TuringLang team and #turing contributors on Slack have been extremely helpful!

The mcmc components are based on:

1. [TuringLang](https://github.com/TuringLang)
2. [StanJulia](https://github.com/StanJulia)
3. [Mamba](https://github.com/brian-j-smith/Mamba.jl)



```@meta
CurrentModule = StatisticalRethinking
```

## `maximum_a_posteriori`
```@docs
maximum_a_posteriori(model, lower_bound, upper_bound)
```