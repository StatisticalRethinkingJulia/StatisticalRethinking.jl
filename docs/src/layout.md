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
