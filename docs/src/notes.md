# Notes

1. In the `src` directory is a file scriptentry.jl which defines an object `script_dict` which is used to control the generation of documentation, notebooks and .jl scripts in chapters and testing of the notebooks. Output from CmdStan scripts are automatically inserted in the documentation. For Turing scripts this needs to be done manually by executing the notebook, exporting the results as .md files (and .svg files if graphics are generated) and copy these to `docs/src/nn`, where nn is the chapter. See `?ScriptEntry` or enter e.g. `script_dict["02"]` in the REPL.

2. The Mamba examples should really use `@everywhere using Mamba` in stead of `using Mamba`. This was done to get around a limitation in Literate.jl to test the notebooks when running in distributed mode. 

