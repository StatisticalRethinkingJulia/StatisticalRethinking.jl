## Installation

This package can be installed from the REPL as follows:

```
] add StatisticalRethinking
[del] 
```

While working through the book/snippets I suggest:

```
] dev StatisticalRethinking
```

This puts the package source code in your development subdirectory which I find is easier to use from within an editor.

In `scripts/00/install_packages.jl` is a scripts that installs all additional library packages needed to run the scripts in StatisticalRethinking.

The installation of the necessary glue code for these packages is triggered by Requires.jl. This is not ideal in that the documentation for the glue code functions is only available online (e.g. in the REPL).
