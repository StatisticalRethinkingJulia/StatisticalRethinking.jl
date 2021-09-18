module StatisticalRethinking

using Requires

using StatsBase, Statistics
using LinearAlgebra, Random
using AxisKeys, DataFrames
using NamedArrays, StatsFuns
using NamedTupleTools
using PrettyTables, Unicode
using ParetoSmooth, StructuralCausalModels
using MonteCarloMeasurements
using KernelDensity

import StatsBase: sample
import DataFrames: DataFrame
import MonteCarloMeasurements: Particles

using DocStringExtensions: SIGNATURES, FIELDS, TYPEDEF

function __init__()
  @require Turing="fce5fe82-541a-59a6-adf8-730c64b5f9a0" include("require/turing/turing.jl")
  @require StanSample="c1514b29-d3a0-5178-b312-660c88baa699" include("require/stan/stan.jl")
  @require LogDensityProblems="6fdf6af0-433a-55f7-b3ed-c6c6e0b8df7c" include("require/dhmc/dhmc.jl")
  #@require MCMCChains="c7f686f2-ff18-58e9-bc7b-31028e88f75d" include("require/mcmcchains/mcmcchains.jl")
end

const src_path = @__DIR__
const SR = StatisticalRethinking

"""

# sr_path

Relative path using the StatisticalRethinking src/ directory.

### Example to get access to the data subdirectory
```julia
sr_path("..", "data")
```

Note that in the projects, e.g. StatisticalRethinkingStan.jl and StatisticalRethinkingTuring.jl, the
DrWatson approach is a better choics, i.e: `sr_datadir(filename)`

"""
sr_path(parts...) = normpath(joinpath(src_path, parts...))

# DrWatson extension
"""

# sr_datadir

Relative path using the StatisticalRethinking src/ directory.

### Example to access `Howell1.csv` in StatisticalRethinking:
```julia
df = CSV.read(sr_datadir("Howell1.csv"), DataFrame)
```
"""
sr_datadir(parts...) = sr_path("..", "data", parts...)

include("scale.jl")                    # Rename to standardize of zscore?
include("rescale.jl")
include("link.jl")
include("hpdi.jl")
include("sample_dataframe.jl")
include("precis.jl")
include("simulate.jl")
include("srtools.jl")
include("sim_happiness.jl")
include("pluto_helpers.jl")
include("sim_train_test.jl")
include("lppd.jl")
include("logprob.jl")
include("compare_models.jl")
include("hmc.jl")
include("pk_qualify.jl")
include("waic.jl")
include("quap.jl")

export
  sr_path,
  sr_datadir,
  SR

end # module
