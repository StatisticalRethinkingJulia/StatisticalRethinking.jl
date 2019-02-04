
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
    scriptentry("clip-08d.jl"),
    scriptentry("clip-08m.jl", exe = false, doc = false), 
    scriptentry("clip-08s.jl"),
    scriptentry("clip-08t.jl", exe = false, doc = true)
  ],
  "03" => [
    scriptentry("clip-01.jl"),
    scriptentry("clip-02-05.jl"),
    scriptentry("clip-05s.jl"),
    scriptentry("clip-06-16s.jl")
  ],
  "04" => [
    scriptentry("m4.1d.jl"),
    scriptentry("m4.1s.jl"),
    scriptentry("m4.2d.jl", exe = false, doc = false),
    scriptentry("m4.2s.jl", exe = false, doc = false),
    scriptentry("m4.2t.jl", exe = false, doc = true),
    scriptentry("m4.3s.jl", exe = false, doc = false),
    scriptentry("m4.4m.jl", exe = false, doc = false), 
    scriptentry("m4.4s.jl", exe = false, doc = false),
    scriptentry("m4.5d.jl"),
    scriptentry("m4.5d1.jl", exe = false, doc = false),
    scriptentry("m4.5s.jl"),
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
    scriptentry("m5.1d.jl"),
    scriptentry("m5.1s.jl"),
    scriptentry("m5.3d.jl", exe = false, doc = false),
    scriptentry("m5.3s.jl", exe = false, doc = false),
    scriptentry("m5.5s.jl", exe = false, doc = false),
    scriptentry("m5.6d.jl"),
    scriptentry("m5.6s.jl")
  ],
  "08" => [
    scriptentry("m8.1d.jl"),
    scriptentry("m8.1s.jl"),
    scriptentry("m8.1t.jl", exe = false, doc = true),
    scriptentry("m8.2s.jl", exe = false, doc = false),
    scriptentry("m8.2t.jl", exe = false, doc = false),
    scriptentry("m8.3s.jl", exe = false, doc = false),
    scriptentry("m8.3t.jl", exe = false, doc = true),
    scriptentry("m8.4s.jl", exe = false, doc = false),
    scriptentry("m8.4t.jl", exe = false, doc = false),
    scriptentry("m8.5s.jl"),
    scriptentry("m8.8s.jl")
  ],
  "10" => [
    scriptentry("m10.01s.jl"),
    scriptentry("m10.02d.jl"),
    scriptentry("m10.02s.jl"),
    scriptentry("m10.03t.jl", exe = false, doc = false),
    scriptentry("m10.04d.jl"),
    scriptentry("m10.04s.jl"),
    scriptentry("m10.04t.jl", exe = false, doc = false),
    scriptentry("m10.10t_c.jl", exe = false, doc = false),
    scriptentry("m10.10t.jl", exe = false, doc = false),
    scriptentry("m10.xxt.jl", exe = false, doc = false),
    scriptentry("m10.yyt.jl", exe = false, doc = false)
  ],
  "11" => [
    scriptentry("m11.5.jl", exe = false, doc = false)
  ],
  "12" => [
    scriptentry("m12.1t.jl", exe = false, doc = false),
    scriptentry("m12.2t.jl", exe = false, doc = false),
    scriptentry("m12.3t.jl", exe = false, doc = false),
    scriptentry("m12.4t.jl", exe = false, doc = false),
    scriptentry("m12.5t.jl", exe = false, doc = false),
    scriptentry("m12.6t.jl", exe = false, doc = false),
    scriptentry("m12.6d.jl"),
    scriptentry("m12.6s.jl"),
    scriptentry("m12.6s2.jl")
  ],
  "13" => [
    scriptentry("m13.2s.jl")
  ]
);
