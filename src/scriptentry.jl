
"""

# ScriptEntry

Define processing requirements for chapter scripts

### Constructor
```julia
scriptentry(scriptfile;; nb=true, exe=true, doc=true)
```

### Required arguments
```julia
* `scriptfile::AbstractString`        : Script file
```

### Optional arguments
```julia
* `nb::Bool`      : Generate a notebook version in notebooks directory
* `exe::Bool`     : Execute the notebook (for testing or documentation purposes)
* `doc::Bool`     : Insert documention into Github pages
```

If exe = false and doc = true it is assumed the appropriate .md files
have been manually created and stored in docs/src/_nn_/... (Travis
will terminate if runs take too long).

"""
struct ScriptEntry
  scriptfile::AbstractString
  nb::Bool
  exe::Bool
  doc::Bool
end

"""

# scriptentry

Constructor for ScriptEntry objects.

### Constructor
```julia
scriptentry(scriptfile;; nb=true, exe=true, doc=true)
```

### Required arguments
```julia
* `scriptfile::AbstractString`        : Script file
```

### Optional arguments
```julia
* `nb::Bool`      : Generate a notebook version in notebooks directory
* `exe::Bool`     : Execute the notebook (for testing or documentation purposes)
* `doc::Bool`     : Insert documention into Github pages
```

If exe = false and doc = true it is assumed the appropriate .md files
have been manually created and stored in docs/src/_nn_/... (Travis
will terminate if runs take too long).

"""
scriptentry(scriptfile; nb=true, exe=true, doc=true) = ScriptEntry(scriptfile, nb, exe, doc)

script_dict = DataStructures.OrderedDict{AbstractString, Vector{ScriptEntry}}(
  "00" => [
    scriptentry("clip-01-03.jl"),
    scriptentry("clip-04-05.jl")
  ],
  "02" => [
    scriptentry("clip-01-02.jl"),
    scriptentry("clip-03-05.jl"),
    scriptentry("clip-06-07.jl"),
    scriptentry("clip-08.jl"),
    scriptentry("m2.1s.jl")
  ],
  "03" => [
    scriptentry("clip-01.jl"),
    scriptentry("clip-02-05.jl"),
    scriptentry("clip-05s.jl"),
    scriptentry("clip-06-10.jl"),
    scriptentry("clip-11-16.jl"),
    scriptentry("clip-17s.jl")
  ],
  "04" => [
    scriptentry("m4.1s.jl"),
    scriptentry("clip-01-06.jl"),
    scriptentry("clip-07-13s.jl"),
    scriptentry("clip-14-20.jl"),
    scriptentry("clip-21-23.jl"),
    scriptentry("clip-24-29s.jl"),
    scriptentry("clip-30s.jl"),
    scriptentry("clip-38s.jl"),
    scriptentry("clip-43s.jl"),
    scriptentry("clip-45-47s.jl"),
    scriptentry("clip-48-54s.jl")
  ],
  "05" => [
    scriptentry("clip-01-05s.jl"),
    scriptentry("clip-06-10s.jl")
   ],
  "09" => [
    scriptentry("clip-01.jl"),
    scriptentry("clip-02.jl")
  ]
);
